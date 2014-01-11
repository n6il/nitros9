/***********************************************************************************
* Program Name : cc3snd											                   *
* Description  : Converts AGI sounds for the AGI Coco interpreter.                 *
* Author       : Guillaume Major												   *
* Date         : July 18, 2006													   *
* License      : Freeware. Do whatever you want with it!						   *
***********************************************************************************/

#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <io.h>
#include <direct.h>
#include <windows.h>

/* Be sure to set the struct member alignment at 1 in the compiler settings */

/* AGI sound format */
struct MUSIC_NOTE {
	unsigned short	duration;
	unsigned char	tone_2;
	unsigned char	tone_1;
	unsigned char	attenuation;
};

/* Coco AGI sound format */					  
struct COCO_MUSIC_NOTE {
	unsigned char	tone;
	unsigned char	volume; /* 0x00: Silence, 0x3F: Full volume */
	unsigned char	unused;
	unsigned char	duration;
};

/* Coco tone frequencies. The position of the freqency in the table gives the coco tone number. */
unsigned short COCO_TONES_TABLE[] = {
	 130,  138,  146,  155,  164,  174,  184,  195,  207,  220,  233,  246, // O3
	 261,  277,  293,  311,  329,  349,  369,  391,  415,  440,  466,  493, // O4
	 523,  554,  587,  622,  659,  698,  739,  783,  830,  880,  932,  987, // O5
	1046, 1108, 1174, 1244, 1318, 1396, 1479, 1567, 1661, 1760, 1864, 1975, // O6
	2093, 2217, 2349, 2489, 2637, 2793, 2959, 3135, 3322, 3520, 3729, 3951  // O7
};

/* Function prototypes */
unsigned char GetCocoTone(unsigned short uiFreq);
void ConvertSound(char *sInFile, char *sOutFile);
void ShowUsage();

/* Main */
int main(int argc, char **argv) {

	char sInFile[MAX_PATH], sOutFile[MAX_PATH];
	char sInPath[MAX_PATH], sOutPath[MAX_PATH];
	char sFullPath[MAX_PATH];

	long hFind;
	struct _finddata_t finddata;

	printf("\n");
	printf("cc3snd AGI sound resource converter for the Coco\n");
	printf("Version 1.0 (July 2006)\n\n");

	if (argc < 2) {
		ShowUsage();
	}

	if (strcmp(argv[1], "-b") == 0 || strcmp(argv[1], "-B") == 0) {
		if (argc < 3) {
			ShowUsage();
		}
		else if (argc < 4) {
			sInPath[0] = '\0';
			strncpy(sOutPath, argv[2], MAX_PATH);
		}
		else {
			strncpy(sInPath, argv[2], MAX_PATH);
			strncpy(sOutPath, argv[3], MAX_PATH);
		}
		/* Get the list of files */
		if (sInPath[0] != '\0')
		  sprintf(sFullPath, "%s\\sound.???", sInPath);
		else
		  strncpy(sFullPath, "sound.???", 10);
		hFind = _findfirst(sFullPath, &finddata);
		if (hFind > -1) {
			/* Make sure the output path exists */
			_mkdir(sOutPath);
			/* Loop through the sound files */
			do {
				if (!(finddata.attrib & _A_SUBDIR) ) {
					if (sInPath[0] != '\0')
						sprintf(sInFile, "%s\\%s", sInPath, finddata.name);
					else
						strncpy(sInFile, finddata.name, strlen(finddata.name)+1);
					sprintf(sOutFile, "%s\\%s", sOutPath, finddata.name);
					ConvertSound(sInFile, sOutFile);
				}
				else {
					printf("Skipping directory %s.\n", finddata.name);
				}
			}
			while (_findnext(hFind, &finddata) > -1);
			_findclose(hFind);
		}
		else {
			printf("No SOUND file was found! The sound files name must match this format: sound.xxx where xxx is the number of the sound.\n");
			exit(1);
		}
	} 
	else {
		if (argc < 2) {
			ShowUsage();
		}
		else {
			strncpy(sInFile, argv[1], MAX_PATH);
			if (argc < 3) {
				sprintf(sOutFile, "%s.cc3", argv[1]);
			}
			else {
				strncpy(sOutFile, argv[2], MAX_PATH);
			}
			ConvertSound(sInFile, sOutFile);
		}
	}

	printf("Done!\n\n");
 	  
	/* Exit normally */	
	exit(0);
}

/* Converts an AGI format sound file to the Coco AGI interpreter format */
void ConvertSound(char *sInFile, char *sOutFile) {

	FILE *infile, *outfile;
	unsigned short uiOffset;
	struct MUSIC_NOTE note;
	struct COCO_MUSIC_NOTE cocoNote;
	unsigned short uiFreq, uiFreqDiv;

	if ((infile = fopen(sInFile, "rb")) == NULL) {
		perror("Error opening input file");
		exit(1);
	}

	if ((outfile = fopen(sOutFile, "wb")) == NULL) {
		perror("Error opening output file");
		exit(1);
	}

	printf("Converting %s -> %s\n", sInFile, sOutFile);
	
	/* Get voice 1 offset */
	fseek(infile, 0, SEEK_SET);
	fread(&uiOffset, sizeof(unsigned short), 1, infile);

	/* Seek to voice 1 offset */
	fseek(infile, uiOffset, SEEK_SET);
	memset(&note, 0, sizeof(note));
	
	while (!ferror(infile) && !feof(infile) && fread(&note, sizeof(note), 1, infile) && note.duration != 0xFFFF) {
		/* Verify that it's not a noise tone */
		if (note.tone_1 >> 4 != 0x0E) {
			/* Get the frequency divider */
			uiFreqDiv = (((note.tone_2 & 0x3F) << 4) + (note.tone_1 & 0x0F));
			if (uiFreqDiv > 0) {
				/* Get the frequency of the tone */
				uiFreq = 111860 / uiFreqDiv;
				/* Get the corresponding coco tone */
				cocoNote.tone = GetCocoTone(uiFreq);
				if ((note.attenuation & 0x0F) == 0x0F)
				  cocoNote.volume = 0x00;
				else
				  cocoNote.volume = 0x3F;
			}
			else {
				/* Insert a silence if the frequency equals zero */
				cocoNote.tone = 0;
				cocoNote.volume = 0x00;
			}
			cocoNote.unused = 0;
			cocoNote.duration = (unsigned char)note.duration / 6;
			/* Make sure the duration equals at least 1 or else the sound will play indefinitely */
			if (cocoNote.duration == 0) 
			  cocoNote.duration = 1;
			/* Write the note to the file */
			fwrite(&cocoNote, sizeof(cocoNote), 1, outfile);
	    }
	}

	/* Write the footer. The last 2 bytes seems to do nothing but every sound in KQ3 for the coco
	   ends with 0xFF and 2 bytes */
	fprintf(outfile, "%c%c%c", 0xFF, 0x00, 0x30);

	/* Close files */
	fclose(outfile);
	fclose(infile);

}

/* Gets the coco tone number from the specified frequency */
unsigned char GetCocoTone(unsigned short uiFreq) {

	int count, i, iTone = 0;

	count = sizeof(COCO_TONES_TABLE) / sizeof(unsigned short);
	
	for (i = 0; i < count; i++) {
		if (uiFreq <= COCO_TONES_TABLE[i]) {
			iTone = i - 1;
			break;
		}
	}  
	
	/* Make sure the tone is not negative */
	if (iTone < 0) 
	  iTone = 0;

	return iTone;

}

/* Shows usage */
void ShowUsage() {

	printf("Usage: cc3snd input-file [output-file]\n");
	printf("       cc3snd -b [input-path] output-path (batch mode)\n");

	/* Exit normally */		
	exit(0);

}

