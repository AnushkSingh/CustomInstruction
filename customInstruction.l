%{
#include <stdio.h>
#include <string.h>
#include <math.h>

int token_count = 0; // To count the number of tokens
%}

%%

[ \t\n]+         ;  // Ignore spaces, tabs, and newlines
x[0-9]+          { printf("Token: %s (Variable x with value)\n", yytext); token_count++; }   // Matches and prints x
y[0-9]+          { printf("Token: %s (Variable y with value)\n", yytext); token_count++; }   // Matches and prints y
compute           { printf("Token: %s (Command to compute the equation)\n", yytext); token_count++; }  // Matches and prints compute
"+"|"-"|"*"|"/"|"=" { printf("Token: %s (Operator)\n", yytext); token_count++; }  // Matches operators
[0-9]+           { printf("Token: %s (Number)\n", yytext); token_count++; }   // Matches and prints numbers
.                { printf("Token: %s (Unknown or miscellaneous)\n", yytext); token_count++; } // Matches any other character

%%

int yywrap() {
    return 1; // Signals end of input
}

int main() {
    float x = 0, y = 0, z = 0;
    char input[256];

    printf("Enter input (e.g., 'x3 y4 compute'):\n");
    fgets(input, sizeof(input), stdin);
    // Process input
    yy_scan_string(input);
    yylex();

    // Extract values of x and y from the input (based on Flex tokens)
    sscanf(input, "x%f y%f", &x, &y);

    // Compute the equation z = x^2 + y^2 + 2xy
    z = (x * x) + (y * y) + (2 * x * y);
    printf("\nResult: z = %.2f\n", z);
    printf("Total number of tokens: %d\n", token_count);

    return 0;
}
