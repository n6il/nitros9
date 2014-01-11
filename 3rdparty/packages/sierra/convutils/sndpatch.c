/***********************************************************************************
* Program Name : sndpatch										                   *
* Description  : Replaces sounds of an AGI game with the ones in the specified     *
*                directory.                                                        *
* Author       : Guillaume Major												   *
* Date         : July 18, 2006													   *
* License      : Freeware. Do whatever you want with it!						   *
***********************************************************************************/

#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <io.h>
#include <direct.h>
#include <windows.h>

/* VOL directory entry structure */
struct DIRECTORY_ENTRY {
	unsigned char	byte1;
	unsigned char	byte2;
	unsigned char	byte3;
};

/* Global variables */
char sGamePath[MAX_PATH], sSoundPath[MAX_PATH];

/* Function prototypes */
void PatchSound(unsigned int iVolFile, unsigned int iSndNum, unsigned int iSndPos);
void ShowUsage();

/* Main */
int main(int argc, char **argv) {

	FILE *sndDir;
	char sSndDir[MAX_PATH];
	unsigned int iSndNum, iVolFile, iSndPos;
	struct DIRECTORY_ENTRY dir;
			
	printf("\n");
	printf("sndpatch AGI sound resources patcher\n");
	printf("Version 1.0 (July 2006)\n\n");

	if (argc < 2) {
		ShowUsage();
	}
	
	if (argc < 3) {
		sGamePath[0] = '\0';
		strncpy(sSoundPath, argv[1], MAX_PATH); 
	}
	else {
		strncpy(sGamePath, argv[1], MAX_PATH);
		strncpy(sSoundPath, argv[2], MAX_PATH);
	}

	/* Get the full path of sndDir */
	if (sGamePath[0] != '\0')
		sprintf(sSndDir, "%s\\sndDir", sGamePath);
	else
		strncpy(sSndDir, "sndDir", 7);

	/* Open sndDir file */
	if ((sndDir = fopen(sSndDir, "rb")) == NULL) {
		perror("Error opening sndDir file");
		exit(1);
	}

	iSndNum = 0;

	/* Loop through the sndDir file to replace sounds */
	while (!ferror(sndDir) && !feof(sndDir) && fread(&dir, sizeof(dir), 1, sndDir)) {
		/* Verify if the sound resources exists */
		if (dir.byte1 != 0xFF) {
			iVolFile = (dir.byte1 >> 4);
			iSndPos = ((dir.byte1 & 0x0F) << 16) + (dir.byte2 << 8) + dir.byte3;
			PatchSound(iVolFile, iSndNum, iSndPos);
		}
		iSndNum++;
	}
									
	printf("Done!\n\n");

	/* Exit normally */	
	exit(0);
}

/* Replaces the sound number specified in the VOL file */
void PatchSound(unsigned int iVolFile, unsigned int iSndNum, unsigned int iSndPos) {

	FILE *sndFile, *volFile;
	char sSndFile[MAX_PATH], sVolFile[MAX_PATH];
	unsigned short iSndSize, iVolSndSize;
	char acBuffer[4096];

	printf("Patching sound.%03i\n", iSndNum);
	
	/* Get the sound file name */
	if (sSoundPath[0] != '\0')
	  sprintf(sSndFile, "%s\\sound.%03i", sSoundPath, iSndNum);
	else
	  sprintf(sSndFile, "sound.%03i", iSndNum);
	
	/* Open the sound file for reading */
	if ((sndFile = fopen(sSndFile, "rb")) == NULL) {
		perror("Error opening sound file");
		exit(1);
	}
	
	/* Get the VOL file name */
	if (sGamePath[0] != '\0') 
      sprintf(sVolFile, "%s\\vol.%i", sGamePath, iVolFile);
	else 
	  sprintf(sVolFile, "vol.%i", iVolFile);

	/* Open the VOL file for writing */
	if ((volFile = fopen(sVolFile, "r+b")) == NULL) {
		perror("Error opening VOL file");
		exit(1);
	}

	/* Read the entire sound file into the buffer */
	fseek(sndFile, 0, SEEK_SET);
	iSndSize = fread(acBuffer, sizeof(char), sizeof(acBuffer), sndFile);

	/* Check if the new sound will fit in the VOL file */
	fseek(volFile, iSndPos + 3, SEEK_SET);
	fread(&iVolSndSize, sizeof(unsigned short), 1, volFile);
	if (iSndSize > iVolSndSize) {
		printf("Not enough space in the VOL file for sound.%03i!\n"
		       "Sound size: %i Space available: %i\n", iSndNum, iSndSize, iVolSndSize);
		exit(1);								  
	}
		
	/* Modify the size of the sound file in the header */
	fseek(volFile, iSndPos + 3, SEEK_SET);
	fwrite(&iSndSize, sizeof(unsigned short), 1, volFile);

	/* Write the sound file in the VOL file */
	fwrite(acBuffer, sizeof(char), iSndSize, volFile);

	/* Close files */
	fclose(volFile);
	fclose(sndFile);

}

/* Shows usage */
void ShowUsage() {

	printf("Usage: sndpatch [game-path] sound-path\n");

	/* Exit normally */		
	exit(0);

}
