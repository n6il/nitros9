/***********************************************************************************
* Program Name : picpatch										                   *
* Description  : Removes the Plot command (0xFA) from all the pictures to make     *
*                them compatible with the coco AGI interpreter.                    *
* Author       : Guillaume Major												   *
* Date         : July 19, 2006													   *
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
char sGamePath[MAX_PATH];

/* Function prototypes */
void PatchPicture(unsigned int iVolFile, unsigned int iPicNum, unsigned int iPicPos);
void ShowUsage();

/* Main */
int main(int argc, char **argv) {

	FILE *picDir;
	char sPicDir[MAX_PATH];
	unsigned int iPicNum, iVolFile, iPicPos;
	struct DIRECTORY_ENTRY dir;
			
	printf("\n");
	printf("picpatch AGI picture resources patcher\n");
	printf("Version 1.0 (July 2006)\n\n");

	if (argc < 2) {
		ShowUsage();
	}
	else {
		strncpy(sGamePath, argv[1], MAX_PATH);
	}

	/* Get the full path of picDir */
	sprintf(sPicDir, "%s\\picDir", sGamePath);

	/* Open picDir file */
	if ((picDir = fopen(sPicDir, "rb")) == NULL) {
		perror("Error opening picDir file");
		exit(1);
	}

    /* Initialize the picture counter */
	iPicNum = 0;

	/* Loop through the picDir file to remove plot commands */
	while (!ferror(picDir) && !feof(picDir) && fread(&dir, sizeof(dir), 1, picDir)) {
		/* Verify if the picture resource exists */
		if (dir.byte1 != 0xFF) {
			iVolFile = (dir.byte1 >> 4);
			iPicPos = ((dir.byte1 & 0x0F) << 16) + (dir.byte2 << 8) + dir.byte3;
			PatchPicture(iVolFile, iPicNum, iPicPos);
		}
		iPicNum++;
	}
									
	printf("Done!\n\n");

	/* Exit normally */	
	exit(0);
}

/* Patch the picture number specified in the VOL file */
void PatchPicture(unsigned int iVolFile, unsigned int iPicNum, unsigned int iPicPos) {

	FILE *volFile;
	char sVolFile[MAX_PATH];
	unsigned short iPicSize = 0;
	unsigned char acBuffer[16184];
	unsigned char cChar;
	BOOL bSkip = FALSE;

	printf("Patching picture.%03i\n", iPicNum);
	
	/* Get the VOL file name */
    sprintf(sVolFile, "%s\\vol.%i", sGamePath, iVolFile);

	/* Open the VOL file for writing */
	if ((volFile = fopen(sVolFile, "r+b")) == NULL) {
		perror("Error opening VOL file");
		exit(1);
	}

	/* Skip the resource header */
	fseek(volFile, iPicPos + 5, SEEK_SET);

	while (!ferror(volFile) && !feof(volFile) && fread(&cChar, sizeof(unsigned char), 1, volFile) && cChar != 0xFF) {
		if ((cChar & 0xF0) == 0xF0) {
			bSkip = FALSE;
		}
		if (bSkip == FALSE) {
			if (cChar != 0xFA) {
				acBuffer[iPicSize] = cChar;
				iPicSize++;
			}
			else {
				bSkip = TRUE;		
			}
		}
	}
			
	/* Add 0xFF to the buffer */
	acBuffer[iPicSize] = 0xFF;
	iPicSize++;
	
	/* Modify the size of the picture in the header */
	fseek(volFile, 0, SEEK_SET);
	fwrite(&iPicSize, sizeof(unsigned short), 1, volFile);

	/* Write the buffer in the VOL file */
	fwrite(acBuffer, sizeof(char), iPicSize, volFile);
	
	/* Close the VOL file */
	fclose(volFile);

}

/* Shows usage */
void ShowUsage() {

	printf("Usage: picpatch game-path\n");

	/* Exit normally */		
	exit(0);

}
