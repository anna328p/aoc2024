#include <stdio.h>
#include <stdlib.h>

#define FSIZE 1000

int read_input(char *filename, int left[FSIZE], int right[FSIZE], int *max) {
	FILE *file = fopen(filename, "rb");

	int l, r, i;

	for (i = 0; fscanf(file, "%d %d", &l, &r) != EOF; i++) {
		left[i] = l;
		right[i] = r;

		if (l > *max) *max = l;
	}

	fclose(file);
	return i;
}

int main(int argc, char **argv) {
	if (argc != 2) exit(1);

	int left[FSIZE], right[FSIZE], max = 0;
	int res = 0;

	int line_count = read_input(argv[1], left, right, &max);

	int *counts = calloc(max + 1, sizeof(int));

	for (int i = 0; i < line_count; i++) if (right[i] <= max) counts[right[i]]++;

	for (int i = 0; i < line_count; i++) res += left[i] * counts[left[i]]; 

	printf("%d\n", res);

	exit(0);
}

