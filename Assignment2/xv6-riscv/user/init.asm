
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	c4250513          	addi	a0,a0,-958 # c50 <uthread_self+0x28>
  16:	00000097          	auipc	ra,0x0
  1a:	3aa080e7          	jalr	938(ra) # 3c0 <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	3d4080e7          	jalr	980(ra) # 3f8 <dup>
  dup(0);  // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	3ca080e7          	jalr	970(ra) # 3f8 <dup>

  for(;;){
    printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	c2290913          	addi	s2,s2,-990 # c58 <uthread_self+0x30>
  3e:	854a                	mv	a0,s2
  40:	00000097          	auipc	ra,0x0
  44:	6b8080e7          	jalr	1720(ra) # 6f8 <printf>
    pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	330080e7          	jalr	816(ra) # 378 <fork>
  50:	84aa                	mv	s1,a0
    if(pid < 0){
  52:	04054d63          	bltz	a0,ac <main+0xac>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  56:	c925                	beqz	a0,c6 <main+0xc6>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	32e080e7          	jalr	814(ra) # 388 <wait>
      if(wpid == pid){
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  66:	fe0559e3          	bgez	a0,58 <main+0x58>
        printf("init: wait returned an error\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	c3e50513          	addi	a0,a0,-962 # ca8 <uthread_self+0x80>
  72:	00000097          	auipc	ra,0x0
  76:	686080e7          	jalr	1670(ra) # 6f8 <printf>
        exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	304080e7          	jalr	772(ra) # 380 <exit>
    mknod("console", CONSOLE, 0);
  84:	4601                	li	a2,0
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	bc850513          	addi	a0,a0,-1080 # c50 <uthread_self+0x28>
  90:	00000097          	auipc	ra,0x0
  94:	338080e7          	jalr	824(ra) # 3c8 <mknod>
    open("console", O_RDWR);
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	bb650513          	addi	a0,a0,-1098 # c50 <uthread_self+0x28>
  a2:	00000097          	auipc	ra,0x0
  a6:	31e080e7          	jalr	798(ra) # 3c0 <open>
  aa:	bfa5                	j	22 <main+0x22>
      printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	bc450513          	addi	a0,a0,-1084 # c70 <uthread_self+0x48>
  b4:	00000097          	auipc	ra,0x0
  b8:	644080e7          	jalr	1604(ra) # 6f8 <printf>
      exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	2c2080e7          	jalr	706(ra) # 380 <exit>
      exec("sh", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	f3a58593          	addi	a1,a1,-198 # 1000 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	bba50513          	addi	a0,a0,-1094 # c88 <uthread_self+0x60>
  d6:	00000097          	auipc	ra,0x0
  da:	2e2080e7          	jalr	738(ra) # 3b8 <exec>
      printf("init: exec sh failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	bb250513          	addi	a0,a0,-1102 # c90 <uthread_self+0x68>
  e6:	00000097          	auipc	ra,0x0
  ea:	612080e7          	jalr	1554(ra) # 6f8 <printf>
      exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	290080e7          	jalr	656(ra) # 380 <exit>

00000000000000f8 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e406                	sd	ra,8(sp)
  fc:	e022                	sd	s0,0(sp)
  fe:	0800                	addi	s0,sp,16
  extern int main();
  main();
 100:	00000097          	auipc	ra,0x0
 104:	f00080e7          	jalr	-256(ra) # 0 <main>
  exit(0);
 108:	4501                	li	a0,0
 10a:	00000097          	auipc	ra,0x0
 10e:	276080e7          	jalr	630(ra) # 380 <exit>

0000000000000112 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 112:	1141                	addi	sp,sp,-16
 114:	e422                	sd	s0,8(sp)
 116:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 118:	87aa                	mv	a5,a0
 11a:	0585                	addi	a1,a1,1
 11c:	0785                	addi	a5,a5,1
 11e:	fff5c703          	lbu	a4,-1(a1)
 122:	fee78fa3          	sb	a4,-1(a5)
 126:	fb75                	bnez	a4,11a <strcpy+0x8>
    ;
  return os;
}
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	addi	sp,sp,16
 12c:	8082                	ret

000000000000012e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 12e:	1141                	addi	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 134:	00054783          	lbu	a5,0(a0)
 138:	cb91                	beqz	a5,14c <strcmp+0x1e>
 13a:	0005c703          	lbu	a4,0(a1)
 13e:	00f71763          	bne	a4,a5,14c <strcmp+0x1e>
    p++, q++;
 142:	0505                	addi	a0,a0,1
 144:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 146:	00054783          	lbu	a5,0(a0)
 14a:	fbe5                	bnez	a5,13a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 14c:	0005c503          	lbu	a0,0(a1)
}
 150:	40a7853b          	subw	a0,a5,a0
 154:	6422                	ld	s0,8(sp)
 156:	0141                	addi	sp,sp,16
 158:	8082                	ret

000000000000015a <strlen>:

uint
strlen(const char *s)
{
 15a:	1141                	addi	sp,sp,-16
 15c:	e422                	sd	s0,8(sp)
 15e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 160:	00054783          	lbu	a5,0(a0)
 164:	cf91                	beqz	a5,180 <strlen+0x26>
 166:	0505                	addi	a0,a0,1
 168:	87aa                	mv	a5,a0
 16a:	4685                	li	a3,1
 16c:	9e89                	subw	a3,a3,a0
 16e:	00f6853b          	addw	a0,a3,a5
 172:	0785                	addi	a5,a5,1
 174:	fff7c703          	lbu	a4,-1(a5)
 178:	fb7d                	bnez	a4,16e <strlen+0x14>
    ;
  return n;
}
 17a:	6422                	ld	s0,8(sp)
 17c:	0141                	addi	sp,sp,16
 17e:	8082                	ret
  for(n = 0; s[n]; n++)
 180:	4501                	li	a0,0
 182:	bfe5                	j	17a <strlen+0x20>

0000000000000184 <memset>:

void*
memset(void *dst, int c, uint n)
{
 184:	1141                	addi	sp,sp,-16
 186:	e422                	sd	s0,8(sp)
 188:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 18a:	ca19                	beqz	a2,1a0 <memset+0x1c>
 18c:	87aa                	mv	a5,a0
 18e:	1602                	slli	a2,a2,0x20
 190:	9201                	srli	a2,a2,0x20
 192:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 196:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 19a:	0785                	addi	a5,a5,1
 19c:	fee79de3          	bne	a5,a4,196 <memset+0x12>
  }
  return dst;
}
 1a0:	6422                	ld	s0,8(sp)
 1a2:	0141                	addi	sp,sp,16
 1a4:	8082                	ret

00000000000001a6 <strchr>:

char*
strchr(const char *s, char c)
{
 1a6:	1141                	addi	sp,sp,-16
 1a8:	e422                	sd	s0,8(sp)
 1aa:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1ac:	00054783          	lbu	a5,0(a0)
 1b0:	cb99                	beqz	a5,1c6 <strchr+0x20>
    if(*s == c)
 1b2:	00f58763          	beq	a1,a5,1c0 <strchr+0x1a>
  for(; *s; s++)
 1b6:	0505                	addi	a0,a0,1
 1b8:	00054783          	lbu	a5,0(a0)
 1bc:	fbfd                	bnez	a5,1b2 <strchr+0xc>
      return (char*)s;
  return 0;
 1be:	4501                	li	a0,0
}
 1c0:	6422                	ld	s0,8(sp)
 1c2:	0141                	addi	sp,sp,16
 1c4:	8082                	ret
  return 0;
 1c6:	4501                	li	a0,0
 1c8:	bfe5                	j	1c0 <strchr+0x1a>

00000000000001ca <gets>:

char*
gets(char *buf, int max)
{
 1ca:	711d                	addi	sp,sp,-96
 1cc:	ec86                	sd	ra,88(sp)
 1ce:	e8a2                	sd	s0,80(sp)
 1d0:	e4a6                	sd	s1,72(sp)
 1d2:	e0ca                	sd	s2,64(sp)
 1d4:	fc4e                	sd	s3,56(sp)
 1d6:	f852                	sd	s4,48(sp)
 1d8:	f456                	sd	s5,40(sp)
 1da:	f05a                	sd	s6,32(sp)
 1dc:	ec5e                	sd	s7,24(sp)
 1de:	1080                	addi	s0,sp,96
 1e0:	8baa                	mv	s7,a0
 1e2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e4:	892a                	mv	s2,a0
 1e6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1e8:	4aa9                	li	s5,10
 1ea:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ec:	89a6                	mv	s3,s1
 1ee:	2485                	addiw	s1,s1,1
 1f0:	0344d863          	bge	s1,s4,220 <gets+0x56>
    cc = read(0, &c, 1);
 1f4:	4605                	li	a2,1
 1f6:	faf40593          	addi	a1,s0,-81
 1fa:	4501                	li	a0,0
 1fc:	00000097          	auipc	ra,0x0
 200:	19c080e7          	jalr	412(ra) # 398 <read>
    if(cc < 1)
 204:	00a05e63          	blez	a0,220 <gets+0x56>
    buf[i++] = c;
 208:	faf44783          	lbu	a5,-81(s0)
 20c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 210:	01578763          	beq	a5,s5,21e <gets+0x54>
 214:	0905                	addi	s2,s2,1
 216:	fd679be3          	bne	a5,s6,1ec <gets+0x22>
  for(i=0; i+1 < max; ){
 21a:	89a6                	mv	s3,s1
 21c:	a011                	j	220 <gets+0x56>
 21e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 220:	99de                	add	s3,s3,s7
 222:	00098023          	sb	zero,0(s3)
  return buf;
}
 226:	855e                	mv	a0,s7
 228:	60e6                	ld	ra,88(sp)
 22a:	6446                	ld	s0,80(sp)
 22c:	64a6                	ld	s1,72(sp)
 22e:	6906                	ld	s2,64(sp)
 230:	79e2                	ld	s3,56(sp)
 232:	7a42                	ld	s4,48(sp)
 234:	7aa2                	ld	s5,40(sp)
 236:	7b02                	ld	s6,32(sp)
 238:	6be2                	ld	s7,24(sp)
 23a:	6125                	addi	sp,sp,96
 23c:	8082                	ret

000000000000023e <stat>:

int
stat(const char *n, struct stat *st)
{
 23e:	1101                	addi	sp,sp,-32
 240:	ec06                	sd	ra,24(sp)
 242:	e822                	sd	s0,16(sp)
 244:	e426                	sd	s1,8(sp)
 246:	e04a                	sd	s2,0(sp)
 248:	1000                	addi	s0,sp,32
 24a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 24c:	4581                	li	a1,0
 24e:	00000097          	auipc	ra,0x0
 252:	172080e7          	jalr	370(ra) # 3c0 <open>
  if(fd < 0)
 256:	02054563          	bltz	a0,280 <stat+0x42>
 25a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 25c:	85ca                	mv	a1,s2
 25e:	00000097          	auipc	ra,0x0
 262:	17a080e7          	jalr	378(ra) # 3d8 <fstat>
 266:	892a                	mv	s2,a0
  close(fd);
 268:	8526                	mv	a0,s1
 26a:	00000097          	auipc	ra,0x0
 26e:	13e080e7          	jalr	318(ra) # 3a8 <close>
  return r;
}
 272:	854a                	mv	a0,s2
 274:	60e2                	ld	ra,24(sp)
 276:	6442                	ld	s0,16(sp)
 278:	64a2                	ld	s1,8(sp)
 27a:	6902                	ld	s2,0(sp)
 27c:	6105                	addi	sp,sp,32
 27e:	8082                	ret
    return -1;
 280:	597d                	li	s2,-1
 282:	bfc5                	j	272 <stat+0x34>

0000000000000284 <atoi>:

int
atoi(const char *s)
{
 284:	1141                	addi	sp,sp,-16
 286:	e422                	sd	s0,8(sp)
 288:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 28a:	00054603          	lbu	a2,0(a0)
 28e:	fd06079b          	addiw	a5,a2,-48
 292:	0ff7f793          	andi	a5,a5,255
 296:	4725                	li	a4,9
 298:	02f76963          	bltu	a4,a5,2ca <atoi+0x46>
 29c:	86aa                	mv	a3,a0
  n = 0;
 29e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2a0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2a2:	0685                	addi	a3,a3,1
 2a4:	0025179b          	slliw	a5,a0,0x2
 2a8:	9fa9                	addw	a5,a5,a0
 2aa:	0017979b          	slliw	a5,a5,0x1
 2ae:	9fb1                	addw	a5,a5,a2
 2b0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2b4:	0006c603          	lbu	a2,0(a3)
 2b8:	fd06071b          	addiw	a4,a2,-48
 2bc:	0ff77713          	andi	a4,a4,255
 2c0:	fee5f1e3          	bgeu	a1,a4,2a2 <atoi+0x1e>
  return n;
}
 2c4:	6422                	ld	s0,8(sp)
 2c6:	0141                	addi	sp,sp,16
 2c8:	8082                	ret
  n = 0;
 2ca:	4501                	li	a0,0
 2cc:	bfe5                	j	2c4 <atoi+0x40>

00000000000002ce <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e422                	sd	s0,8(sp)
 2d2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2d4:	02b57463          	bgeu	a0,a1,2fc <memmove+0x2e>
    while(n-- > 0)
 2d8:	00c05f63          	blez	a2,2f6 <memmove+0x28>
 2dc:	1602                	slli	a2,a2,0x20
 2de:	9201                	srli	a2,a2,0x20
 2e0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2e4:	872a                	mv	a4,a0
      *dst++ = *src++;
 2e6:	0585                	addi	a1,a1,1
 2e8:	0705                	addi	a4,a4,1
 2ea:	fff5c683          	lbu	a3,-1(a1)
 2ee:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2f2:	fee79ae3          	bne	a5,a4,2e6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2f6:	6422                	ld	s0,8(sp)
 2f8:	0141                	addi	sp,sp,16
 2fa:	8082                	ret
    dst += n;
 2fc:	00c50733          	add	a4,a0,a2
    src += n;
 300:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 302:	fec05ae3          	blez	a2,2f6 <memmove+0x28>
 306:	fff6079b          	addiw	a5,a2,-1
 30a:	1782                	slli	a5,a5,0x20
 30c:	9381                	srli	a5,a5,0x20
 30e:	fff7c793          	not	a5,a5
 312:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 314:	15fd                	addi	a1,a1,-1
 316:	177d                	addi	a4,a4,-1
 318:	0005c683          	lbu	a3,0(a1)
 31c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 320:	fee79ae3          	bne	a5,a4,314 <memmove+0x46>
 324:	bfc9                	j	2f6 <memmove+0x28>

0000000000000326 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 326:	1141                	addi	sp,sp,-16
 328:	e422                	sd	s0,8(sp)
 32a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 32c:	ca05                	beqz	a2,35c <memcmp+0x36>
 32e:	fff6069b          	addiw	a3,a2,-1
 332:	1682                	slli	a3,a3,0x20
 334:	9281                	srli	a3,a3,0x20
 336:	0685                	addi	a3,a3,1
 338:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 33a:	00054783          	lbu	a5,0(a0)
 33e:	0005c703          	lbu	a4,0(a1)
 342:	00e79863          	bne	a5,a4,352 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 346:	0505                	addi	a0,a0,1
    p2++;
 348:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 34a:	fed518e3          	bne	a0,a3,33a <memcmp+0x14>
  }
  return 0;
 34e:	4501                	li	a0,0
 350:	a019                	j	356 <memcmp+0x30>
      return *p1 - *p2;
 352:	40e7853b          	subw	a0,a5,a4
}
 356:	6422                	ld	s0,8(sp)
 358:	0141                	addi	sp,sp,16
 35a:	8082                	ret
  return 0;
 35c:	4501                	li	a0,0
 35e:	bfe5                	j	356 <memcmp+0x30>

0000000000000360 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 360:	1141                	addi	sp,sp,-16
 362:	e406                	sd	ra,8(sp)
 364:	e022                	sd	s0,0(sp)
 366:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 368:	00000097          	auipc	ra,0x0
 36c:	f66080e7          	jalr	-154(ra) # 2ce <memmove>
}
 370:	60a2                	ld	ra,8(sp)
 372:	6402                	ld	s0,0(sp)
 374:	0141                	addi	sp,sp,16
 376:	8082                	ret

0000000000000378 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 378:	4885                	li	a7,1
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <exit>:
.global exit
exit:
 li a7, SYS_exit
 380:	4889                	li	a7,2
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <wait>:
.global wait
wait:
 li a7, SYS_wait
 388:	488d                	li	a7,3
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 390:	4891                	li	a7,4
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <read>:
.global read
read:
 li a7, SYS_read
 398:	4895                	li	a7,5
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <write>:
.global write
write:
 li a7, SYS_write
 3a0:	48c1                	li	a7,16
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <close>:
.global close
close:
 li a7, SYS_close
 3a8:	48d5                	li	a7,21
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3b0:	4899                	li	a7,6
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3b8:	489d                	li	a7,7
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <open>:
.global open
open:
 li a7, SYS_open
 3c0:	48bd                	li	a7,15
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3c8:	48c5                	li	a7,17
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3d0:	48c9                	li	a7,18
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3d8:	48a1                	li	a7,8
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <link>:
.global link
link:
 li a7, SYS_link
 3e0:	48cd                	li	a7,19
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3e8:	48d1                	li	a7,20
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3f0:	48a5                	li	a7,9
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3f8:	48a9                	li	a7,10
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 400:	48ad                	li	a7,11
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 408:	48b1                	li	a7,12
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 410:	48b5                	li	a7,13
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 418:	48b9                	li	a7,14
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 420:	1101                	addi	sp,sp,-32
 422:	ec06                	sd	ra,24(sp)
 424:	e822                	sd	s0,16(sp)
 426:	1000                	addi	s0,sp,32
 428:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 42c:	4605                	li	a2,1
 42e:	fef40593          	addi	a1,s0,-17
 432:	00000097          	auipc	ra,0x0
 436:	f6e080e7          	jalr	-146(ra) # 3a0 <write>
}
 43a:	60e2                	ld	ra,24(sp)
 43c:	6442                	ld	s0,16(sp)
 43e:	6105                	addi	sp,sp,32
 440:	8082                	ret

0000000000000442 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 442:	7139                	addi	sp,sp,-64
 444:	fc06                	sd	ra,56(sp)
 446:	f822                	sd	s0,48(sp)
 448:	f426                	sd	s1,40(sp)
 44a:	f04a                	sd	s2,32(sp)
 44c:	ec4e                	sd	s3,24(sp)
 44e:	0080                	addi	s0,sp,64
 450:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 452:	c299                	beqz	a3,458 <printint+0x16>
 454:	0805c863          	bltz	a1,4e4 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 458:	2581                	sext.w	a1,a1
  neg = 0;
 45a:	4881                	li	a7,0
 45c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 460:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 462:	2601                	sext.w	a2,a2
 464:	00001517          	auipc	a0,0x1
 468:	86c50513          	addi	a0,a0,-1940 # cd0 <digits>
 46c:	883a                	mv	a6,a4
 46e:	2705                	addiw	a4,a4,1
 470:	02c5f7bb          	remuw	a5,a1,a2
 474:	1782                	slli	a5,a5,0x20
 476:	9381                	srli	a5,a5,0x20
 478:	97aa                	add	a5,a5,a0
 47a:	0007c783          	lbu	a5,0(a5)
 47e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 482:	0005879b          	sext.w	a5,a1
 486:	02c5d5bb          	divuw	a1,a1,a2
 48a:	0685                	addi	a3,a3,1
 48c:	fec7f0e3          	bgeu	a5,a2,46c <printint+0x2a>
  if(neg)
 490:	00088b63          	beqz	a7,4a6 <printint+0x64>
    buf[i++] = '-';
 494:	fd040793          	addi	a5,s0,-48
 498:	973e                	add	a4,a4,a5
 49a:	02d00793          	li	a5,45
 49e:	fef70823          	sb	a5,-16(a4)
 4a2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4a6:	02e05863          	blez	a4,4d6 <printint+0x94>
 4aa:	fc040793          	addi	a5,s0,-64
 4ae:	00e78933          	add	s2,a5,a4
 4b2:	fff78993          	addi	s3,a5,-1
 4b6:	99ba                	add	s3,s3,a4
 4b8:	377d                	addiw	a4,a4,-1
 4ba:	1702                	slli	a4,a4,0x20
 4bc:	9301                	srli	a4,a4,0x20
 4be:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4c2:	fff94583          	lbu	a1,-1(s2)
 4c6:	8526                	mv	a0,s1
 4c8:	00000097          	auipc	ra,0x0
 4cc:	f58080e7          	jalr	-168(ra) # 420 <putc>
  while(--i >= 0)
 4d0:	197d                	addi	s2,s2,-1
 4d2:	ff3918e3          	bne	s2,s3,4c2 <printint+0x80>
}
 4d6:	70e2                	ld	ra,56(sp)
 4d8:	7442                	ld	s0,48(sp)
 4da:	74a2                	ld	s1,40(sp)
 4dc:	7902                	ld	s2,32(sp)
 4de:	69e2                	ld	s3,24(sp)
 4e0:	6121                	addi	sp,sp,64
 4e2:	8082                	ret
    x = -xx;
 4e4:	40b005bb          	negw	a1,a1
    neg = 1;
 4e8:	4885                	li	a7,1
    x = -xx;
 4ea:	bf8d                	j	45c <printint+0x1a>

00000000000004ec <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4ec:	7119                	addi	sp,sp,-128
 4ee:	fc86                	sd	ra,120(sp)
 4f0:	f8a2                	sd	s0,112(sp)
 4f2:	f4a6                	sd	s1,104(sp)
 4f4:	f0ca                	sd	s2,96(sp)
 4f6:	ecce                	sd	s3,88(sp)
 4f8:	e8d2                	sd	s4,80(sp)
 4fa:	e4d6                	sd	s5,72(sp)
 4fc:	e0da                	sd	s6,64(sp)
 4fe:	fc5e                	sd	s7,56(sp)
 500:	f862                	sd	s8,48(sp)
 502:	f466                	sd	s9,40(sp)
 504:	f06a                	sd	s10,32(sp)
 506:	ec6e                	sd	s11,24(sp)
 508:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 50a:	0005c903          	lbu	s2,0(a1)
 50e:	18090f63          	beqz	s2,6ac <vprintf+0x1c0>
 512:	8aaa                	mv	s5,a0
 514:	8b32                	mv	s6,a2
 516:	00158493          	addi	s1,a1,1
  state = 0;
 51a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 51c:	02500a13          	li	s4,37
      if(c == 'd'){
 520:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 524:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 528:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 52c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 530:	00000b97          	auipc	s7,0x0
 534:	7a0b8b93          	addi	s7,s7,1952 # cd0 <digits>
 538:	a839                	j	556 <vprintf+0x6a>
        putc(fd, c);
 53a:	85ca                	mv	a1,s2
 53c:	8556                	mv	a0,s5
 53e:	00000097          	auipc	ra,0x0
 542:	ee2080e7          	jalr	-286(ra) # 420 <putc>
 546:	a019                	j	54c <vprintf+0x60>
    } else if(state == '%'){
 548:	01498f63          	beq	s3,s4,566 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 54c:	0485                	addi	s1,s1,1
 54e:	fff4c903          	lbu	s2,-1(s1)
 552:	14090d63          	beqz	s2,6ac <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 556:	0009079b          	sext.w	a5,s2
    if(state == 0){
 55a:	fe0997e3          	bnez	s3,548 <vprintf+0x5c>
      if(c == '%'){
 55e:	fd479ee3          	bne	a5,s4,53a <vprintf+0x4e>
        state = '%';
 562:	89be                	mv	s3,a5
 564:	b7e5                	j	54c <vprintf+0x60>
      if(c == 'd'){
 566:	05878063          	beq	a5,s8,5a6 <vprintf+0xba>
      } else if(c == 'l') {
 56a:	05978c63          	beq	a5,s9,5c2 <vprintf+0xd6>
      } else if(c == 'x') {
 56e:	07a78863          	beq	a5,s10,5de <vprintf+0xf2>
      } else if(c == 'p') {
 572:	09b78463          	beq	a5,s11,5fa <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 576:	07300713          	li	a4,115
 57a:	0ce78663          	beq	a5,a4,646 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 57e:	06300713          	li	a4,99
 582:	0ee78e63          	beq	a5,a4,67e <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 586:	11478863          	beq	a5,s4,696 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 58a:	85d2                	mv	a1,s4
 58c:	8556                	mv	a0,s5
 58e:	00000097          	auipc	ra,0x0
 592:	e92080e7          	jalr	-366(ra) # 420 <putc>
        putc(fd, c);
 596:	85ca                	mv	a1,s2
 598:	8556                	mv	a0,s5
 59a:	00000097          	auipc	ra,0x0
 59e:	e86080e7          	jalr	-378(ra) # 420 <putc>
      }
      state = 0;
 5a2:	4981                	li	s3,0
 5a4:	b765                	j	54c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5a6:	008b0913          	addi	s2,s6,8
 5aa:	4685                	li	a3,1
 5ac:	4629                	li	a2,10
 5ae:	000b2583          	lw	a1,0(s6)
 5b2:	8556                	mv	a0,s5
 5b4:	00000097          	auipc	ra,0x0
 5b8:	e8e080e7          	jalr	-370(ra) # 442 <printint>
 5bc:	8b4a                	mv	s6,s2
      state = 0;
 5be:	4981                	li	s3,0
 5c0:	b771                	j	54c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5c2:	008b0913          	addi	s2,s6,8
 5c6:	4681                	li	a3,0
 5c8:	4629                	li	a2,10
 5ca:	000b2583          	lw	a1,0(s6)
 5ce:	8556                	mv	a0,s5
 5d0:	00000097          	auipc	ra,0x0
 5d4:	e72080e7          	jalr	-398(ra) # 442 <printint>
 5d8:	8b4a                	mv	s6,s2
      state = 0;
 5da:	4981                	li	s3,0
 5dc:	bf85                	j	54c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5de:	008b0913          	addi	s2,s6,8
 5e2:	4681                	li	a3,0
 5e4:	4641                	li	a2,16
 5e6:	000b2583          	lw	a1,0(s6)
 5ea:	8556                	mv	a0,s5
 5ec:	00000097          	auipc	ra,0x0
 5f0:	e56080e7          	jalr	-426(ra) # 442 <printint>
 5f4:	8b4a                	mv	s6,s2
      state = 0;
 5f6:	4981                	li	s3,0
 5f8:	bf91                	j	54c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5fa:	008b0793          	addi	a5,s6,8
 5fe:	f8f43423          	sd	a5,-120(s0)
 602:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 606:	03000593          	li	a1,48
 60a:	8556                	mv	a0,s5
 60c:	00000097          	auipc	ra,0x0
 610:	e14080e7          	jalr	-492(ra) # 420 <putc>
  putc(fd, 'x');
 614:	85ea                	mv	a1,s10
 616:	8556                	mv	a0,s5
 618:	00000097          	auipc	ra,0x0
 61c:	e08080e7          	jalr	-504(ra) # 420 <putc>
 620:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 622:	03c9d793          	srli	a5,s3,0x3c
 626:	97de                	add	a5,a5,s7
 628:	0007c583          	lbu	a1,0(a5)
 62c:	8556                	mv	a0,s5
 62e:	00000097          	auipc	ra,0x0
 632:	df2080e7          	jalr	-526(ra) # 420 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 636:	0992                	slli	s3,s3,0x4
 638:	397d                	addiw	s2,s2,-1
 63a:	fe0914e3          	bnez	s2,622 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 63e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 642:	4981                	li	s3,0
 644:	b721                	j	54c <vprintf+0x60>
        s = va_arg(ap, char*);
 646:	008b0993          	addi	s3,s6,8
 64a:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 64e:	02090163          	beqz	s2,670 <vprintf+0x184>
        while(*s != 0){
 652:	00094583          	lbu	a1,0(s2)
 656:	c9a1                	beqz	a1,6a6 <vprintf+0x1ba>
          putc(fd, *s);
 658:	8556                	mv	a0,s5
 65a:	00000097          	auipc	ra,0x0
 65e:	dc6080e7          	jalr	-570(ra) # 420 <putc>
          s++;
 662:	0905                	addi	s2,s2,1
        while(*s != 0){
 664:	00094583          	lbu	a1,0(s2)
 668:	f9e5                	bnez	a1,658 <vprintf+0x16c>
        s = va_arg(ap, char*);
 66a:	8b4e                	mv	s6,s3
      state = 0;
 66c:	4981                	li	s3,0
 66e:	bdf9                	j	54c <vprintf+0x60>
          s = "(null)";
 670:	00000917          	auipc	s2,0x0
 674:	65890913          	addi	s2,s2,1624 # cc8 <uthread_self+0xa0>
        while(*s != 0){
 678:	02800593          	li	a1,40
 67c:	bff1                	j	658 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 67e:	008b0913          	addi	s2,s6,8
 682:	000b4583          	lbu	a1,0(s6)
 686:	8556                	mv	a0,s5
 688:	00000097          	auipc	ra,0x0
 68c:	d98080e7          	jalr	-616(ra) # 420 <putc>
 690:	8b4a                	mv	s6,s2
      state = 0;
 692:	4981                	li	s3,0
 694:	bd65                	j	54c <vprintf+0x60>
        putc(fd, c);
 696:	85d2                	mv	a1,s4
 698:	8556                	mv	a0,s5
 69a:	00000097          	auipc	ra,0x0
 69e:	d86080e7          	jalr	-634(ra) # 420 <putc>
      state = 0;
 6a2:	4981                	li	s3,0
 6a4:	b565                	j	54c <vprintf+0x60>
        s = va_arg(ap, char*);
 6a6:	8b4e                	mv	s6,s3
      state = 0;
 6a8:	4981                	li	s3,0
 6aa:	b54d                	j	54c <vprintf+0x60>
    }
  }
}
 6ac:	70e6                	ld	ra,120(sp)
 6ae:	7446                	ld	s0,112(sp)
 6b0:	74a6                	ld	s1,104(sp)
 6b2:	7906                	ld	s2,96(sp)
 6b4:	69e6                	ld	s3,88(sp)
 6b6:	6a46                	ld	s4,80(sp)
 6b8:	6aa6                	ld	s5,72(sp)
 6ba:	6b06                	ld	s6,64(sp)
 6bc:	7be2                	ld	s7,56(sp)
 6be:	7c42                	ld	s8,48(sp)
 6c0:	7ca2                	ld	s9,40(sp)
 6c2:	7d02                	ld	s10,32(sp)
 6c4:	6de2                	ld	s11,24(sp)
 6c6:	6109                	addi	sp,sp,128
 6c8:	8082                	ret

00000000000006ca <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6ca:	715d                	addi	sp,sp,-80
 6cc:	ec06                	sd	ra,24(sp)
 6ce:	e822                	sd	s0,16(sp)
 6d0:	1000                	addi	s0,sp,32
 6d2:	e010                	sd	a2,0(s0)
 6d4:	e414                	sd	a3,8(s0)
 6d6:	e818                	sd	a4,16(s0)
 6d8:	ec1c                	sd	a5,24(s0)
 6da:	03043023          	sd	a6,32(s0)
 6de:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6e2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6e6:	8622                	mv	a2,s0
 6e8:	00000097          	auipc	ra,0x0
 6ec:	e04080e7          	jalr	-508(ra) # 4ec <vprintf>
}
 6f0:	60e2                	ld	ra,24(sp)
 6f2:	6442                	ld	s0,16(sp)
 6f4:	6161                	addi	sp,sp,80
 6f6:	8082                	ret

00000000000006f8 <printf>:

void
printf(const char *fmt, ...)
{
 6f8:	711d                	addi	sp,sp,-96
 6fa:	ec06                	sd	ra,24(sp)
 6fc:	e822                	sd	s0,16(sp)
 6fe:	1000                	addi	s0,sp,32
 700:	e40c                	sd	a1,8(s0)
 702:	e810                	sd	a2,16(s0)
 704:	ec14                	sd	a3,24(s0)
 706:	f018                	sd	a4,32(s0)
 708:	f41c                	sd	a5,40(s0)
 70a:	03043823          	sd	a6,48(s0)
 70e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 712:	00840613          	addi	a2,s0,8
 716:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 71a:	85aa                	mv	a1,a0
 71c:	4505                	li	a0,1
 71e:	00000097          	auipc	ra,0x0
 722:	dce080e7          	jalr	-562(ra) # 4ec <vprintf>
}
 726:	60e2                	ld	ra,24(sp)
 728:	6442                	ld	s0,16(sp)
 72a:	6125                	addi	sp,sp,96
 72c:	8082                	ret

000000000000072e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 72e:	1141                	addi	sp,sp,-16
 730:	e422                	sd	s0,8(sp)
 732:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 734:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 738:	00001797          	auipc	a5,0x1
 73c:	8d87b783          	ld	a5,-1832(a5) # 1010 <freep>
 740:	a805                	j	770 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 742:	4618                	lw	a4,8(a2)
 744:	9db9                	addw	a1,a1,a4
 746:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 74a:	6398                	ld	a4,0(a5)
 74c:	6318                	ld	a4,0(a4)
 74e:	fee53823          	sd	a4,-16(a0)
 752:	a091                	j	796 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 754:	ff852703          	lw	a4,-8(a0)
 758:	9e39                	addw	a2,a2,a4
 75a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 75c:	ff053703          	ld	a4,-16(a0)
 760:	e398                	sd	a4,0(a5)
 762:	a099                	j	7a8 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 764:	6398                	ld	a4,0(a5)
 766:	00e7e463          	bltu	a5,a4,76e <free+0x40>
 76a:	00e6ea63          	bltu	a3,a4,77e <free+0x50>
{
 76e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 770:	fed7fae3          	bgeu	a5,a3,764 <free+0x36>
 774:	6398                	ld	a4,0(a5)
 776:	00e6e463          	bltu	a3,a4,77e <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77a:	fee7eae3          	bltu	a5,a4,76e <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 77e:	ff852583          	lw	a1,-8(a0)
 782:	6390                	ld	a2,0(a5)
 784:	02059713          	slli	a4,a1,0x20
 788:	9301                	srli	a4,a4,0x20
 78a:	0712                	slli	a4,a4,0x4
 78c:	9736                	add	a4,a4,a3
 78e:	fae60ae3          	beq	a2,a4,742 <free+0x14>
    bp->s.ptr = p->s.ptr;
 792:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 796:	4790                	lw	a2,8(a5)
 798:	02061713          	slli	a4,a2,0x20
 79c:	9301                	srli	a4,a4,0x20
 79e:	0712                	slli	a4,a4,0x4
 7a0:	973e                	add	a4,a4,a5
 7a2:	fae689e3          	beq	a3,a4,754 <free+0x26>
  } else
    p->s.ptr = bp;
 7a6:	e394                	sd	a3,0(a5)
  freep = p;
 7a8:	00001717          	auipc	a4,0x1
 7ac:	86f73423          	sd	a5,-1944(a4) # 1010 <freep>
}
 7b0:	6422                	ld	s0,8(sp)
 7b2:	0141                	addi	sp,sp,16
 7b4:	8082                	ret

00000000000007b6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7b6:	7139                	addi	sp,sp,-64
 7b8:	fc06                	sd	ra,56(sp)
 7ba:	f822                	sd	s0,48(sp)
 7bc:	f426                	sd	s1,40(sp)
 7be:	f04a                	sd	s2,32(sp)
 7c0:	ec4e                	sd	s3,24(sp)
 7c2:	e852                	sd	s4,16(sp)
 7c4:	e456                	sd	s5,8(sp)
 7c6:	e05a                	sd	s6,0(sp)
 7c8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ca:	02051493          	slli	s1,a0,0x20
 7ce:	9081                	srli	s1,s1,0x20
 7d0:	04bd                	addi	s1,s1,15
 7d2:	8091                	srli	s1,s1,0x4
 7d4:	0014899b          	addiw	s3,s1,1
 7d8:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7da:	00001517          	auipc	a0,0x1
 7de:	83653503          	ld	a0,-1994(a0) # 1010 <freep>
 7e2:	c515                	beqz	a0,80e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7e6:	4798                	lw	a4,8(a5)
 7e8:	02977f63          	bgeu	a4,s1,826 <malloc+0x70>
 7ec:	8a4e                	mv	s4,s3
 7ee:	0009871b          	sext.w	a4,s3
 7f2:	6685                	lui	a3,0x1
 7f4:	00d77363          	bgeu	a4,a3,7fa <malloc+0x44>
 7f8:	6a05                	lui	s4,0x1
 7fa:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7fe:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 802:	00001917          	auipc	s2,0x1
 806:	80e90913          	addi	s2,s2,-2034 # 1010 <freep>
  if(p == (char*)-1)
 80a:	5afd                	li	s5,-1
 80c:	a88d                	j	87e <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 80e:	00001797          	auipc	a5,0x1
 812:	82278793          	addi	a5,a5,-2014 # 1030 <base>
 816:	00000717          	auipc	a4,0x0
 81a:	7ef73d23          	sd	a5,2042(a4) # 1010 <freep>
 81e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 820:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 824:	b7e1                	j	7ec <malloc+0x36>
      if(p->s.size == nunits)
 826:	02e48b63          	beq	s1,a4,85c <malloc+0xa6>
        p->s.size -= nunits;
 82a:	4137073b          	subw	a4,a4,s3
 82e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 830:	1702                	slli	a4,a4,0x20
 832:	9301                	srli	a4,a4,0x20
 834:	0712                	slli	a4,a4,0x4
 836:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 838:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 83c:	00000717          	auipc	a4,0x0
 840:	7ca73a23          	sd	a0,2004(a4) # 1010 <freep>
      return (void*)(p + 1);
 844:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 848:	70e2                	ld	ra,56(sp)
 84a:	7442                	ld	s0,48(sp)
 84c:	74a2                	ld	s1,40(sp)
 84e:	7902                	ld	s2,32(sp)
 850:	69e2                	ld	s3,24(sp)
 852:	6a42                	ld	s4,16(sp)
 854:	6aa2                	ld	s5,8(sp)
 856:	6b02                	ld	s6,0(sp)
 858:	6121                	addi	sp,sp,64
 85a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 85c:	6398                	ld	a4,0(a5)
 85e:	e118                	sd	a4,0(a0)
 860:	bff1                	j	83c <malloc+0x86>
  hp->s.size = nu;
 862:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 866:	0541                	addi	a0,a0,16
 868:	00000097          	auipc	ra,0x0
 86c:	ec6080e7          	jalr	-314(ra) # 72e <free>
  return freep;
 870:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 874:	d971                	beqz	a0,848 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 876:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 878:	4798                	lw	a4,8(a5)
 87a:	fa9776e3          	bgeu	a4,s1,826 <malloc+0x70>
    if(p == freep)
 87e:	00093703          	ld	a4,0(s2)
 882:	853e                	mv	a0,a5
 884:	fef719e3          	bne	a4,a5,876 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 888:	8552                	mv	a0,s4
 88a:	00000097          	auipc	ra,0x0
 88e:	b7e080e7          	jalr	-1154(ra) # 408 <sbrk>
  if(p == (char*)-1)
 892:	fd5518e3          	bne	a0,s5,862 <malloc+0xac>
        return 0;
 896:	4501                	li	a0,0
 898:	bf45                	j	848 <malloc+0x92>

000000000000089a <uswtch>:
 89a:	00153023          	sd	ra,0(a0)
 89e:	00253423          	sd	sp,8(a0)
 8a2:	e900                	sd	s0,16(a0)
 8a4:	ed04                	sd	s1,24(a0)
 8a6:	03253023          	sd	s2,32(a0)
 8aa:	03353423          	sd	s3,40(a0)
 8ae:	03453823          	sd	s4,48(a0)
 8b2:	03553c23          	sd	s5,56(a0)
 8b6:	05653023          	sd	s6,64(a0)
 8ba:	05753423          	sd	s7,72(a0)
 8be:	05853823          	sd	s8,80(a0)
 8c2:	05953c23          	sd	s9,88(a0)
 8c6:	07a53023          	sd	s10,96(a0)
 8ca:	07b53423          	sd	s11,104(a0)
 8ce:	0005b083          	ld	ra,0(a1)
 8d2:	0085b103          	ld	sp,8(a1)
 8d6:	6980                	ld	s0,16(a1)
 8d8:	6d84                	ld	s1,24(a1)
 8da:	0205b903          	ld	s2,32(a1)
 8de:	0285b983          	ld	s3,40(a1)
 8e2:	0305ba03          	ld	s4,48(a1)
 8e6:	0385ba83          	ld	s5,56(a1)
 8ea:	0405bb03          	ld	s6,64(a1)
 8ee:	0485bb83          	ld	s7,72(a1)
 8f2:	0505bc03          	ld	s8,80(a1)
 8f6:	0585bc83          	ld	s9,88(a1)
 8fa:	0605bd03          	ld	s10,96(a1)
 8fe:	0685bd83          	ld	s11,104(a1)
 902:	8082                	ret

0000000000000904 <uthread_create>:
struct uthread uthreads[MAX_UTHREADS];
struct uthread *currentThread;
int ids = 0;

int uthread_create(void (*start_func)(), enum sched_priority priority)
{
 904:	1141                	addi	sp,sp,-16
 906:	e422                	sd	s0,8(sp)
 908:	0800                	addi	s0,sp,16
    int i;
    ids ++;
 90a:	00000797          	auipc	a5,0x0
 90e:	71278793          	addi	a5,a5,1810 # 101c <ids>
 912:	0007a303          	lw	t1,0(a5)
 916:	2305                	addiw	t1,t1,1
 918:	0067a023          	sw	t1,0(a5)

    for (i = 0; i < MAX_UTHREADS; i++)
 91c:	00001717          	auipc	a4,0x1
 920:	6c470713          	addi	a4,a4,1732 # 1fe0 <uthreads+0xfa0>
 924:	4781                	li	a5,0
 926:	6605                	lui	a2,0x1
 928:	02060613          	addi	a2,a2,32 # 1020 <currentThread>
 92c:	4811                	li	a6,4
    {
        if (uthreads[i].state == FREE)
 92e:	4314                	lw	a3,0(a4)
 930:	c699                	beqz	a3,93e <uthread_create+0x3a>
    for (i = 0; i < MAX_UTHREADS; i++)
 932:	2785                	addiw	a5,a5,1
 934:	9732                	add	a4,a4,a2
 936:	ff079ce3          	bne	a5,a6,92e <uthread_create+0x2a>
            break;
    }     

    if (i == MAX_UTHREADS)
        return -1;
 93a:	557d                	li	a0,-1
 93c:	a889                	j	98e <uthread_create+0x8a>
    if (i == MAX_UTHREADS)
 93e:	4711                	li	a4,4
 940:	04e78a63          	beq	a5,a4,994 <uthread_create+0x90>

    uthreads[i].context.ra = (uint64)start_func;
 944:	00000897          	auipc	a7,0x0
 948:	6fc88893          	addi	a7,a7,1788 # 1040 <uthreads>
 94c:	00779693          	slli	a3,a5,0x7
 950:	00f68633          	add	a2,a3,a5
 954:	0616                	slli	a2,a2,0x5
 956:	9646                	add	a2,a2,a7
 958:	6805                	lui	a6,0x1
 95a:	00c80e33          	add	t3,a6,a2
 95e:	faae3423          	sd	a0,-88(t3)
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
    uthreads[i].context.sp += sizeof(uint64);
 962:	00f68733          	add	a4,a3,a5
 966:	0716                	slli	a4,a4,0x5
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
 968:	fa080513          	addi	a0,a6,-96 # fa0 <digits+0x2d0>
 96c:	972a                	add	a4,a4,a0
 96e:	9746                	add	a4,a4,a7
    uthreads[i].context.sp += sizeof(uint64);
 970:	0721                	addi	a4,a4,8
 972:	faee3823          	sd	a4,-80(t3)
    uthreads[i].state = RUNNABLE;
 976:	4709                	li	a4,2
 978:	faee2023          	sw	a4,-96(t3)
    uthreads[i].priority = priority;
 97c:	00be2c23          	sw	a1,24(t3)
    currentThread = &uthreads[i];
 980:	00000717          	auipc	a4,0x0
 984:	6ac73023          	sd	a2,1696(a4) # 1020 <currentThread>

    currentThread->pid = ids;
 988:	006e2e23          	sw	t1,28(t3)

    return 0;
 98c:	4501                	li	a0,0
}
 98e:	6422                	ld	s0,8(sp)
 990:	0141                	addi	sp,sp,16
 992:	8082                	ret
        return -1;
 994:	557d                	li	a0,-1
 996:	bfe5                	j	98e <uthread_create+0x8a>

0000000000000998 <get_state>:
  currentThread->state = RUNNABLE;
  schedule();
}


char* get_state(enum tstate s){
 998:	1141                	addi	sp,sp,-16
 99a:	e422                	sd	s0,8(sp)
 99c:	0800                	addi	s0,sp,16
  switch (s)
 99e:	4705                	li	a4,1
 9a0:	02e50763          	beq	a0,a4,9ce <get_state+0x36>
 9a4:	87aa                	mv	a5,a0
 9a6:	4709                	li	a4,2
  case FREE:
    return "FREE";
  case  RUNNING:
    return "RUNNING";
  case RUNNABLE:
    return "RUNNABLE";
 9a8:	00000517          	auipc	a0,0x0
 9ac:	34850513          	addi	a0,a0,840 # cf0 <digits+0x20>
  switch (s)
 9b0:	00e78763          	beq	a5,a4,9be <get_state+0x26>
  }

  return "ERROR";
 9b4:	00000517          	auipc	a0,0x0
 9b8:	33450513          	addi	a0,a0,820 # ce8 <digits+0x18>
  switch (s)
 9bc:	c781                	beqz	a5,9c4 <get_state+0x2c>
}
 9be:	6422                	ld	s0,8(sp)
 9c0:	0141                	addi	sp,sp,16
 9c2:	8082                	ret
    return "FREE";
 9c4:	00000517          	auipc	a0,0x0
 9c8:	34450513          	addi	a0,a0,836 # d08 <digits+0x38>
 9cc:	bfcd                	j	9be <get_state+0x26>
  switch (s)
 9ce:	00000517          	auipc	a0,0x0
 9d2:	33250513          	addi	a0,a0,818 # d00 <digits+0x30>
 9d6:	b7e5                	j	9be <get_state+0x26>

00000000000009d8 <find_next>:
  uswtch(&cur->context, &next->context);
  
}


struct uthread *find_next(enum sched_priority priority){
 9d8:	1141                	addi	sp,sp,-16
 9da:	e422                	sd	s0,8(sp)
 9dc:	0800                	addi	s0,sp,16
  
  struct uthread* next = 0;
  int i;
  int j;
  j = (currentThread - uthreads + 1) % MAX_UTHREADS;
 9de:	00000717          	auipc	a4,0x0
 9e2:	64273703          	ld	a4,1602(a4) # 1020 <currentThread>
 9e6:	00000797          	auipc	a5,0x0
 9ea:	65a78793          	addi	a5,a5,1626 # 1040 <uthreads>
 9ee:	8f1d                	sub	a4,a4,a5
 9f0:	8715                	srai	a4,a4,0x5
 9f2:	00000797          	auipc	a5,0x0
 9f6:	24e7b783          	ld	a5,590(a5) # c40 <uthread_self+0x18>
 9fa:	02f70733          	mul	a4,a4,a5
 9fe:	0705                	addi	a4,a4,1
 a00:	43f75793          	srai	a5,a4,0x3f
 a04:	03e7d693          	srli	a3,a5,0x3e
 a08:	00d707b3          	add	a5,a4,a3
 a0c:	8b8d                	andi	a5,a5,3
 a0e:	8f95                	sub	a5,a5,a3
 a10:	4691                	li	a3,4

  for(i = 0; i < MAX_UTHREADS; i++){
    if((uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING) && uthreads[j].priority == priority){
 a12:	00000597          	auipc	a1,0x0
 a16:	62e58593          	addi	a1,a1,1582 # 1040 <uthreads>
 a1a:	6605                	lui	a2,0x1
 a1c:	4805                	li	a6,1
 a1e:	a819                	j	a34 <find_next+0x5c>
      next = &uthreads[j];
      break;
    }
    j = (j+1) % MAX_UTHREADS;    
 a20:	2785                	addiw	a5,a5,1
 a22:	41f7d71b          	sraiw	a4,a5,0x1f
 a26:	01e7571b          	srliw	a4,a4,0x1e
 a2a:	9fb9                	addw	a5,a5,a4
 a2c:	8b8d                	andi	a5,a5,3
 a2e:	9f99                	subw	a5,a5,a4
  for(i = 0; i < MAX_UTHREADS; i++){
 a30:	36fd                	addiw	a3,a3,-1
 a32:	ce9d                	beqz	a3,a70 <find_next+0x98>
    if((uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING) && uthreads[j].priority == priority){
 a34:	00779713          	slli	a4,a5,0x7
 a38:	973e                	add	a4,a4,a5
 a3a:	0716                	slli	a4,a4,0x5
 a3c:	972e                	add	a4,a4,a1
 a3e:	9732                	add	a4,a4,a2
 a40:	fa072703          	lw	a4,-96(a4)
 a44:	377d                	addiw	a4,a4,-1
 a46:	fce86de3          	bltu	a6,a4,a20 <find_next+0x48>
 a4a:	00779713          	slli	a4,a5,0x7
 a4e:	973e                	add	a4,a4,a5
 a50:	0716                	slli	a4,a4,0x5
 a52:	972e                	add	a4,a4,a1
 a54:	9732                	add	a4,a4,a2
 a56:	4f18                	lw	a4,24(a4)
 a58:	fca714e3          	bne	a4,a0,a20 <find_next+0x48>
      next = &uthreads[j];
 a5c:	00779513          	slli	a0,a5,0x7
 a60:	953e                	add	a0,a0,a5
 a62:	0516                	slli	a0,a0,0x5
 a64:	00000797          	auipc	a5,0x0
 a68:	5dc78793          	addi	a5,a5,1500 # 1040 <uthreads>
 a6c:	953e                	add	a0,a0,a5
      break;
 a6e:	a011                	j	a72 <find_next+0x9a>
  struct uthread* next = 0;
 a70:	4501                	li	a0,0
  }

  return next;
}
 a72:	6422                	ld	s0,8(sp)
 a74:	0141                	addi	sp,sp,16
 a76:	8082                	ret

0000000000000a78 <schedule>:
void schedule(){
 a78:	1101                	addi	sp,sp,-32
 a7a:	ec06                	sd	ra,24(sp)
 a7c:	e822                	sd	s0,16(sp)
 a7e:	e426                	sd	s1,8(sp)
 a80:	1000                	addi	s0,sp,32
  cur = currentThread;
 a82:	00000497          	auipc	s1,0x0
 a86:	59e4b483          	ld	s1,1438(s1) # 1020 <currentThread>
  next = find_next(HIGH);
 a8a:	4509                	li	a0,2
 a8c:	00000097          	auipc	ra,0x0
 a90:	f4c080e7          	jalr	-180(ra) # 9d8 <find_next>
  if(next == 0)
 a94:	c915                	beqz	a0,ac8 <schedule+0x50>
  currentThread = next;
 a96:	00000797          	auipc	a5,0x0
 a9a:	58a7b523          	sd	a0,1418(a5) # 1020 <currentThread>
  currentThread->state = RUNNING;
 a9e:	6785                	lui	a5,0x1
 aa0:	00f50733          	add	a4,a0,a5
 aa4:	4685                	li	a3,1
 aa6:	fad72023          	sw	a3,-96(a4)
  uswtch(&cur->context, &next->context);
 aaa:	fa878793          	addi	a5,a5,-88 # fa8 <digits+0x2d8>
 aae:	00f505b3          	add	a1,a0,a5
 ab2:	00f48533          	add	a0,s1,a5
 ab6:	00000097          	auipc	ra,0x0
 aba:	de4080e7          	jalr	-540(ra) # 89a <uswtch>
}
 abe:	60e2                	ld	ra,24(sp)
 ac0:	6442                	ld	s0,16(sp)
 ac2:	64a2                	ld	s1,8(sp)
 ac4:	6105                	addi	sp,sp,32
 ac6:	8082                	ret
    next = find_next(MEDIUM);
 ac8:	4505                	li	a0,1
 aca:	00000097          	auipc	ra,0x0
 ace:	f0e080e7          	jalr	-242(ra) # 9d8 <find_next>
  if(next == 0)
 ad2:	f171                	bnez	a0,a96 <schedule+0x1e>
    next = find_next(LOW);
 ad4:	00000097          	auipc	ra,0x0
 ad8:	f04080e7          	jalr	-252(ra) # 9d8 <find_next>
  if(next == 0)
 adc:	fd4d                	bnez	a0,a96 <schedule+0x1e>
    exit(-1);
 ade:	557d                	li	a0,-1
 ae0:	00000097          	auipc	ra,0x0
 ae4:	8a0080e7          	jalr	-1888(ra) # 380 <exit>

0000000000000ae8 <uthread_yield>:
{
 ae8:	1141                	addi	sp,sp,-16
 aea:	e406                	sd	ra,8(sp)
 aec:	e022                	sd	s0,0(sp)
 aee:	0800                	addi	s0,sp,16
  currentThread->state = RUNNABLE;
 af0:	00000797          	auipc	a5,0x0
 af4:	5307b783          	ld	a5,1328(a5) # 1020 <currentThread>
 af8:	6705                	lui	a4,0x1
 afa:	97ba                	add	a5,a5,a4
 afc:	4709                	li	a4,2
 afe:	fae7a023          	sw	a4,-96(a5)
  schedule();
 b02:	00000097          	auipc	ra,0x0
 b06:	f76080e7          	jalr	-138(ra) # a78 <schedule>
}
 b0a:	60a2                	ld	ra,8(sp)
 b0c:	6402                	ld	s0,0(sp)
 b0e:	0141                	addi	sp,sp,16
 b10:	8082                	ret

0000000000000b12 <uthread_exit>:

void uthread_exit()
{
 b12:	1141                	addi	sp,sp,-16
 b14:	e406                	sd	ra,8(sp)
 b16:	e022                	sd	s0,0(sp)
 b18:	0800                	addi	s0,sp,16
  currentThread->state = FREE;
 b1a:	00000797          	auipc	a5,0x0
 b1e:	5067b783          	ld	a5,1286(a5) # 1020 <currentThread>
 b22:	6705                	lui	a4,0x1
 b24:	97ba                	add	a5,a5,a4
 b26:	fa07a023          	sw	zero,-96(a5)
  int remainingThreads = 0;
  for (int i = 0; i < MAX_UTHREADS; i++) {
 b2a:	00001797          	auipc	a5,0x1
 b2e:	4b678793          	addi	a5,a5,1206 # 1fe0 <uthreads+0xfa0>
 b32:	00005597          	auipc	a1,0x5
 b36:	52e58593          	addi	a1,a1,1326 # 6060 <uthreads+0x5020>
  int remainingThreads = 0;
 b3a:	4501                	li	a0,0
    if (uthreads[i].state == RUNNABLE) 
 b3c:	4609                	li	a2,2
  for (int i = 0; i < MAX_UTHREADS; i++) {
 b3e:	6685                	lui	a3,0x1
 b40:	02068693          	addi	a3,a3,32 # 1020 <currentThread>
 b44:	a021                	j	b4c <uthread_exit+0x3a>
 b46:	97b6                	add	a5,a5,a3
 b48:	00b78763          	beq	a5,a1,b56 <uthread_exit+0x44>
    if (uthreads[i].state == RUNNABLE) 
 b4c:	4398                	lw	a4,0(a5)
 b4e:	fec71ce3          	bne	a4,a2,b46 <uthread_exit+0x34>
      remainingThreads++;
 b52:	2505                	addiw	a0,a0,1
 b54:	bfcd                	j	b46 <uthread_exit+0x34>
  }

  if (remainingThreads == 0){
 b56:	c909                	beqz	a0,b68 <uthread_exit+0x56>
    exit(0);
  }
  else 
  {
    schedule();
 b58:	00000097          	auipc	ra,0x0
 b5c:	f20080e7          	jalr	-224(ra) # a78 <schedule>
  }
}
 b60:	60a2                	ld	ra,8(sp)
 b62:	6402                	ld	s0,0(sp)
 b64:	0141                	addi	sp,sp,16
 b66:	8082                	ret
    exit(0);
 b68:	00000097          	auipc	ra,0x0
 b6c:	818080e7          	jalr	-2024(ra) # 380 <exit>

0000000000000b70 <uthread_set_priority>:

enum sched_priority uthread_set_priority(enum sched_priority priority)
{
 b70:	1141                	addi	sp,sp,-16
 b72:	e422                	sd	s0,8(sp)
 b74:	0800                	addi	s0,sp,16
  enum sched_priority prevPriority = currentThread->priority;
 b76:	00000797          	auipc	a5,0x0
 b7a:	4aa7b783          	ld	a5,1194(a5) # 1020 <currentThread>
 b7e:	6705                	lui	a4,0x1
 b80:	97ba                	add	a5,a5,a4
 b82:	4f98                	lw	a4,24(a5)
  currentThread->priority = priority;
 b84:	cf88                	sw	a0,24(a5)
  return prevPriority;
}
 b86:	853a                	mv	a0,a4
 b88:	6422                	ld	s0,8(sp)
 b8a:	0141                	addi	sp,sp,16
 b8c:	8082                	ret

0000000000000b8e <uthread_get_priority>:

enum sched_priority uthread_get_priority()
{
 b8e:	1141                	addi	sp,sp,-16
 b90:	e422                	sd	s0,8(sp)
 b92:	0800                	addi	s0,sp,16
    return currentThread->priority;
 b94:	00000797          	auipc	a5,0x0
 b98:	48c7b783          	ld	a5,1164(a5) # 1020 <currentThread>
 b9c:	6705                	lui	a4,0x1
 b9e:	97ba                	add	a5,a5,a4
}
 ba0:	4f88                	lw	a0,24(a5)
 ba2:	6422                	ld	s0,8(sp)
 ba4:	0141                	addi	sp,sp,16
 ba6:	8082                	ret

0000000000000ba8 <uthread_start_all>:

int uthreadStarted = 0;

int uthread_start_all() {
 ba8:	7175                	addi	sp,sp,-144
 baa:	e506                	sd	ra,136(sp)
 bac:	e122                	sd	s0,128(sp)
 bae:	fca6                	sd	s1,120(sp)
 bb0:	0900                	addi	s0,sp,144
  if (uthreadStarted) {
 bb2:	00000497          	auipc	s1,0x0
 bb6:	4664a483          	lw	s1,1126(s1) # 1018 <uthreadStarted>
 bba:	e4ad                	bnez	s1,c24 <uthread_start_all+0x7c>
    return -1;
  }
  uthreadStarted = 1;
 bbc:	4785                	li	a5,1
 bbe:	00000717          	auipc	a4,0x0
 bc2:	44f72d23          	sw	a5,1114(a4) # 1018 <uthreadStarted>

  struct context dummyContext;
  struct uthread *next; 

  next = find_next(HIGH);
 bc6:	4509                	li	a0,2
 bc8:	00000097          	auipc	ra,0x0
 bcc:	e10080e7          	jalr	-496(ra) # 9d8 <find_next>
  if(next == 0)
 bd0:	c915                	beqz	a0,c04 <uthread_start_all+0x5c>
  if(next == 0)
    next = find_next(LOW);
  if(next == 0)
    exit(-1);

  currentThread = next;
 bd2:	00000797          	auipc	a5,0x0
 bd6:	44a7b723          	sd	a0,1102(a5) # 1020 <currentThread>
  currentThread->state = RUNNING;
 bda:	6585                	lui	a1,0x1
 bdc:	00b507b3          	add	a5,a0,a1
 be0:	4705                	li	a4,1
 be2:	fae7a023          	sw	a4,-96(a5)

  uswtch(&dummyContext, &currentThread->context);
 be6:	fa858593          	addi	a1,a1,-88 # fa8 <digits+0x2d8>
 bea:	95aa                	add	a1,a1,a0
 bec:	f7040513          	addi	a0,s0,-144
 bf0:	00000097          	auipc	ra,0x0
 bf4:	caa080e7          	jalr	-854(ra) # 89a <uswtch>

  return 0;
}
 bf8:	8526                	mv	a0,s1
 bfa:	60aa                	ld	ra,136(sp)
 bfc:	640a                	ld	s0,128(sp)
 bfe:	74e6                	ld	s1,120(sp)
 c00:	6149                	addi	sp,sp,144
 c02:	8082                	ret
    next = find_next(MEDIUM);
 c04:	4505                	li	a0,1
 c06:	00000097          	auipc	ra,0x0
 c0a:	dd2080e7          	jalr	-558(ra) # 9d8 <find_next>
  if(next == 0)
 c0e:	f171                	bnez	a0,bd2 <uthread_start_all+0x2a>
    next = find_next(LOW);
 c10:	00000097          	auipc	ra,0x0
 c14:	dc8080e7          	jalr	-568(ra) # 9d8 <find_next>
  if(next == 0)
 c18:	fd4d                	bnez	a0,bd2 <uthread_start_all+0x2a>
    exit(-1);
 c1a:	557d                	li	a0,-1
 c1c:	fffff097          	auipc	ra,0xfffff
 c20:	764080e7          	jalr	1892(ra) # 380 <exit>
    return -1;
 c24:	54fd                	li	s1,-1
 c26:	bfc9                	j	bf8 <uthread_start_all+0x50>

0000000000000c28 <uthread_self>:


struct uthread *uthread_self()
{
 c28:	1141                	addi	sp,sp,-16
 c2a:	e422                	sd	s0,8(sp)
 c2c:	0800                	addi	s0,sp,16
    return currentThread;
 c2e:	00000517          	auipc	a0,0x0
 c32:	3f253503          	ld	a0,1010(a0) # 1020 <currentThread>
 c36:	6422                	ld	s0,8(sp)
 c38:	0141                	addi	sp,sp,16
 c3a:	8082                	ret
