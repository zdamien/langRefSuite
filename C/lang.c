/* examples of most of core language features.  Functions use assertions
 * when they can, otherwise put out reasonable output. */

#include <assert.h>
#include <stdio.h>

int basics() {
    //comparison, if, switch, for, while
    assert(3<4);
    if (3<4)
        assert(1);
    else
        assert(0);

    int i=4;
    switch (i) {
        case 4:
          assert(1);
          break;
        case 3:
          assert(0);
          break;
        default:
          assert(0);
    }

    int sum=0;
    for (i=0; i<10; i++) {
        sum+=i;
    }
    assert(45==sum);

    sum=0;
    i=0;
    while (i<10) {
        sum+=i;
        i++;
    }
    assert(45==sum);
}

#include <math.h>
int math() {
    //modular and power arithmetic
    assert(1==5/3);
    assert(2==5%3);
    assert(8==pow(2.0,3));
}

#include <string.h>
int strings() {
    //string comparison and modification, character finding
    //string duplication

    assert(!strcmp("hello","hello"));
    assert(strcmp("hello","Hello")>0);
    char s1[]="hello";
    assert(strlen(s1)==5); // strlen doesn't count terminating null
    assert(!strcmp(s1,"hello"));
    char s2[6];
    strncpy(s2,s1,6);
    assert(!strcmp(s2,"hello"));
    char* s3=strdup(s1); //POSIX, not ANSI C
    assert(!strcmp(s3,"hello"));
    s1[0]='H';
    assert(!strcmp(s1,"Hello"));
    char* cp = strchr(s1,'H');
    assert(cp == s1);
    cp = strchr(s1,'o');
    assert(cp == s1+4);
    s2[3]=0;
    assert(!strcmp(s2,"hel"));
}

#include <stdlib.h>  //for calloc
int arrays() {
    //some basics already in strings()

    int* ia=calloc(10,sizeof(int));  //I like calloc, inits the memory
    free(ia);
    ia=malloc(10*sizeof(int));
    int i;
    for (i=0; i<10; i++)
        ia[i]=10-i;
    printf("Expect 10 down to 1: ");
    for (i=0; i<10; i++)
        printf("%d ",ia[i]);
    printf("\n");

    ia=realloc(ia,20*sizeof(int));
    for (i=10; i<20; i++)
        ia[i]=-i;
    for (i=0; i<20; i++)
        printf("%d ",ia[i]);
    printf("\n");
    free(ia);

    int ia2[] = {10,1,2,3};  //array initializer
    for (i=0; i<4; i++)
        printf("%d ",ia2[i]);
    printf("\n");

    //multiarray

    int ma[4][4];
    for (i=0;i<4;i++)
        for(int j=0;j<4;j++)
            ma[i][j]=j;
    for (i=0;i<4;i++) {
        for(int j=0;j<4;j++)
            printf("%d ",ma[i][j]);
        printf("\n");
    }
    //transpose array
    for (i=0;i<4;i++)
        for(int j=0;j<i;j++) { //j<i, not j<4
            int temp=ma[i][j];
            ma[i][j]=ma[j][i];
            ma[j][i]=temp;
        }
    for (i=0;i<4;i++) {
        for(int j=0;j<4;j++)
            printf("%d ",ma[i][j]);
        printf("\n");
    }
}

int bits() {
    unsigned int i=0;
    assert(1<<1==2);
    assert(1<<4==16);
    assert(3<<2==12);
    assert(3&2==2);
    assert(3&1==1);
    i=4;
    i|=2;
    assert(6==i);
    i&=2;
    assert(2==i);
    i^=2;
    assert(0==i);
    i^=2;
    assert(2==i);
}

int cmp (const void* a1, const void* a2) {
    int k1=*(int *)a1;
    int k2=*(int *)a2;
    if (k1 < k2)
        return -1;
    else if (k1 == k2)
        return 0;
    else return 1;
}
int libfuncs() {
    int a[20];
    for (int i=0;i<20;i++)
        a[i]=20-i;
    for (int i=0;i<20;i++)
        printf("%d ",a[i]);
    printf("\n");
    qsort(a,20,sizeof(int), cmp);
    for (int i=0;i<20;i++)
        printf("%d ",a[i]);
    printf("\n");

    int key=4;
    int* ap = (int*) bsearch(&key, a, 20, sizeof(int), cmp);
    assert(ap == a+3);
}

int console_io() {
    //console

    const int BUFSIZE=2048;
    char buf1[BUFSIZE];
    //get line, old way
    fgets(buf1,BUFSIZE, stdin);  //safe unlike gets()
    printf("%s",buf1);  //input newline preserved

    //get a string
    scanf("%s",buf1);
    printf("%s\n",buf1); //need newline
    
    //mixing scanf and fgets is horrible
    printf("before second fgets\n");
    fgets(buf1,BUFSIZE, stdin);  //safe unlike gets()
    printf("%s",buf1);  //input newline preserved

    //get line, more modern way, POSIX 2008
    char* buf2=0; 
    long unsigned int len2=0; //getline is very picky about this parameter
    printf("before getline\n");
    int numread=getline(&buf2, &len2, stdin); //POSIX 2008
    //note passingtaking address of array
    printf("%d %s",numread,buf2);  //input newline preserved
    free(buf2);

    scanf("%ms",&buf2); //POSIX allocator
    //also passing address of array
    printf("%s\n",buf2); //need newline
    free(buf2);

}

int file_io() {
    //FILE

    FILE* fp = fopen("tmp","w");
    fprintf(fp,"hello world\n");
    fclose(fp);
    fp = fopen("tmp","r");
    char* buf=0;
    unsigned long len=0;
    getline(&buf,&len,fp);
    printf("%s",buf);
    free(buf);
    fclose(fp);
    remove("tmp");

    fp = tmpfile();
    int n=0x12345678;
    fwrite(&n,1,sizeof(int), fp);
    int n2=0;
    //fseek(fp,0,SEEK_SET);
    rewind(fp);
    fread(&n2,1, sizeof(int), fp);
    printf("fread %x\n",n2);
}

#include <time.h>
int mytime() {
    time_t t;
    t=time(0);
    printf("Unix epoch %d\n",t);
    clock_t c=clock();
    printf("process clock %d\n",c);

}

#include <dirent.h>
#include <sys/types.h>
#include <sys/stat.h>
//POSIX, not C
int dir() {
    printf("in dir()\n");
    DIR* d = opendir(".");
    struct dirent* ent;
    struct stat buf;
    while (ent = readdir(d)) {
        stat(ent->d_name,&buf);
        printf("%s %d, size %d\n",ent->d_name,ent->d_type,buf.st_size);
    }
}


int main() {

//Language basics:
//comparisons and if tests
//loops, for, while, sequence iteration.
    basics();


//math. modular, power, complex
    math();
//strings, create, compare, modify, copy.
    strings();
//functions, closures, function objects
//arrays or lists
// initialize, copy, resize, split
//multiple dimensional arrays
    arrays();
//
//More language:
//bits
    bits();
//maps: NOPE
//array of maps, map of arrays, map of maps
//priority queue
//objects
//assertion
//library sort, search
    libfuncs();
//applicative functions NOPE
//handrolled sort: done elsewhere
//exceptions or errors
//regular expressions
//threads, locks
//package or modules, build
//
//Basic IO:
    //console_io();
    file_io();
//console io: read, write, error
//file io: file existence, creation, reading, writing, deletion
//get time
    mytime();
//get random numbers
    int r;
    srand(0);
    r=rand();
    printf("%d\n",r);
    r=rand();
    printf("%d\n",r);
    r=rand();
    printf("%d\n",r);
//get date: struct tm stuff in time.h
//
//More IO
//directory
    dir();
//sockets and networking
//database access
//link against libraries
//

    system("ls");
    exit(0);
}
