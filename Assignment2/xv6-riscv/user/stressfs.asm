
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	addi	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	c7a78793          	addi	a5,a5,-902 # c90 <uthread_self+0x54>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	c3450513          	addi	a0,a0,-972 # c60 <uthread_self+0x24>
  34:	00000097          	auipc	ra,0x0
  38:	6d8080e7          	jalr	1752(ra) # 70c <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	dd040513          	addi	a0,s0,-560
  48:	00000097          	auipc	ra,0x0
  4c:	150080e7          	jalr	336(ra) # 198 <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	00000097          	auipc	ra,0x0
  58:	338080e7          	jalr	824(ra) # 38c <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for(i = 0; i < 4; i++)
  60:	2485                	addiw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00001517          	auipc	a0,0x1
  6c:	c1050513          	addi	a0,a0,-1008 # c78 <uthread_self+0x3c>
  70:	00000097          	auipc	ra,0x0
  74:	69c080e7          	jalr	1692(ra) # 70c <printf>

  path[8] += i;
  78:	fd844783          	lbu	a5,-40(s0)
  7c:	9cbd                	addw	s1,s1,a5
  7e:	fc940c23          	sb	s1,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  82:	20200593          	li	a1,514
  86:	fd040513          	addi	a0,s0,-48
  8a:	00000097          	auipc	ra,0x0
  8e:	34a080e7          	jalr	842(ra) # 3d4 <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	dd040593          	addi	a1,s0,-560
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	314080e7          	jalr	788(ra) # 3b4 <write>
  for(i = 0; i < 20; i++)
  a8:	34fd                	addiw	s1,s1,-1
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	30e080e7          	jalr	782(ra) # 3bc <close>

  printf("read\n");
  b6:	00001517          	auipc	a0,0x1
  ba:	bd250513          	addi	a0,a0,-1070 # c88 <uthread_self+0x4c>
  be:	00000097          	auipc	ra,0x0
  c2:	64e080e7          	jalr	1614(ra) # 70c <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	fd040513          	addi	a0,s0,-48
  cc:	00000097          	auipc	ra,0x0
  d0:	308080e7          	jalr	776(ra) # 3d4 <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	dd040593          	addi	a1,s0,-560
  e0:	854a                	mv	a0,s2
  e2:	00000097          	auipc	ra,0x0
  e6:	2ca080e7          	jalr	714(ra) # 3ac <read>
  for (i = 0; i < 20; i++)
  ea:	34fd                	addiw	s1,s1,-1
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	2cc080e7          	jalr	716(ra) # 3bc <close>

  wait(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	2a2080e7          	jalr	674(ra) # 39c <wait>

  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	290080e7          	jalr	656(ra) # 394 <exit>

000000000000010c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e406                	sd	ra,8(sp)
 110:	e022                	sd	s0,0(sp)
 112:	0800                	addi	s0,sp,16
  extern int main();
  main();
 114:	00000097          	auipc	ra,0x0
 118:	eec080e7          	jalr	-276(ra) # 0 <main>
  exit(0);
 11c:	4501                	li	a0,0
 11e:	00000097          	auipc	ra,0x0
 122:	276080e7          	jalr	630(ra) # 394 <exit>

0000000000000126 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 126:	1141                	addi	sp,sp,-16
 128:	e422                	sd	s0,8(sp)
 12a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 12c:	87aa                	mv	a5,a0
 12e:	0585                	addi	a1,a1,1
 130:	0785                	addi	a5,a5,1
 132:	fff5c703          	lbu	a4,-1(a1)
 136:	fee78fa3          	sb	a4,-1(a5)
 13a:	fb75                	bnez	a4,12e <strcpy+0x8>
    ;
  return os;
}
 13c:	6422                	ld	s0,8(sp)
 13e:	0141                	addi	sp,sp,16
 140:	8082                	ret

0000000000000142 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 142:	1141                	addi	sp,sp,-16
 144:	e422                	sd	s0,8(sp)
 146:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 148:	00054783          	lbu	a5,0(a0)
 14c:	cb91                	beqz	a5,160 <strcmp+0x1e>
 14e:	0005c703          	lbu	a4,0(a1)
 152:	00f71763          	bne	a4,a5,160 <strcmp+0x1e>
    p++, q++;
 156:	0505                	addi	a0,a0,1
 158:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 15a:	00054783          	lbu	a5,0(a0)
 15e:	fbe5                	bnez	a5,14e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 160:	0005c503          	lbu	a0,0(a1)
}
 164:	40a7853b          	subw	a0,a5,a0
 168:	6422                	ld	s0,8(sp)
 16a:	0141                	addi	sp,sp,16
 16c:	8082                	ret

000000000000016e <strlen>:

uint
strlen(const char *s)
{
 16e:	1141                	addi	sp,sp,-16
 170:	e422                	sd	s0,8(sp)
 172:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 174:	00054783          	lbu	a5,0(a0)
 178:	cf91                	beqz	a5,194 <strlen+0x26>
 17a:	0505                	addi	a0,a0,1
 17c:	87aa                	mv	a5,a0
 17e:	4685                	li	a3,1
 180:	9e89                	subw	a3,a3,a0
 182:	00f6853b          	addw	a0,a3,a5
 186:	0785                	addi	a5,a5,1
 188:	fff7c703          	lbu	a4,-1(a5)
 18c:	fb7d                	bnez	a4,182 <strlen+0x14>
    ;
  return n;
}
 18e:	6422                	ld	s0,8(sp)
 190:	0141                	addi	sp,sp,16
 192:	8082                	ret
  for(n = 0; s[n]; n++)
 194:	4501                	li	a0,0
 196:	bfe5                	j	18e <strlen+0x20>

0000000000000198 <memset>:

void*
memset(void *dst, int c, uint n)
{
 198:	1141                	addi	sp,sp,-16
 19a:	e422                	sd	s0,8(sp)
 19c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 19e:	ca19                	beqz	a2,1b4 <memset+0x1c>
 1a0:	87aa                	mv	a5,a0
 1a2:	1602                	slli	a2,a2,0x20
 1a4:	9201                	srli	a2,a2,0x20
 1a6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1aa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1ae:	0785                	addi	a5,a5,1
 1b0:	fee79de3          	bne	a5,a4,1aa <memset+0x12>
  }
  return dst;
}
 1b4:	6422                	ld	s0,8(sp)
 1b6:	0141                	addi	sp,sp,16
 1b8:	8082                	ret

00000000000001ba <strchr>:

char*
strchr(const char *s, char c)
{
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	cb99                	beqz	a5,1da <strchr+0x20>
    if(*s == c)
 1c6:	00f58763          	beq	a1,a5,1d4 <strchr+0x1a>
  for(; *s; s++)
 1ca:	0505                	addi	a0,a0,1
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	fbfd                	bnez	a5,1c6 <strchr+0xc>
      return (char*)s;
  return 0;
 1d2:	4501                	li	a0,0
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	addi	sp,sp,16
 1d8:	8082                	ret
  return 0;
 1da:	4501                	li	a0,0
 1dc:	bfe5                	j	1d4 <strchr+0x1a>

00000000000001de <gets>:

char*
gets(char *buf, int max)
{
 1de:	711d                	addi	sp,sp,-96
 1e0:	ec86                	sd	ra,88(sp)
 1e2:	e8a2                	sd	s0,80(sp)
 1e4:	e4a6                	sd	s1,72(sp)
 1e6:	e0ca                	sd	s2,64(sp)
 1e8:	fc4e                	sd	s3,56(sp)
 1ea:	f852                	sd	s4,48(sp)
 1ec:	f456                	sd	s5,40(sp)
 1ee:	f05a                	sd	s6,32(sp)
 1f0:	ec5e                	sd	s7,24(sp)
 1f2:	1080                	addi	s0,sp,96
 1f4:	8baa                	mv	s7,a0
 1f6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f8:	892a                	mv	s2,a0
 1fa:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1fc:	4aa9                	li	s5,10
 1fe:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 200:	89a6                	mv	s3,s1
 202:	2485                	addiw	s1,s1,1
 204:	0344d863          	bge	s1,s4,234 <gets+0x56>
    cc = read(0, &c, 1);
 208:	4605                	li	a2,1
 20a:	faf40593          	addi	a1,s0,-81
 20e:	4501                	li	a0,0
 210:	00000097          	auipc	ra,0x0
 214:	19c080e7          	jalr	412(ra) # 3ac <read>
    if(cc < 1)
 218:	00a05e63          	blez	a0,234 <gets+0x56>
    buf[i++] = c;
 21c:	faf44783          	lbu	a5,-81(s0)
 220:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 224:	01578763          	beq	a5,s5,232 <gets+0x54>
 228:	0905                	addi	s2,s2,1
 22a:	fd679be3          	bne	a5,s6,200 <gets+0x22>
  for(i=0; i+1 < max; ){
 22e:	89a6                	mv	s3,s1
 230:	a011                	j	234 <gets+0x56>
 232:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 234:	99de                	add	s3,s3,s7
 236:	00098023          	sb	zero,0(s3)
  return buf;
}
 23a:	855e                	mv	a0,s7
 23c:	60e6                	ld	ra,88(sp)
 23e:	6446                	ld	s0,80(sp)
 240:	64a6                	ld	s1,72(sp)
 242:	6906                	ld	s2,64(sp)
 244:	79e2                	ld	s3,56(sp)
 246:	7a42                	ld	s4,48(sp)
 248:	7aa2                	ld	s5,40(sp)
 24a:	7b02                	ld	s6,32(sp)
 24c:	6be2                	ld	s7,24(sp)
 24e:	6125                	addi	sp,sp,96
 250:	8082                	ret

0000000000000252 <stat>:

int
stat(const char *n, struct stat *st)
{
 252:	1101                	addi	sp,sp,-32
 254:	ec06                	sd	ra,24(sp)
 256:	e822                	sd	s0,16(sp)
 258:	e426                	sd	s1,8(sp)
 25a:	e04a                	sd	s2,0(sp)
 25c:	1000                	addi	s0,sp,32
 25e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 260:	4581                	li	a1,0
 262:	00000097          	auipc	ra,0x0
 266:	172080e7          	jalr	370(ra) # 3d4 <open>
  if(fd < 0)
 26a:	02054563          	bltz	a0,294 <stat+0x42>
 26e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 270:	85ca                	mv	a1,s2
 272:	00000097          	auipc	ra,0x0
 276:	17a080e7          	jalr	378(ra) # 3ec <fstat>
 27a:	892a                	mv	s2,a0
  close(fd);
 27c:	8526                	mv	a0,s1
 27e:	00000097          	auipc	ra,0x0
 282:	13e080e7          	jalr	318(ra) # 3bc <close>
  return r;
}
 286:	854a                	mv	a0,s2
 288:	60e2                	ld	ra,24(sp)
 28a:	6442                	ld	s0,16(sp)
 28c:	64a2                	ld	s1,8(sp)
 28e:	6902                	ld	s2,0(sp)
 290:	6105                	addi	sp,sp,32
 292:	8082                	ret
    return -1;
 294:	597d                	li	s2,-1
 296:	bfc5                	j	286 <stat+0x34>

0000000000000298 <atoi>:

int
atoi(const char *s)
{
 298:	1141                	addi	sp,sp,-16
 29a:	e422                	sd	s0,8(sp)
 29c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29e:	00054603          	lbu	a2,0(a0)
 2a2:	fd06079b          	addiw	a5,a2,-48
 2a6:	0ff7f793          	andi	a5,a5,255
 2aa:	4725                	li	a4,9
 2ac:	02f76963          	bltu	a4,a5,2de <atoi+0x46>
 2b0:	86aa                	mv	a3,a0
  n = 0;
 2b2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2b4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2b6:	0685                	addi	a3,a3,1
 2b8:	0025179b          	slliw	a5,a0,0x2
 2bc:	9fa9                	addw	a5,a5,a0
 2be:	0017979b          	slliw	a5,a5,0x1
 2c2:	9fb1                	addw	a5,a5,a2
 2c4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c8:	0006c603          	lbu	a2,0(a3)
 2cc:	fd06071b          	addiw	a4,a2,-48
 2d0:	0ff77713          	andi	a4,a4,255
 2d4:	fee5f1e3          	bgeu	a1,a4,2b6 <atoi+0x1e>
  return n;
}
 2d8:	6422                	ld	s0,8(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret
  n = 0;
 2de:	4501                	li	a0,0
 2e0:	bfe5                	j	2d8 <atoi+0x40>

00000000000002e2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2e2:	1141                	addi	sp,sp,-16
 2e4:	e422                	sd	s0,8(sp)
 2e6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2e8:	02b57463          	bgeu	a0,a1,310 <memmove+0x2e>
    while(n-- > 0)
 2ec:	00c05f63          	blez	a2,30a <memmove+0x28>
 2f0:	1602                	slli	a2,a2,0x20
 2f2:	9201                	srli	a2,a2,0x20
 2f4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2f8:	872a                	mv	a4,a0
      *dst++ = *src++;
 2fa:	0585                	addi	a1,a1,1
 2fc:	0705                	addi	a4,a4,1
 2fe:	fff5c683          	lbu	a3,-1(a1)
 302:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 306:	fee79ae3          	bne	a5,a4,2fa <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 30a:	6422                	ld	s0,8(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret
    dst += n;
 310:	00c50733          	add	a4,a0,a2
    src += n;
 314:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 316:	fec05ae3          	blez	a2,30a <memmove+0x28>
 31a:	fff6079b          	addiw	a5,a2,-1
 31e:	1782                	slli	a5,a5,0x20
 320:	9381                	srli	a5,a5,0x20
 322:	fff7c793          	not	a5,a5
 326:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 328:	15fd                	addi	a1,a1,-1
 32a:	177d                	addi	a4,a4,-1
 32c:	0005c683          	lbu	a3,0(a1)
 330:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 334:	fee79ae3          	bne	a5,a4,328 <memmove+0x46>
 338:	bfc9                	j	30a <memmove+0x28>

000000000000033a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e422                	sd	s0,8(sp)
 33e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 340:	ca05                	beqz	a2,370 <memcmp+0x36>
 342:	fff6069b          	addiw	a3,a2,-1
 346:	1682                	slli	a3,a3,0x20
 348:	9281                	srli	a3,a3,0x20
 34a:	0685                	addi	a3,a3,1
 34c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 34e:	00054783          	lbu	a5,0(a0)
 352:	0005c703          	lbu	a4,0(a1)
 356:	00e79863          	bne	a5,a4,366 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 35a:	0505                	addi	a0,a0,1
    p2++;
 35c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 35e:	fed518e3          	bne	a0,a3,34e <memcmp+0x14>
  }
  return 0;
 362:	4501                	li	a0,0
 364:	a019                	j	36a <memcmp+0x30>
      return *p1 - *p2;
 366:	40e7853b          	subw	a0,a5,a4
}
 36a:	6422                	ld	s0,8(sp)
 36c:	0141                	addi	sp,sp,16
 36e:	8082                	ret
  return 0;
 370:	4501                	li	a0,0
 372:	bfe5                	j	36a <memcmp+0x30>

0000000000000374 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 374:	1141                	addi	sp,sp,-16
 376:	e406                	sd	ra,8(sp)
 378:	e022                	sd	s0,0(sp)
 37a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 37c:	00000097          	auipc	ra,0x0
 380:	f66080e7          	jalr	-154(ra) # 2e2 <memmove>
}
 384:	60a2                	ld	ra,8(sp)
 386:	6402                	ld	s0,0(sp)
 388:	0141                	addi	sp,sp,16
 38a:	8082                	ret

000000000000038c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 38c:	4885                	li	a7,1
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <exit>:
.global exit
exit:
 li a7, SYS_exit
 394:	4889                	li	a7,2
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <wait>:
.global wait
wait:
 li a7, SYS_wait
 39c:	488d                	li	a7,3
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3a4:	4891                	li	a7,4
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <read>:
.global read
read:
 li a7, SYS_read
 3ac:	4895                	li	a7,5
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <write>:
.global write
write:
 li a7, SYS_write
 3b4:	48c1                	li	a7,16
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <close>:
.global close
close:
 li a7, SYS_close
 3bc:	48d5                	li	a7,21
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3c4:	4899                	li	a7,6
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <exec>:
.global exec
exec:
 li a7, SYS_exec
 3cc:	489d                	li	a7,7
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <open>:
.global open
open:
 li a7, SYS_open
 3d4:	48bd                	li	a7,15
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3dc:	48c5                	li	a7,17
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3e4:	48c9                	li	a7,18
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ec:	48a1                	li	a7,8
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <link>:
.global link
link:
 li a7, SYS_link
 3f4:	48cd                	li	a7,19
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3fc:	48d1                	li	a7,20
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 404:	48a5                	li	a7,9
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <dup>:
.global dup
dup:
 li a7, SYS_dup
 40c:	48a9                	li	a7,10
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 414:	48ad                	li	a7,11
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 41c:	48b1                	li	a7,12
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 424:	48b5                	li	a7,13
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 42c:	48b9                	li	a7,14
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 434:	1101                	addi	sp,sp,-32
 436:	ec06                	sd	ra,24(sp)
 438:	e822                	sd	s0,16(sp)
 43a:	1000                	addi	s0,sp,32
 43c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 440:	4605                	li	a2,1
 442:	fef40593          	addi	a1,s0,-17
 446:	00000097          	auipc	ra,0x0
 44a:	f6e080e7          	jalr	-146(ra) # 3b4 <write>
}
 44e:	60e2                	ld	ra,24(sp)
 450:	6442                	ld	s0,16(sp)
 452:	6105                	addi	sp,sp,32
 454:	8082                	ret

0000000000000456 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 456:	7139                	addi	sp,sp,-64
 458:	fc06                	sd	ra,56(sp)
 45a:	f822                	sd	s0,48(sp)
 45c:	f426                	sd	s1,40(sp)
 45e:	f04a                	sd	s2,32(sp)
 460:	ec4e                	sd	s3,24(sp)
 462:	0080                	addi	s0,sp,64
 464:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 466:	c299                	beqz	a3,46c <printint+0x16>
 468:	0805c863          	bltz	a1,4f8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 46c:	2581                	sext.w	a1,a1
  neg = 0;
 46e:	4881                	li	a7,0
 470:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 474:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 476:	2601                	sext.w	a2,a2
 478:	00001517          	auipc	a0,0x1
 47c:	83050513          	addi	a0,a0,-2000 # ca8 <digits>
 480:	883a                	mv	a6,a4
 482:	2705                	addiw	a4,a4,1
 484:	02c5f7bb          	remuw	a5,a1,a2
 488:	1782                	slli	a5,a5,0x20
 48a:	9381                	srli	a5,a5,0x20
 48c:	97aa                	add	a5,a5,a0
 48e:	0007c783          	lbu	a5,0(a5)
 492:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 496:	0005879b          	sext.w	a5,a1
 49a:	02c5d5bb          	divuw	a1,a1,a2
 49e:	0685                	addi	a3,a3,1
 4a0:	fec7f0e3          	bgeu	a5,a2,480 <printint+0x2a>
  if(neg)
 4a4:	00088b63          	beqz	a7,4ba <printint+0x64>
    buf[i++] = '-';
 4a8:	fd040793          	addi	a5,s0,-48
 4ac:	973e                	add	a4,a4,a5
 4ae:	02d00793          	li	a5,45
 4b2:	fef70823          	sb	a5,-16(a4)
 4b6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4ba:	02e05863          	blez	a4,4ea <printint+0x94>
 4be:	fc040793          	addi	a5,s0,-64
 4c2:	00e78933          	add	s2,a5,a4
 4c6:	fff78993          	addi	s3,a5,-1
 4ca:	99ba                	add	s3,s3,a4
 4cc:	377d                	addiw	a4,a4,-1
 4ce:	1702                	slli	a4,a4,0x20
 4d0:	9301                	srli	a4,a4,0x20
 4d2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4d6:	fff94583          	lbu	a1,-1(s2)
 4da:	8526                	mv	a0,s1
 4dc:	00000097          	auipc	ra,0x0
 4e0:	f58080e7          	jalr	-168(ra) # 434 <putc>
  while(--i >= 0)
 4e4:	197d                	addi	s2,s2,-1
 4e6:	ff3918e3          	bne	s2,s3,4d6 <printint+0x80>
}
 4ea:	70e2                	ld	ra,56(sp)
 4ec:	7442                	ld	s0,48(sp)
 4ee:	74a2                	ld	s1,40(sp)
 4f0:	7902                	ld	s2,32(sp)
 4f2:	69e2                	ld	s3,24(sp)
 4f4:	6121                	addi	sp,sp,64
 4f6:	8082                	ret
    x = -xx;
 4f8:	40b005bb          	negw	a1,a1
    neg = 1;
 4fc:	4885                	li	a7,1
    x = -xx;
 4fe:	bf8d                	j	470 <printint+0x1a>

0000000000000500 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 500:	7119                	addi	sp,sp,-128
 502:	fc86                	sd	ra,120(sp)
 504:	f8a2                	sd	s0,112(sp)
 506:	f4a6                	sd	s1,104(sp)
 508:	f0ca                	sd	s2,96(sp)
 50a:	ecce                	sd	s3,88(sp)
 50c:	e8d2                	sd	s4,80(sp)
 50e:	e4d6                	sd	s5,72(sp)
 510:	e0da                	sd	s6,64(sp)
 512:	fc5e                	sd	s7,56(sp)
 514:	f862                	sd	s8,48(sp)
 516:	f466                	sd	s9,40(sp)
 518:	f06a                	sd	s10,32(sp)
 51a:	ec6e                	sd	s11,24(sp)
 51c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 51e:	0005c903          	lbu	s2,0(a1)
 522:	18090f63          	beqz	s2,6c0 <vprintf+0x1c0>
 526:	8aaa                	mv	s5,a0
 528:	8b32                	mv	s6,a2
 52a:	00158493          	addi	s1,a1,1
  state = 0;
 52e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 530:	02500a13          	li	s4,37
      if(c == 'd'){
 534:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 538:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 53c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 540:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 544:	00000b97          	auipc	s7,0x0
 548:	764b8b93          	addi	s7,s7,1892 # ca8 <digits>
 54c:	a839                	j	56a <vprintf+0x6a>
        putc(fd, c);
 54e:	85ca                	mv	a1,s2
 550:	8556                	mv	a0,s5
 552:	00000097          	auipc	ra,0x0
 556:	ee2080e7          	jalr	-286(ra) # 434 <putc>
 55a:	a019                	j	560 <vprintf+0x60>
    } else if(state == '%'){
 55c:	01498f63          	beq	s3,s4,57a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 560:	0485                	addi	s1,s1,1
 562:	fff4c903          	lbu	s2,-1(s1)
 566:	14090d63          	beqz	s2,6c0 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 56a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 56e:	fe0997e3          	bnez	s3,55c <vprintf+0x5c>
      if(c == '%'){
 572:	fd479ee3          	bne	a5,s4,54e <vprintf+0x4e>
        state = '%';
 576:	89be                	mv	s3,a5
 578:	b7e5                	j	560 <vprintf+0x60>
      if(c == 'd'){
 57a:	05878063          	beq	a5,s8,5ba <vprintf+0xba>
      } else if(c == 'l') {
 57e:	05978c63          	beq	a5,s9,5d6 <vprintf+0xd6>
      } else if(c == 'x') {
 582:	07a78863          	beq	a5,s10,5f2 <vprintf+0xf2>
      } else if(c == 'p') {
 586:	09b78463          	beq	a5,s11,60e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 58a:	07300713          	li	a4,115
 58e:	0ce78663          	beq	a5,a4,65a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 592:	06300713          	li	a4,99
 596:	0ee78e63          	beq	a5,a4,692 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 59a:	11478863          	beq	a5,s4,6aa <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 59e:	85d2                	mv	a1,s4
 5a0:	8556                	mv	a0,s5
 5a2:	00000097          	auipc	ra,0x0
 5a6:	e92080e7          	jalr	-366(ra) # 434 <putc>
        putc(fd, c);
 5aa:	85ca                	mv	a1,s2
 5ac:	8556                	mv	a0,s5
 5ae:	00000097          	auipc	ra,0x0
 5b2:	e86080e7          	jalr	-378(ra) # 434 <putc>
      }
      state = 0;
 5b6:	4981                	li	s3,0
 5b8:	b765                	j	560 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5ba:	008b0913          	addi	s2,s6,8
 5be:	4685                	li	a3,1
 5c0:	4629                	li	a2,10
 5c2:	000b2583          	lw	a1,0(s6)
 5c6:	8556                	mv	a0,s5
 5c8:	00000097          	auipc	ra,0x0
 5cc:	e8e080e7          	jalr	-370(ra) # 456 <printint>
 5d0:	8b4a                	mv	s6,s2
      state = 0;
 5d2:	4981                	li	s3,0
 5d4:	b771                	j	560 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5d6:	008b0913          	addi	s2,s6,8
 5da:	4681                	li	a3,0
 5dc:	4629                	li	a2,10
 5de:	000b2583          	lw	a1,0(s6)
 5e2:	8556                	mv	a0,s5
 5e4:	00000097          	auipc	ra,0x0
 5e8:	e72080e7          	jalr	-398(ra) # 456 <printint>
 5ec:	8b4a                	mv	s6,s2
      state = 0;
 5ee:	4981                	li	s3,0
 5f0:	bf85                	j	560 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5f2:	008b0913          	addi	s2,s6,8
 5f6:	4681                	li	a3,0
 5f8:	4641                	li	a2,16
 5fa:	000b2583          	lw	a1,0(s6)
 5fe:	8556                	mv	a0,s5
 600:	00000097          	auipc	ra,0x0
 604:	e56080e7          	jalr	-426(ra) # 456 <printint>
 608:	8b4a                	mv	s6,s2
      state = 0;
 60a:	4981                	li	s3,0
 60c:	bf91                	j	560 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 60e:	008b0793          	addi	a5,s6,8
 612:	f8f43423          	sd	a5,-120(s0)
 616:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 61a:	03000593          	li	a1,48
 61e:	8556                	mv	a0,s5
 620:	00000097          	auipc	ra,0x0
 624:	e14080e7          	jalr	-492(ra) # 434 <putc>
  putc(fd, 'x');
 628:	85ea                	mv	a1,s10
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	e08080e7          	jalr	-504(ra) # 434 <putc>
 634:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 636:	03c9d793          	srli	a5,s3,0x3c
 63a:	97de                	add	a5,a5,s7
 63c:	0007c583          	lbu	a1,0(a5)
 640:	8556                	mv	a0,s5
 642:	00000097          	auipc	ra,0x0
 646:	df2080e7          	jalr	-526(ra) # 434 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 64a:	0992                	slli	s3,s3,0x4
 64c:	397d                	addiw	s2,s2,-1
 64e:	fe0914e3          	bnez	s2,636 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 652:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 656:	4981                	li	s3,0
 658:	b721                	j	560 <vprintf+0x60>
        s = va_arg(ap, char*);
 65a:	008b0993          	addi	s3,s6,8
 65e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 662:	02090163          	beqz	s2,684 <vprintf+0x184>
        while(*s != 0){
 666:	00094583          	lbu	a1,0(s2)
 66a:	c9a1                	beqz	a1,6ba <vprintf+0x1ba>
          putc(fd, *s);
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	dc6080e7          	jalr	-570(ra) # 434 <putc>
          s++;
 676:	0905                	addi	s2,s2,1
        while(*s != 0){
 678:	00094583          	lbu	a1,0(s2)
 67c:	f9e5                	bnez	a1,66c <vprintf+0x16c>
        s = va_arg(ap, char*);
 67e:	8b4e                	mv	s6,s3
      state = 0;
 680:	4981                	li	s3,0
 682:	bdf9                	j	560 <vprintf+0x60>
          s = "(null)";
 684:	00000917          	auipc	s2,0x0
 688:	61c90913          	addi	s2,s2,1564 # ca0 <uthread_self+0x64>
        while(*s != 0){
 68c:	02800593          	li	a1,40
 690:	bff1                	j	66c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 692:	008b0913          	addi	s2,s6,8
 696:	000b4583          	lbu	a1,0(s6)
 69a:	8556                	mv	a0,s5
 69c:	00000097          	auipc	ra,0x0
 6a0:	d98080e7          	jalr	-616(ra) # 434 <putc>
 6a4:	8b4a                	mv	s6,s2
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	bd65                	j	560 <vprintf+0x60>
        putc(fd, c);
 6aa:	85d2                	mv	a1,s4
 6ac:	8556                	mv	a0,s5
 6ae:	00000097          	auipc	ra,0x0
 6b2:	d86080e7          	jalr	-634(ra) # 434 <putc>
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	b565                	j	560 <vprintf+0x60>
        s = va_arg(ap, char*);
 6ba:	8b4e                	mv	s6,s3
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	b54d                	j	560 <vprintf+0x60>
    }
  }
}
 6c0:	70e6                	ld	ra,120(sp)
 6c2:	7446                	ld	s0,112(sp)
 6c4:	74a6                	ld	s1,104(sp)
 6c6:	7906                	ld	s2,96(sp)
 6c8:	69e6                	ld	s3,88(sp)
 6ca:	6a46                	ld	s4,80(sp)
 6cc:	6aa6                	ld	s5,72(sp)
 6ce:	6b06                	ld	s6,64(sp)
 6d0:	7be2                	ld	s7,56(sp)
 6d2:	7c42                	ld	s8,48(sp)
 6d4:	7ca2                	ld	s9,40(sp)
 6d6:	7d02                	ld	s10,32(sp)
 6d8:	6de2                	ld	s11,24(sp)
 6da:	6109                	addi	sp,sp,128
 6dc:	8082                	ret

00000000000006de <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6de:	715d                	addi	sp,sp,-80
 6e0:	ec06                	sd	ra,24(sp)
 6e2:	e822                	sd	s0,16(sp)
 6e4:	1000                	addi	s0,sp,32
 6e6:	e010                	sd	a2,0(s0)
 6e8:	e414                	sd	a3,8(s0)
 6ea:	e818                	sd	a4,16(s0)
 6ec:	ec1c                	sd	a5,24(s0)
 6ee:	03043023          	sd	a6,32(s0)
 6f2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6f6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6fa:	8622                	mv	a2,s0
 6fc:	00000097          	auipc	ra,0x0
 700:	e04080e7          	jalr	-508(ra) # 500 <vprintf>
}
 704:	60e2                	ld	ra,24(sp)
 706:	6442                	ld	s0,16(sp)
 708:	6161                	addi	sp,sp,80
 70a:	8082                	ret

000000000000070c <printf>:

void
printf(const char *fmt, ...)
{
 70c:	711d                	addi	sp,sp,-96
 70e:	ec06                	sd	ra,24(sp)
 710:	e822                	sd	s0,16(sp)
 712:	1000                	addi	s0,sp,32
 714:	e40c                	sd	a1,8(s0)
 716:	e810                	sd	a2,16(s0)
 718:	ec14                	sd	a3,24(s0)
 71a:	f018                	sd	a4,32(s0)
 71c:	f41c                	sd	a5,40(s0)
 71e:	03043823          	sd	a6,48(s0)
 722:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 726:	00840613          	addi	a2,s0,8
 72a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 72e:	85aa                	mv	a1,a0
 730:	4505                	li	a0,1
 732:	00000097          	auipc	ra,0x0
 736:	dce080e7          	jalr	-562(ra) # 500 <vprintf>
}
 73a:	60e2                	ld	ra,24(sp)
 73c:	6442                	ld	s0,16(sp)
 73e:	6125                	addi	sp,sp,96
 740:	8082                	ret

0000000000000742 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 742:	1141                	addi	sp,sp,-16
 744:	e422                	sd	s0,8(sp)
 746:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 748:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74c:	00001797          	auipc	a5,0x1
 750:	8b47b783          	ld	a5,-1868(a5) # 1000 <freep>
 754:	a805                	j	784 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 756:	4618                	lw	a4,8(a2)
 758:	9db9                	addw	a1,a1,a4
 75a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 75e:	6398                	ld	a4,0(a5)
 760:	6318                	ld	a4,0(a4)
 762:	fee53823          	sd	a4,-16(a0)
 766:	a091                	j	7aa <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 768:	ff852703          	lw	a4,-8(a0)
 76c:	9e39                	addw	a2,a2,a4
 76e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 770:	ff053703          	ld	a4,-16(a0)
 774:	e398                	sd	a4,0(a5)
 776:	a099                	j	7bc <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 778:	6398                	ld	a4,0(a5)
 77a:	00e7e463          	bltu	a5,a4,782 <free+0x40>
 77e:	00e6ea63          	bltu	a3,a4,792 <free+0x50>
{
 782:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 784:	fed7fae3          	bgeu	a5,a3,778 <free+0x36>
 788:	6398                	ld	a4,0(a5)
 78a:	00e6e463          	bltu	a3,a4,792 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 78e:	fee7eae3          	bltu	a5,a4,782 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 792:	ff852583          	lw	a1,-8(a0)
 796:	6390                	ld	a2,0(a5)
 798:	02059713          	slli	a4,a1,0x20
 79c:	9301                	srli	a4,a4,0x20
 79e:	0712                	slli	a4,a4,0x4
 7a0:	9736                	add	a4,a4,a3
 7a2:	fae60ae3          	beq	a2,a4,756 <free+0x14>
    bp->s.ptr = p->s.ptr;
 7a6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7aa:	4790                	lw	a2,8(a5)
 7ac:	02061713          	slli	a4,a2,0x20
 7b0:	9301                	srli	a4,a4,0x20
 7b2:	0712                	slli	a4,a4,0x4
 7b4:	973e                	add	a4,a4,a5
 7b6:	fae689e3          	beq	a3,a4,768 <free+0x26>
  } else
    p->s.ptr = bp;
 7ba:	e394                	sd	a3,0(a5)
  freep = p;
 7bc:	00001717          	auipc	a4,0x1
 7c0:	84f73223          	sd	a5,-1980(a4) # 1000 <freep>
}
 7c4:	6422                	ld	s0,8(sp)
 7c6:	0141                	addi	sp,sp,16
 7c8:	8082                	ret

00000000000007ca <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7ca:	7139                	addi	sp,sp,-64
 7cc:	fc06                	sd	ra,56(sp)
 7ce:	f822                	sd	s0,48(sp)
 7d0:	f426                	sd	s1,40(sp)
 7d2:	f04a                	sd	s2,32(sp)
 7d4:	ec4e                	sd	s3,24(sp)
 7d6:	e852                	sd	s4,16(sp)
 7d8:	e456                	sd	s5,8(sp)
 7da:	e05a                	sd	s6,0(sp)
 7dc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7de:	02051493          	slli	s1,a0,0x20
 7e2:	9081                	srli	s1,s1,0x20
 7e4:	04bd                	addi	s1,s1,15
 7e6:	8091                	srli	s1,s1,0x4
 7e8:	0014899b          	addiw	s3,s1,1
 7ec:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7ee:	00001517          	auipc	a0,0x1
 7f2:	81253503          	ld	a0,-2030(a0) # 1000 <freep>
 7f6:	c515                	beqz	a0,822 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7fa:	4798                	lw	a4,8(a5)
 7fc:	02977f63          	bgeu	a4,s1,83a <malloc+0x70>
 800:	8a4e                	mv	s4,s3
 802:	0009871b          	sext.w	a4,s3
 806:	6685                	lui	a3,0x1
 808:	00d77363          	bgeu	a4,a3,80e <malloc+0x44>
 80c:	6a05                	lui	s4,0x1
 80e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 812:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 816:	00000917          	auipc	s2,0x0
 81a:	7ea90913          	addi	s2,s2,2026 # 1000 <freep>
  if(p == (char*)-1)
 81e:	5afd                	li	s5,-1
 820:	a88d                	j	892 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 822:	00000797          	auipc	a5,0x0
 826:	7fe78793          	addi	a5,a5,2046 # 1020 <base>
 82a:	00000717          	auipc	a4,0x0
 82e:	7cf73b23          	sd	a5,2006(a4) # 1000 <freep>
 832:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 834:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 838:	b7e1                	j	800 <malloc+0x36>
      if(p->s.size == nunits)
 83a:	02e48b63          	beq	s1,a4,870 <malloc+0xa6>
        p->s.size -= nunits;
 83e:	4137073b          	subw	a4,a4,s3
 842:	c798                	sw	a4,8(a5)
        p += p->s.size;
 844:	1702                	slli	a4,a4,0x20
 846:	9301                	srli	a4,a4,0x20
 848:	0712                	slli	a4,a4,0x4
 84a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 84c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 850:	00000717          	auipc	a4,0x0
 854:	7aa73823          	sd	a0,1968(a4) # 1000 <freep>
      return (void*)(p + 1);
 858:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 85c:	70e2                	ld	ra,56(sp)
 85e:	7442                	ld	s0,48(sp)
 860:	74a2                	ld	s1,40(sp)
 862:	7902                	ld	s2,32(sp)
 864:	69e2                	ld	s3,24(sp)
 866:	6a42                	ld	s4,16(sp)
 868:	6aa2                	ld	s5,8(sp)
 86a:	6b02                	ld	s6,0(sp)
 86c:	6121                	addi	sp,sp,64
 86e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 870:	6398                	ld	a4,0(a5)
 872:	e118                	sd	a4,0(a0)
 874:	bff1                	j	850 <malloc+0x86>
  hp->s.size = nu;
 876:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 87a:	0541                	addi	a0,a0,16
 87c:	00000097          	auipc	ra,0x0
 880:	ec6080e7          	jalr	-314(ra) # 742 <free>
  return freep;
 884:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 888:	d971                	beqz	a0,85c <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 88a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 88c:	4798                	lw	a4,8(a5)
 88e:	fa9776e3          	bgeu	a4,s1,83a <malloc+0x70>
    if(p == freep)
 892:	00093703          	ld	a4,0(s2)
 896:	853e                	mv	a0,a5
 898:	fef719e3          	bne	a4,a5,88a <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 89c:	8552                	mv	a0,s4
 89e:	00000097          	auipc	ra,0x0
 8a2:	b7e080e7          	jalr	-1154(ra) # 41c <sbrk>
  if(p == (char*)-1)
 8a6:	fd5518e3          	bne	a0,s5,876 <malloc+0xac>
        return 0;
 8aa:	4501                	li	a0,0
 8ac:	bf45                	j	85c <malloc+0x92>

00000000000008ae <uswtch>:
 8ae:	00153023          	sd	ra,0(a0)
 8b2:	00253423          	sd	sp,8(a0)
 8b6:	e900                	sd	s0,16(a0)
 8b8:	ed04                	sd	s1,24(a0)
 8ba:	03253023          	sd	s2,32(a0)
 8be:	03353423          	sd	s3,40(a0)
 8c2:	03453823          	sd	s4,48(a0)
 8c6:	03553c23          	sd	s5,56(a0)
 8ca:	05653023          	sd	s6,64(a0)
 8ce:	05753423          	sd	s7,72(a0)
 8d2:	05853823          	sd	s8,80(a0)
 8d6:	05953c23          	sd	s9,88(a0)
 8da:	07a53023          	sd	s10,96(a0)
 8de:	07b53423          	sd	s11,104(a0)
 8e2:	0005b083          	ld	ra,0(a1)
 8e6:	0085b103          	ld	sp,8(a1)
 8ea:	6980                	ld	s0,16(a1)
 8ec:	6d84                	ld	s1,24(a1)
 8ee:	0205b903          	ld	s2,32(a1)
 8f2:	0285b983          	ld	s3,40(a1)
 8f6:	0305ba03          	ld	s4,48(a1)
 8fa:	0385ba83          	ld	s5,56(a1)
 8fe:	0405bb03          	ld	s6,64(a1)
 902:	0485bb83          	ld	s7,72(a1)
 906:	0505bc03          	ld	s8,80(a1)
 90a:	0585bc83          	ld	s9,88(a1)
 90e:	0605bd03          	ld	s10,96(a1)
 912:	0685bd83          	ld	s11,104(a1)
 916:	8082                	ret

0000000000000918 <uthread_create>:
struct uthread uthreads[MAX_UTHREADS];
struct uthread *currentThread;
int ids = 0;

int uthread_create(void (*start_func)(), enum sched_priority priority)
{
 918:	1141                	addi	sp,sp,-16
 91a:	e422                	sd	s0,8(sp)
 91c:	0800                	addi	s0,sp,16
    int i;
    ids ++;
 91e:	00000797          	auipc	a5,0x0
 922:	6ee78793          	addi	a5,a5,1774 # 100c <ids>
 926:	0007a303          	lw	t1,0(a5)
 92a:	2305                	addiw	t1,t1,1
 92c:	0067a023          	sw	t1,0(a5)

    for (i = 0; i < MAX_UTHREADS; i++)
 930:	00001717          	auipc	a4,0x1
 934:	6a070713          	addi	a4,a4,1696 # 1fd0 <uthreads+0xfa0>
 938:	4781                	li	a5,0
 93a:	6605                	lui	a2,0x1
 93c:	02060613          	addi	a2,a2,32 # 1020 <base>
 940:	4811                	li	a6,4
    {
        if (uthreads[i].state == FREE)
 942:	4314                	lw	a3,0(a4)
 944:	c699                	beqz	a3,952 <uthread_create+0x3a>
    for (i = 0; i < MAX_UTHREADS; i++)
 946:	2785                	addiw	a5,a5,1
 948:	9732                	add	a4,a4,a2
 94a:	ff079ce3          	bne	a5,a6,942 <uthread_create+0x2a>
            break;
    }     

    if (i == MAX_UTHREADS)
        return -1;
 94e:	557d                	li	a0,-1
 950:	a889                	j	9a2 <uthread_create+0x8a>
    if (i == MAX_UTHREADS)
 952:	4711                	li	a4,4
 954:	04e78a63          	beq	a5,a4,9a8 <uthread_create+0x90>

    uthreads[i].context.ra = (uint64)start_func;
 958:	00000897          	auipc	a7,0x0
 95c:	6d888893          	addi	a7,a7,1752 # 1030 <uthreads>
 960:	00779693          	slli	a3,a5,0x7
 964:	00f68633          	add	a2,a3,a5
 968:	0616                	slli	a2,a2,0x5
 96a:	9646                	add	a2,a2,a7
 96c:	6805                	lui	a6,0x1
 96e:	00c80e33          	add	t3,a6,a2
 972:	faae3423          	sd	a0,-88(t3)
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
    uthreads[i].context.sp += sizeof(uint64);
 976:	00f68733          	add	a4,a3,a5
 97a:	0716                	slli	a4,a4,0x5
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
 97c:	fa080513          	addi	a0,a6,-96 # fa0 <digits+0x2f8>
 980:	972a                	add	a4,a4,a0
 982:	9746                	add	a4,a4,a7
    uthreads[i].context.sp += sizeof(uint64);
 984:	0721                	addi	a4,a4,8
 986:	faee3823          	sd	a4,-80(t3)
    uthreads[i].state = RUNNABLE;
 98a:	4709                	li	a4,2
 98c:	faee2023          	sw	a4,-96(t3)
    uthreads[i].priority = priority;
 990:	00be2c23          	sw	a1,24(t3)
    currentThread = &uthreads[i];
 994:	00000717          	auipc	a4,0x0
 998:	66c73e23          	sd	a2,1660(a4) # 1010 <currentThread>

    currentThread->pid = ids;
 99c:	006e2e23          	sw	t1,28(t3)

    return 0;
 9a0:	4501                	li	a0,0
}
 9a2:	6422                	ld	s0,8(sp)
 9a4:	0141                	addi	sp,sp,16
 9a6:	8082                	ret
        return -1;
 9a8:	557d                	li	a0,-1
 9aa:	bfe5                	j	9a2 <uthread_create+0x8a>

00000000000009ac <get_state>:
  currentThread->state = RUNNABLE;
  schedule();
}


char* get_state(enum tstate s){
 9ac:	1141                	addi	sp,sp,-16
 9ae:	e422                	sd	s0,8(sp)
 9b0:	0800                	addi	s0,sp,16
  switch (s)
 9b2:	4705                	li	a4,1
 9b4:	02e50763          	beq	a0,a4,9e2 <get_state+0x36>
 9b8:	87aa                	mv	a5,a0
 9ba:	4709                	li	a4,2
  case FREE:
    return "FREE";
  case  RUNNING:
    return "RUNNING";
  case RUNNABLE:
    return "RUNNABLE";
 9bc:	00000517          	auipc	a0,0x0
 9c0:	30c50513          	addi	a0,a0,780 # cc8 <digits+0x20>
  switch (s)
 9c4:	00e78763          	beq	a5,a4,9d2 <get_state+0x26>
  }

  return "ERROR";
 9c8:	00000517          	auipc	a0,0x0
 9cc:	2f850513          	addi	a0,a0,760 # cc0 <digits+0x18>
  switch (s)
 9d0:	c781                	beqz	a5,9d8 <get_state+0x2c>
}
 9d2:	6422                	ld	s0,8(sp)
 9d4:	0141                	addi	sp,sp,16
 9d6:	8082                	ret
    return "FREE";
 9d8:	00000517          	auipc	a0,0x0
 9dc:	30850513          	addi	a0,a0,776 # ce0 <digits+0x38>
 9e0:	bfcd                	j	9d2 <get_state+0x26>
  switch (s)
 9e2:	00000517          	auipc	a0,0x0
 9e6:	2f650513          	addi	a0,a0,758 # cd8 <digits+0x30>
 9ea:	b7e5                	j	9d2 <get_state+0x26>

00000000000009ec <find_next>:
  uswtch(&cur->context, &next->context);
  
}


struct uthread *find_next(enum sched_priority priority){
 9ec:	1141                	addi	sp,sp,-16
 9ee:	e422                	sd	s0,8(sp)
 9f0:	0800                	addi	s0,sp,16
  
  struct uthread* next = 0;
  int i;
  int j;
  j = (currentThread - uthreads + 1) % MAX_UTHREADS;
 9f2:	00000717          	auipc	a4,0x0
 9f6:	61e73703          	ld	a4,1566(a4) # 1010 <currentThread>
 9fa:	00000797          	auipc	a5,0x0
 9fe:	63678793          	addi	a5,a5,1590 # 1030 <uthreads>
 a02:	8f1d                	sub	a4,a4,a5
 a04:	8715                	srai	a4,a4,0x5
 a06:	00000797          	auipc	a5,0x0
 a0a:	24a7b783          	ld	a5,586(a5) # c50 <uthread_self+0x14>
 a0e:	02f70733          	mul	a4,a4,a5
 a12:	0705                	addi	a4,a4,1
 a14:	43f75793          	srai	a5,a4,0x3f
 a18:	03e7d693          	srli	a3,a5,0x3e
 a1c:	00d707b3          	add	a5,a4,a3
 a20:	8b8d                	andi	a5,a5,3
 a22:	8f95                	sub	a5,a5,a3
 a24:	4691                	li	a3,4

  for(i = 0; i < MAX_UTHREADS; i++){
    if((uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING) && uthreads[j].priority == priority){
 a26:	00000597          	auipc	a1,0x0
 a2a:	60a58593          	addi	a1,a1,1546 # 1030 <uthreads>
 a2e:	6605                	lui	a2,0x1
 a30:	4805                	li	a6,1
 a32:	a819                	j	a48 <find_next+0x5c>
      next = &uthreads[j];
      break;
    }
    j = (j+1) % MAX_UTHREADS;    
 a34:	2785                	addiw	a5,a5,1
 a36:	41f7d71b          	sraiw	a4,a5,0x1f
 a3a:	01e7571b          	srliw	a4,a4,0x1e
 a3e:	9fb9                	addw	a5,a5,a4
 a40:	8b8d                	andi	a5,a5,3
 a42:	9f99                	subw	a5,a5,a4
  for(i = 0; i < MAX_UTHREADS; i++){
 a44:	36fd                	addiw	a3,a3,-1
 a46:	ce9d                	beqz	a3,a84 <find_next+0x98>
    if((uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING) && uthreads[j].priority == priority){
 a48:	00779713          	slli	a4,a5,0x7
 a4c:	973e                	add	a4,a4,a5
 a4e:	0716                	slli	a4,a4,0x5
 a50:	972e                	add	a4,a4,a1
 a52:	9732                	add	a4,a4,a2
 a54:	fa072703          	lw	a4,-96(a4)
 a58:	377d                	addiw	a4,a4,-1
 a5a:	fce86de3          	bltu	a6,a4,a34 <find_next+0x48>
 a5e:	00779713          	slli	a4,a5,0x7
 a62:	973e                	add	a4,a4,a5
 a64:	0716                	slli	a4,a4,0x5
 a66:	972e                	add	a4,a4,a1
 a68:	9732                	add	a4,a4,a2
 a6a:	4f18                	lw	a4,24(a4)
 a6c:	fca714e3          	bne	a4,a0,a34 <find_next+0x48>
      next = &uthreads[j];
 a70:	00779513          	slli	a0,a5,0x7
 a74:	953e                	add	a0,a0,a5
 a76:	0516                	slli	a0,a0,0x5
 a78:	00000797          	auipc	a5,0x0
 a7c:	5b878793          	addi	a5,a5,1464 # 1030 <uthreads>
 a80:	953e                	add	a0,a0,a5
      break;
 a82:	a011                	j	a86 <find_next+0x9a>
  struct uthread* next = 0;
 a84:	4501                	li	a0,0
  }

  return next;
}
 a86:	6422                	ld	s0,8(sp)
 a88:	0141                	addi	sp,sp,16
 a8a:	8082                	ret

0000000000000a8c <schedule>:
void schedule(){
 a8c:	1101                	addi	sp,sp,-32
 a8e:	ec06                	sd	ra,24(sp)
 a90:	e822                	sd	s0,16(sp)
 a92:	e426                	sd	s1,8(sp)
 a94:	1000                	addi	s0,sp,32
  cur = currentThread;
 a96:	00000497          	auipc	s1,0x0
 a9a:	57a4b483          	ld	s1,1402(s1) # 1010 <currentThread>
  next = find_next(HIGH);
 a9e:	4509                	li	a0,2
 aa0:	00000097          	auipc	ra,0x0
 aa4:	f4c080e7          	jalr	-180(ra) # 9ec <find_next>
  if(next == 0)
 aa8:	c915                	beqz	a0,adc <schedule+0x50>
  currentThread = next;
 aaa:	00000797          	auipc	a5,0x0
 aae:	56a7b323          	sd	a0,1382(a5) # 1010 <currentThread>
  currentThread->state = RUNNING;
 ab2:	6785                	lui	a5,0x1
 ab4:	00f50733          	add	a4,a0,a5
 ab8:	4685                	li	a3,1
 aba:	fad72023          	sw	a3,-96(a4)
  uswtch(&cur->context, &next->context);
 abe:	fa878793          	addi	a5,a5,-88 # fa8 <digits+0x300>
 ac2:	00f505b3          	add	a1,a0,a5
 ac6:	00f48533          	add	a0,s1,a5
 aca:	00000097          	auipc	ra,0x0
 ace:	de4080e7          	jalr	-540(ra) # 8ae <uswtch>
}
 ad2:	60e2                	ld	ra,24(sp)
 ad4:	6442                	ld	s0,16(sp)
 ad6:	64a2                	ld	s1,8(sp)
 ad8:	6105                	addi	sp,sp,32
 ada:	8082                	ret
    next = find_next(MEDIUM);
 adc:	4505                	li	a0,1
 ade:	00000097          	auipc	ra,0x0
 ae2:	f0e080e7          	jalr	-242(ra) # 9ec <find_next>
  if(next == 0)
 ae6:	f171                	bnez	a0,aaa <schedule+0x1e>
    next = find_next(LOW);
 ae8:	00000097          	auipc	ra,0x0
 aec:	f04080e7          	jalr	-252(ra) # 9ec <find_next>
  if(next == 0)
 af0:	fd4d                	bnez	a0,aaa <schedule+0x1e>
    exit(-1);
 af2:	557d                	li	a0,-1
 af4:	00000097          	auipc	ra,0x0
 af8:	8a0080e7          	jalr	-1888(ra) # 394 <exit>

0000000000000afc <uthread_yield>:
{
 afc:	1141                	addi	sp,sp,-16
 afe:	e406                	sd	ra,8(sp)
 b00:	e022                	sd	s0,0(sp)
 b02:	0800                	addi	s0,sp,16
  currentThread->state = RUNNABLE;
 b04:	00000797          	auipc	a5,0x0
 b08:	50c7b783          	ld	a5,1292(a5) # 1010 <currentThread>
 b0c:	6705                	lui	a4,0x1
 b0e:	97ba                	add	a5,a5,a4
 b10:	4709                	li	a4,2
 b12:	fae7a023          	sw	a4,-96(a5)
  schedule();
 b16:	00000097          	auipc	ra,0x0
 b1a:	f76080e7          	jalr	-138(ra) # a8c <schedule>
}
 b1e:	60a2                	ld	ra,8(sp)
 b20:	6402                	ld	s0,0(sp)
 b22:	0141                	addi	sp,sp,16
 b24:	8082                	ret

0000000000000b26 <uthread_exit>:

void uthread_exit()
{
 b26:	1141                	addi	sp,sp,-16
 b28:	e406                	sd	ra,8(sp)
 b2a:	e022                	sd	s0,0(sp)
 b2c:	0800                	addi	s0,sp,16
  currentThread->state = FREE;
 b2e:	00000797          	auipc	a5,0x0
 b32:	4e27b783          	ld	a5,1250(a5) # 1010 <currentThread>
 b36:	6705                	lui	a4,0x1
 b38:	97ba                	add	a5,a5,a4
 b3a:	fa07a023          	sw	zero,-96(a5)
  int remainingThreads = 0;
  for (int i = 0; i < MAX_UTHREADS; i++) {
 b3e:	00001797          	auipc	a5,0x1
 b42:	49278793          	addi	a5,a5,1170 # 1fd0 <uthreads+0xfa0>
 b46:	00005597          	auipc	a1,0x5
 b4a:	50a58593          	addi	a1,a1,1290 # 6050 <uthreads+0x5020>
  int remainingThreads = 0;
 b4e:	4501                	li	a0,0
    if (uthreads[i].state == RUNNABLE) 
 b50:	4609                	li	a2,2
  for (int i = 0; i < MAX_UTHREADS; i++) {
 b52:	6685                	lui	a3,0x1
 b54:	02068693          	addi	a3,a3,32 # 1020 <base>
 b58:	a021                	j	b60 <uthread_exit+0x3a>
 b5a:	97b6                	add	a5,a5,a3
 b5c:	00b78763          	beq	a5,a1,b6a <uthread_exit+0x44>
    if (uthreads[i].state == RUNNABLE) 
 b60:	4398                	lw	a4,0(a5)
 b62:	fec71ce3          	bne	a4,a2,b5a <uthread_exit+0x34>
      remainingThreads++;
 b66:	2505                	addiw	a0,a0,1
 b68:	bfcd                	j	b5a <uthread_exit+0x34>
  }

  if (remainingThreads == 0){
 b6a:	c909                	beqz	a0,b7c <uthread_exit+0x56>
    exit(0);
  }
  else 
  {
    schedule();
 b6c:	00000097          	auipc	ra,0x0
 b70:	f20080e7          	jalr	-224(ra) # a8c <schedule>
  }
}
 b74:	60a2                	ld	ra,8(sp)
 b76:	6402                	ld	s0,0(sp)
 b78:	0141                	addi	sp,sp,16
 b7a:	8082                	ret
    exit(0);
 b7c:	00000097          	auipc	ra,0x0
 b80:	818080e7          	jalr	-2024(ra) # 394 <exit>

0000000000000b84 <uthread_set_priority>:

enum sched_priority uthread_set_priority(enum sched_priority priority)
{
 b84:	1141                	addi	sp,sp,-16
 b86:	e422                	sd	s0,8(sp)
 b88:	0800                	addi	s0,sp,16
  enum sched_priority prevPriority = currentThread->priority;
 b8a:	00000797          	auipc	a5,0x0
 b8e:	4867b783          	ld	a5,1158(a5) # 1010 <currentThread>
 b92:	6705                	lui	a4,0x1
 b94:	97ba                	add	a5,a5,a4
 b96:	4f98                	lw	a4,24(a5)
  currentThread->priority = priority;
 b98:	cf88                	sw	a0,24(a5)
  return prevPriority;
}
 b9a:	853a                	mv	a0,a4
 b9c:	6422                	ld	s0,8(sp)
 b9e:	0141                	addi	sp,sp,16
 ba0:	8082                	ret

0000000000000ba2 <uthread_get_priority>:

enum sched_priority uthread_get_priority()
{
 ba2:	1141                	addi	sp,sp,-16
 ba4:	e422                	sd	s0,8(sp)
 ba6:	0800                	addi	s0,sp,16
    return currentThread->priority;
 ba8:	00000797          	auipc	a5,0x0
 bac:	4687b783          	ld	a5,1128(a5) # 1010 <currentThread>
 bb0:	6705                	lui	a4,0x1
 bb2:	97ba                	add	a5,a5,a4
}
 bb4:	4f88                	lw	a0,24(a5)
 bb6:	6422                	ld	s0,8(sp)
 bb8:	0141                	addi	sp,sp,16
 bba:	8082                	ret

0000000000000bbc <uthread_start_all>:

int uthreadStarted = 0;

int uthread_start_all() {
 bbc:	7175                	addi	sp,sp,-144
 bbe:	e506                	sd	ra,136(sp)
 bc0:	e122                	sd	s0,128(sp)
 bc2:	fca6                	sd	s1,120(sp)
 bc4:	0900                	addi	s0,sp,144
  if (uthreadStarted) {
 bc6:	00000497          	auipc	s1,0x0
 bca:	4424a483          	lw	s1,1090(s1) # 1008 <uthreadStarted>
 bce:	e4ad                	bnez	s1,c38 <uthread_start_all+0x7c>
    return -1;
  }
  uthreadStarted = 1;
 bd0:	4785                	li	a5,1
 bd2:	00000717          	auipc	a4,0x0
 bd6:	42f72b23          	sw	a5,1078(a4) # 1008 <uthreadStarted>

  struct context dummyContext;
  struct uthread *next; 

  next = find_next(HIGH);
 bda:	4509                	li	a0,2
 bdc:	00000097          	auipc	ra,0x0
 be0:	e10080e7          	jalr	-496(ra) # 9ec <find_next>
  if(next == 0)
 be4:	c915                	beqz	a0,c18 <uthread_start_all+0x5c>
  if(next == 0)
    next = find_next(LOW);
  if(next == 0)
    exit(-1);

  currentThread = next;
 be6:	00000797          	auipc	a5,0x0
 bea:	42a7b523          	sd	a0,1066(a5) # 1010 <currentThread>
  currentThread->state = RUNNING;
 bee:	6585                	lui	a1,0x1
 bf0:	00b507b3          	add	a5,a0,a1
 bf4:	4705                	li	a4,1
 bf6:	fae7a023          	sw	a4,-96(a5)

  uswtch(&dummyContext, &currentThread->context);
 bfa:	fa858593          	addi	a1,a1,-88 # fa8 <digits+0x300>
 bfe:	95aa                	add	a1,a1,a0
 c00:	f7040513          	addi	a0,s0,-144
 c04:	00000097          	auipc	ra,0x0
 c08:	caa080e7          	jalr	-854(ra) # 8ae <uswtch>

  return 0;
}
 c0c:	8526                	mv	a0,s1
 c0e:	60aa                	ld	ra,136(sp)
 c10:	640a                	ld	s0,128(sp)
 c12:	74e6                	ld	s1,120(sp)
 c14:	6149                	addi	sp,sp,144
 c16:	8082                	ret
    next = find_next(MEDIUM);
 c18:	4505                	li	a0,1
 c1a:	00000097          	auipc	ra,0x0
 c1e:	dd2080e7          	jalr	-558(ra) # 9ec <find_next>
  if(next == 0)
 c22:	f171                	bnez	a0,be6 <uthread_start_all+0x2a>
    next = find_next(LOW);
 c24:	00000097          	auipc	ra,0x0
 c28:	dc8080e7          	jalr	-568(ra) # 9ec <find_next>
  if(next == 0)
 c2c:	fd4d                	bnez	a0,be6 <uthread_start_all+0x2a>
    exit(-1);
 c2e:	557d                	li	a0,-1
 c30:	fffff097          	auipc	ra,0xfffff
 c34:	764080e7          	jalr	1892(ra) # 394 <exit>
    return -1;
 c38:	54fd                	li	s1,-1
 c3a:	bfc9                	j	c0c <uthread_start_all+0x50>

0000000000000c3c <uthread_self>:


struct uthread *uthread_self()
{
 c3c:	1141                	addi	sp,sp,-16
 c3e:	e422                	sd	s0,8(sp)
 c40:	0800                	addi	s0,sp,16
    return currentThread;
 c42:	00000517          	auipc	a0,0x0
 c46:	3ce53503          	ld	a0,974(a0) # 1010 <currentThread>
 c4a:	6422                	ld	s0,8(sp)
 c4c:	0141                	addi	sp,sp,16
 c4e:	8082                	ret
