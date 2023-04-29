
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  10:	00001917          	auipc	s2,0x1
  14:	01090913          	addi	s2,s2,16 # 1020 <buf>
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	39e080e7          	jalr	926(ra) # 3be <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05963          	blez	a0,5c <cat+0x5c>
    if (write(1, buf, n) != n) {
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	392080e7          	jalr	914(ra) # 3c6 <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
      fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	c4058593          	addi	a1,a1,-960 # c80 <uthread_self+0x32>
  48:	4509                	li	a0,2
  4a:	00000097          	auipc	ra,0x0
  4e:	6a6080e7          	jalr	1702(ra) # 6f0 <fprintf>
      exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	352080e7          	jalr	850(ra) # 3a6 <exit>
    }
  }
  if(n < 0){
  5c:	00054963          	bltz	a0,6e <cat+0x6e>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  60:	70a2                	ld	ra,40(sp)
  62:	7402                	ld	s0,32(sp)
  64:	64e2                	ld	s1,24(sp)
  66:	6942                	ld	s2,16(sp)
  68:	69a2                	ld	s3,8(sp)
  6a:	6145                	addi	sp,sp,48
  6c:	8082                	ret
    fprintf(2, "cat: read error\n");
  6e:	00001597          	auipc	a1,0x1
  72:	c2a58593          	addi	a1,a1,-982 # c98 <uthread_self+0x4a>
  76:	4509                	li	a0,2
  78:	00000097          	auipc	ra,0x0
  7c:	678080e7          	jalr	1656(ra) # 6f0 <fprintf>
    exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	324080e7          	jalr	804(ra) # 3a6 <exit>

000000000000008a <main>:

int
main(int argc, char *argv[])
{
  8a:	7179                	addi	sp,sp,-48
  8c:	f406                	sd	ra,40(sp)
  8e:	f022                	sd	s0,32(sp)
  90:	ec26                	sd	s1,24(sp)
  92:	e84a                	sd	s2,16(sp)
  94:	e44e                	sd	s3,8(sp)
  96:	e052                	sd	s4,0(sp)
  98:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  9a:	4785                	li	a5,1
  9c:	04a7d763          	bge	a5,a0,ea <main+0x60>
  a0:	00858913          	addi	s2,a1,8
  a4:	ffe5099b          	addiw	s3,a0,-2
  a8:	1982                	slli	s3,s3,0x20
  aa:	0209d993          	srli	s3,s3,0x20
  ae:	098e                	slli	s3,s3,0x3
  b0:	05c1                	addi	a1,a1,16
  b2:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  b4:	4581                	li	a1,0
  b6:	00093503          	ld	a0,0(s2)
  ba:	00000097          	auipc	ra,0x0
  be:	32c080e7          	jalr	812(ra) # 3e6 <open>
  c2:	84aa                	mv	s1,a0
  c4:	02054d63          	bltz	a0,fe <main+0x74>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  c8:	00000097          	auipc	ra,0x0
  cc:	f38080e7          	jalr	-200(ra) # 0 <cat>
    close(fd);
  d0:	8526                	mv	a0,s1
  d2:	00000097          	auipc	ra,0x0
  d6:	2fc080e7          	jalr	764(ra) # 3ce <close>
  for(i = 1; i < argc; i++){
  da:	0921                	addi	s2,s2,8
  dc:	fd391ce3          	bne	s2,s3,b4 <main+0x2a>
  }
  exit(0);
  e0:	4501                	li	a0,0
  e2:	00000097          	auipc	ra,0x0
  e6:	2c4080e7          	jalr	708(ra) # 3a6 <exit>
    cat(0);
  ea:	4501                	li	a0,0
  ec:	00000097          	auipc	ra,0x0
  f0:	f14080e7          	jalr	-236(ra) # 0 <cat>
    exit(0);
  f4:	4501                	li	a0,0
  f6:	00000097          	auipc	ra,0x0
  fa:	2b0080e7          	jalr	688(ra) # 3a6 <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  fe:	00093603          	ld	a2,0(s2)
 102:	00001597          	auipc	a1,0x1
 106:	bae58593          	addi	a1,a1,-1106 # cb0 <uthread_self+0x62>
 10a:	4509                	li	a0,2
 10c:	00000097          	auipc	ra,0x0
 110:	5e4080e7          	jalr	1508(ra) # 6f0 <fprintf>
      exit(1);
 114:	4505                	li	a0,1
 116:	00000097          	auipc	ra,0x0
 11a:	290080e7          	jalr	656(ra) # 3a6 <exit>

000000000000011e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 11e:	1141                	addi	sp,sp,-16
 120:	e406                	sd	ra,8(sp)
 122:	e022                	sd	s0,0(sp)
 124:	0800                	addi	s0,sp,16
  extern int main();
  main();
 126:	00000097          	auipc	ra,0x0
 12a:	f64080e7          	jalr	-156(ra) # 8a <main>
  exit(0);
 12e:	4501                	li	a0,0
 130:	00000097          	auipc	ra,0x0
 134:	276080e7          	jalr	630(ra) # 3a6 <exit>

0000000000000138 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 138:	1141                	addi	sp,sp,-16
 13a:	e422                	sd	s0,8(sp)
 13c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 13e:	87aa                	mv	a5,a0
 140:	0585                	addi	a1,a1,1
 142:	0785                	addi	a5,a5,1
 144:	fff5c703          	lbu	a4,-1(a1)
 148:	fee78fa3          	sb	a4,-1(a5)
 14c:	fb75                	bnez	a4,140 <strcpy+0x8>
    ;
  return os;
}
 14e:	6422                	ld	s0,8(sp)
 150:	0141                	addi	sp,sp,16
 152:	8082                	ret

0000000000000154 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 154:	1141                	addi	sp,sp,-16
 156:	e422                	sd	s0,8(sp)
 158:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 15a:	00054783          	lbu	a5,0(a0)
 15e:	cb91                	beqz	a5,172 <strcmp+0x1e>
 160:	0005c703          	lbu	a4,0(a1)
 164:	00f71763          	bne	a4,a5,172 <strcmp+0x1e>
    p++, q++;
 168:	0505                	addi	a0,a0,1
 16a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 16c:	00054783          	lbu	a5,0(a0)
 170:	fbe5                	bnez	a5,160 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 172:	0005c503          	lbu	a0,0(a1)
}
 176:	40a7853b          	subw	a0,a5,a0
 17a:	6422                	ld	s0,8(sp)
 17c:	0141                	addi	sp,sp,16
 17e:	8082                	ret

0000000000000180 <strlen>:

uint
strlen(const char *s)
{
 180:	1141                	addi	sp,sp,-16
 182:	e422                	sd	s0,8(sp)
 184:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 186:	00054783          	lbu	a5,0(a0)
 18a:	cf91                	beqz	a5,1a6 <strlen+0x26>
 18c:	0505                	addi	a0,a0,1
 18e:	87aa                	mv	a5,a0
 190:	4685                	li	a3,1
 192:	9e89                	subw	a3,a3,a0
 194:	00f6853b          	addw	a0,a3,a5
 198:	0785                	addi	a5,a5,1
 19a:	fff7c703          	lbu	a4,-1(a5)
 19e:	fb7d                	bnez	a4,194 <strlen+0x14>
    ;
  return n;
}
 1a0:	6422                	ld	s0,8(sp)
 1a2:	0141                	addi	sp,sp,16
 1a4:	8082                	ret
  for(n = 0; s[n]; n++)
 1a6:	4501                	li	a0,0
 1a8:	bfe5                	j	1a0 <strlen+0x20>

00000000000001aa <memset>:

void*
memset(void *dst, int c, uint n)
{
 1aa:	1141                	addi	sp,sp,-16
 1ac:	e422                	sd	s0,8(sp)
 1ae:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1b0:	ca19                	beqz	a2,1c6 <memset+0x1c>
 1b2:	87aa                	mv	a5,a0
 1b4:	1602                	slli	a2,a2,0x20
 1b6:	9201                	srli	a2,a2,0x20
 1b8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1bc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1c0:	0785                	addi	a5,a5,1
 1c2:	fee79de3          	bne	a5,a4,1bc <memset+0x12>
  }
  return dst;
}
 1c6:	6422                	ld	s0,8(sp)
 1c8:	0141                	addi	sp,sp,16
 1ca:	8082                	ret

00000000000001cc <strchr>:

char*
strchr(const char *s, char c)
{
 1cc:	1141                	addi	sp,sp,-16
 1ce:	e422                	sd	s0,8(sp)
 1d0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1d2:	00054783          	lbu	a5,0(a0)
 1d6:	cb99                	beqz	a5,1ec <strchr+0x20>
    if(*s == c)
 1d8:	00f58763          	beq	a1,a5,1e6 <strchr+0x1a>
  for(; *s; s++)
 1dc:	0505                	addi	a0,a0,1
 1de:	00054783          	lbu	a5,0(a0)
 1e2:	fbfd                	bnez	a5,1d8 <strchr+0xc>
      return (char*)s;
  return 0;
 1e4:	4501                	li	a0,0
}
 1e6:	6422                	ld	s0,8(sp)
 1e8:	0141                	addi	sp,sp,16
 1ea:	8082                	ret
  return 0;
 1ec:	4501                	li	a0,0
 1ee:	bfe5                	j	1e6 <strchr+0x1a>

00000000000001f0 <gets>:

char*
gets(char *buf, int max)
{
 1f0:	711d                	addi	sp,sp,-96
 1f2:	ec86                	sd	ra,88(sp)
 1f4:	e8a2                	sd	s0,80(sp)
 1f6:	e4a6                	sd	s1,72(sp)
 1f8:	e0ca                	sd	s2,64(sp)
 1fa:	fc4e                	sd	s3,56(sp)
 1fc:	f852                	sd	s4,48(sp)
 1fe:	f456                	sd	s5,40(sp)
 200:	f05a                	sd	s6,32(sp)
 202:	ec5e                	sd	s7,24(sp)
 204:	1080                	addi	s0,sp,96
 206:	8baa                	mv	s7,a0
 208:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 20a:	892a                	mv	s2,a0
 20c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 20e:	4aa9                	li	s5,10
 210:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 212:	89a6                	mv	s3,s1
 214:	2485                	addiw	s1,s1,1
 216:	0344d863          	bge	s1,s4,246 <gets+0x56>
    cc = read(0, &c, 1);
 21a:	4605                	li	a2,1
 21c:	faf40593          	addi	a1,s0,-81
 220:	4501                	li	a0,0
 222:	00000097          	auipc	ra,0x0
 226:	19c080e7          	jalr	412(ra) # 3be <read>
    if(cc < 1)
 22a:	00a05e63          	blez	a0,246 <gets+0x56>
    buf[i++] = c;
 22e:	faf44783          	lbu	a5,-81(s0)
 232:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 236:	01578763          	beq	a5,s5,244 <gets+0x54>
 23a:	0905                	addi	s2,s2,1
 23c:	fd679be3          	bne	a5,s6,212 <gets+0x22>
  for(i=0; i+1 < max; ){
 240:	89a6                	mv	s3,s1
 242:	a011                	j	246 <gets+0x56>
 244:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 246:	99de                	add	s3,s3,s7
 248:	00098023          	sb	zero,0(s3)
  return buf;
}
 24c:	855e                	mv	a0,s7
 24e:	60e6                	ld	ra,88(sp)
 250:	6446                	ld	s0,80(sp)
 252:	64a6                	ld	s1,72(sp)
 254:	6906                	ld	s2,64(sp)
 256:	79e2                	ld	s3,56(sp)
 258:	7a42                	ld	s4,48(sp)
 25a:	7aa2                	ld	s5,40(sp)
 25c:	7b02                	ld	s6,32(sp)
 25e:	6be2                	ld	s7,24(sp)
 260:	6125                	addi	sp,sp,96
 262:	8082                	ret

0000000000000264 <stat>:

int
stat(const char *n, struct stat *st)
{
 264:	1101                	addi	sp,sp,-32
 266:	ec06                	sd	ra,24(sp)
 268:	e822                	sd	s0,16(sp)
 26a:	e426                	sd	s1,8(sp)
 26c:	e04a                	sd	s2,0(sp)
 26e:	1000                	addi	s0,sp,32
 270:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 272:	4581                	li	a1,0
 274:	00000097          	auipc	ra,0x0
 278:	172080e7          	jalr	370(ra) # 3e6 <open>
  if(fd < 0)
 27c:	02054563          	bltz	a0,2a6 <stat+0x42>
 280:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 282:	85ca                	mv	a1,s2
 284:	00000097          	auipc	ra,0x0
 288:	17a080e7          	jalr	378(ra) # 3fe <fstat>
 28c:	892a                	mv	s2,a0
  close(fd);
 28e:	8526                	mv	a0,s1
 290:	00000097          	auipc	ra,0x0
 294:	13e080e7          	jalr	318(ra) # 3ce <close>
  return r;
}
 298:	854a                	mv	a0,s2
 29a:	60e2                	ld	ra,24(sp)
 29c:	6442                	ld	s0,16(sp)
 29e:	64a2                	ld	s1,8(sp)
 2a0:	6902                	ld	s2,0(sp)
 2a2:	6105                	addi	sp,sp,32
 2a4:	8082                	ret
    return -1;
 2a6:	597d                	li	s2,-1
 2a8:	bfc5                	j	298 <stat+0x34>

00000000000002aa <atoi>:

int
atoi(const char *s)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e422                	sd	s0,8(sp)
 2ae:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2b0:	00054603          	lbu	a2,0(a0)
 2b4:	fd06079b          	addiw	a5,a2,-48
 2b8:	0ff7f793          	andi	a5,a5,255
 2bc:	4725                	li	a4,9
 2be:	02f76963          	bltu	a4,a5,2f0 <atoi+0x46>
 2c2:	86aa                	mv	a3,a0
  n = 0;
 2c4:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2c6:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2c8:	0685                	addi	a3,a3,1
 2ca:	0025179b          	slliw	a5,a0,0x2
 2ce:	9fa9                	addw	a5,a5,a0
 2d0:	0017979b          	slliw	a5,a5,0x1
 2d4:	9fb1                	addw	a5,a5,a2
 2d6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2da:	0006c603          	lbu	a2,0(a3)
 2de:	fd06071b          	addiw	a4,a2,-48
 2e2:	0ff77713          	andi	a4,a4,255
 2e6:	fee5f1e3          	bgeu	a1,a4,2c8 <atoi+0x1e>
  return n;
}
 2ea:	6422                	ld	s0,8(sp)
 2ec:	0141                	addi	sp,sp,16
 2ee:	8082                	ret
  n = 0;
 2f0:	4501                	li	a0,0
 2f2:	bfe5                	j	2ea <atoi+0x40>

00000000000002f4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2f4:	1141                	addi	sp,sp,-16
 2f6:	e422                	sd	s0,8(sp)
 2f8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2fa:	02b57463          	bgeu	a0,a1,322 <memmove+0x2e>
    while(n-- > 0)
 2fe:	00c05f63          	blez	a2,31c <memmove+0x28>
 302:	1602                	slli	a2,a2,0x20
 304:	9201                	srli	a2,a2,0x20
 306:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 30a:	872a                	mv	a4,a0
      *dst++ = *src++;
 30c:	0585                	addi	a1,a1,1
 30e:	0705                	addi	a4,a4,1
 310:	fff5c683          	lbu	a3,-1(a1)
 314:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 318:	fee79ae3          	bne	a5,a4,30c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 31c:	6422                	ld	s0,8(sp)
 31e:	0141                	addi	sp,sp,16
 320:	8082                	ret
    dst += n;
 322:	00c50733          	add	a4,a0,a2
    src += n;
 326:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 328:	fec05ae3          	blez	a2,31c <memmove+0x28>
 32c:	fff6079b          	addiw	a5,a2,-1
 330:	1782                	slli	a5,a5,0x20
 332:	9381                	srli	a5,a5,0x20
 334:	fff7c793          	not	a5,a5
 338:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 33a:	15fd                	addi	a1,a1,-1
 33c:	177d                	addi	a4,a4,-1
 33e:	0005c683          	lbu	a3,0(a1)
 342:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 346:	fee79ae3          	bne	a5,a4,33a <memmove+0x46>
 34a:	bfc9                	j	31c <memmove+0x28>

000000000000034c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 34c:	1141                	addi	sp,sp,-16
 34e:	e422                	sd	s0,8(sp)
 350:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 352:	ca05                	beqz	a2,382 <memcmp+0x36>
 354:	fff6069b          	addiw	a3,a2,-1
 358:	1682                	slli	a3,a3,0x20
 35a:	9281                	srli	a3,a3,0x20
 35c:	0685                	addi	a3,a3,1
 35e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 360:	00054783          	lbu	a5,0(a0)
 364:	0005c703          	lbu	a4,0(a1)
 368:	00e79863          	bne	a5,a4,378 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 36c:	0505                	addi	a0,a0,1
    p2++;
 36e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 370:	fed518e3          	bne	a0,a3,360 <memcmp+0x14>
  }
  return 0;
 374:	4501                	li	a0,0
 376:	a019                	j	37c <memcmp+0x30>
      return *p1 - *p2;
 378:	40e7853b          	subw	a0,a5,a4
}
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret
  return 0;
 382:	4501                	li	a0,0
 384:	bfe5                	j	37c <memcmp+0x30>

0000000000000386 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 386:	1141                	addi	sp,sp,-16
 388:	e406                	sd	ra,8(sp)
 38a:	e022                	sd	s0,0(sp)
 38c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 38e:	00000097          	auipc	ra,0x0
 392:	f66080e7          	jalr	-154(ra) # 2f4 <memmove>
}
 396:	60a2                	ld	ra,8(sp)
 398:	6402                	ld	s0,0(sp)
 39a:	0141                	addi	sp,sp,16
 39c:	8082                	ret

000000000000039e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 39e:	4885                	li	a7,1
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3a6:	4889                	li	a7,2
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <wait>:
.global wait
wait:
 li a7, SYS_wait
 3ae:	488d                	li	a7,3
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3b6:	4891                	li	a7,4
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <read>:
.global read
read:
 li a7, SYS_read
 3be:	4895                	li	a7,5
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <write>:
.global write
write:
 li a7, SYS_write
 3c6:	48c1                	li	a7,16
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <close>:
.global close
close:
 li a7, SYS_close
 3ce:	48d5                	li	a7,21
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3d6:	4899                	li	a7,6
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <exec>:
.global exec
exec:
 li a7, SYS_exec
 3de:	489d                	li	a7,7
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <open>:
.global open
open:
 li a7, SYS_open
 3e6:	48bd                	li	a7,15
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3ee:	48c5                	li	a7,17
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3f6:	48c9                	li	a7,18
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3fe:	48a1                	li	a7,8
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <link>:
.global link
link:
 li a7, SYS_link
 406:	48cd                	li	a7,19
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 40e:	48d1                	li	a7,20
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 416:	48a5                	li	a7,9
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <dup>:
.global dup
dup:
 li a7, SYS_dup
 41e:	48a9                	li	a7,10
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 426:	48ad                	li	a7,11
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 42e:	48b1                	li	a7,12
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 436:	48b5                	li	a7,13
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 43e:	48b9                	li	a7,14
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 446:	1101                	addi	sp,sp,-32
 448:	ec06                	sd	ra,24(sp)
 44a:	e822                	sd	s0,16(sp)
 44c:	1000                	addi	s0,sp,32
 44e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 452:	4605                	li	a2,1
 454:	fef40593          	addi	a1,s0,-17
 458:	00000097          	auipc	ra,0x0
 45c:	f6e080e7          	jalr	-146(ra) # 3c6 <write>
}
 460:	60e2                	ld	ra,24(sp)
 462:	6442                	ld	s0,16(sp)
 464:	6105                	addi	sp,sp,32
 466:	8082                	ret

0000000000000468 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 468:	7139                	addi	sp,sp,-64
 46a:	fc06                	sd	ra,56(sp)
 46c:	f822                	sd	s0,48(sp)
 46e:	f426                	sd	s1,40(sp)
 470:	f04a                	sd	s2,32(sp)
 472:	ec4e                	sd	s3,24(sp)
 474:	0080                	addi	s0,sp,64
 476:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 478:	c299                	beqz	a3,47e <printint+0x16>
 47a:	0805c863          	bltz	a1,50a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 47e:	2581                	sext.w	a1,a1
  neg = 0;
 480:	4881                	li	a7,0
 482:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 486:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 488:	2601                	sext.w	a2,a2
 48a:	00001517          	auipc	a0,0x1
 48e:	84650513          	addi	a0,a0,-1978 # cd0 <digits>
 492:	883a                	mv	a6,a4
 494:	2705                	addiw	a4,a4,1
 496:	02c5f7bb          	remuw	a5,a1,a2
 49a:	1782                	slli	a5,a5,0x20
 49c:	9381                	srli	a5,a5,0x20
 49e:	97aa                	add	a5,a5,a0
 4a0:	0007c783          	lbu	a5,0(a5)
 4a4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4a8:	0005879b          	sext.w	a5,a1
 4ac:	02c5d5bb          	divuw	a1,a1,a2
 4b0:	0685                	addi	a3,a3,1
 4b2:	fec7f0e3          	bgeu	a5,a2,492 <printint+0x2a>
  if(neg)
 4b6:	00088b63          	beqz	a7,4cc <printint+0x64>
    buf[i++] = '-';
 4ba:	fd040793          	addi	a5,s0,-48
 4be:	973e                	add	a4,a4,a5
 4c0:	02d00793          	li	a5,45
 4c4:	fef70823          	sb	a5,-16(a4)
 4c8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4cc:	02e05863          	blez	a4,4fc <printint+0x94>
 4d0:	fc040793          	addi	a5,s0,-64
 4d4:	00e78933          	add	s2,a5,a4
 4d8:	fff78993          	addi	s3,a5,-1
 4dc:	99ba                	add	s3,s3,a4
 4de:	377d                	addiw	a4,a4,-1
 4e0:	1702                	slli	a4,a4,0x20
 4e2:	9301                	srli	a4,a4,0x20
 4e4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4e8:	fff94583          	lbu	a1,-1(s2)
 4ec:	8526                	mv	a0,s1
 4ee:	00000097          	auipc	ra,0x0
 4f2:	f58080e7          	jalr	-168(ra) # 446 <putc>
  while(--i >= 0)
 4f6:	197d                	addi	s2,s2,-1
 4f8:	ff3918e3          	bne	s2,s3,4e8 <printint+0x80>
}
 4fc:	70e2                	ld	ra,56(sp)
 4fe:	7442                	ld	s0,48(sp)
 500:	74a2                	ld	s1,40(sp)
 502:	7902                	ld	s2,32(sp)
 504:	69e2                	ld	s3,24(sp)
 506:	6121                	addi	sp,sp,64
 508:	8082                	ret
    x = -xx;
 50a:	40b005bb          	negw	a1,a1
    neg = 1;
 50e:	4885                	li	a7,1
    x = -xx;
 510:	bf8d                	j	482 <printint+0x1a>

0000000000000512 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 512:	7119                	addi	sp,sp,-128
 514:	fc86                	sd	ra,120(sp)
 516:	f8a2                	sd	s0,112(sp)
 518:	f4a6                	sd	s1,104(sp)
 51a:	f0ca                	sd	s2,96(sp)
 51c:	ecce                	sd	s3,88(sp)
 51e:	e8d2                	sd	s4,80(sp)
 520:	e4d6                	sd	s5,72(sp)
 522:	e0da                	sd	s6,64(sp)
 524:	fc5e                	sd	s7,56(sp)
 526:	f862                	sd	s8,48(sp)
 528:	f466                	sd	s9,40(sp)
 52a:	f06a                	sd	s10,32(sp)
 52c:	ec6e                	sd	s11,24(sp)
 52e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 530:	0005c903          	lbu	s2,0(a1)
 534:	18090f63          	beqz	s2,6d2 <vprintf+0x1c0>
 538:	8aaa                	mv	s5,a0
 53a:	8b32                	mv	s6,a2
 53c:	00158493          	addi	s1,a1,1
  state = 0;
 540:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 542:	02500a13          	li	s4,37
      if(c == 'd'){
 546:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 54a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 54e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 552:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 556:	00000b97          	auipc	s7,0x0
 55a:	77ab8b93          	addi	s7,s7,1914 # cd0 <digits>
 55e:	a839                	j	57c <vprintf+0x6a>
        putc(fd, c);
 560:	85ca                	mv	a1,s2
 562:	8556                	mv	a0,s5
 564:	00000097          	auipc	ra,0x0
 568:	ee2080e7          	jalr	-286(ra) # 446 <putc>
 56c:	a019                	j	572 <vprintf+0x60>
    } else if(state == '%'){
 56e:	01498f63          	beq	s3,s4,58c <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 572:	0485                	addi	s1,s1,1
 574:	fff4c903          	lbu	s2,-1(s1)
 578:	14090d63          	beqz	s2,6d2 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 57c:	0009079b          	sext.w	a5,s2
    if(state == 0){
 580:	fe0997e3          	bnez	s3,56e <vprintf+0x5c>
      if(c == '%'){
 584:	fd479ee3          	bne	a5,s4,560 <vprintf+0x4e>
        state = '%';
 588:	89be                	mv	s3,a5
 58a:	b7e5                	j	572 <vprintf+0x60>
      if(c == 'd'){
 58c:	05878063          	beq	a5,s8,5cc <vprintf+0xba>
      } else if(c == 'l') {
 590:	05978c63          	beq	a5,s9,5e8 <vprintf+0xd6>
      } else if(c == 'x') {
 594:	07a78863          	beq	a5,s10,604 <vprintf+0xf2>
      } else if(c == 'p') {
 598:	09b78463          	beq	a5,s11,620 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 59c:	07300713          	li	a4,115
 5a0:	0ce78663          	beq	a5,a4,66c <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5a4:	06300713          	li	a4,99
 5a8:	0ee78e63          	beq	a5,a4,6a4 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 5ac:	11478863          	beq	a5,s4,6bc <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5b0:	85d2                	mv	a1,s4
 5b2:	8556                	mv	a0,s5
 5b4:	00000097          	auipc	ra,0x0
 5b8:	e92080e7          	jalr	-366(ra) # 446 <putc>
        putc(fd, c);
 5bc:	85ca                	mv	a1,s2
 5be:	8556                	mv	a0,s5
 5c0:	00000097          	auipc	ra,0x0
 5c4:	e86080e7          	jalr	-378(ra) # 446 <putc>
      }
      state = 0;
 5c8:	4981                	li	s3,0
 5ca:	b765                	j	572 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5cc:	008b0913          	addi	s2,s6,8
 5d0:	4685                	li	a3,1
 5d2:	4629                	li	a2,10
 5d4:	000b2583          	lw	a1,0(s6)
 5d8:	8556                	mv	a0,s5
 5da:	00000097          	auipc	ra,0x0
 5de:	e8e080e7          	jalr	-370(ra) # 468 <printint>
 5e2:	8b4a                	mv	s6,s2
      state = 0;
 5e4:	4981                	li	s3,0
 5e6:	b771                	j	572 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5e8:	008b0913          	addi	s2,s6,8
 5ec:	4681                	li	a3,0
 5ee:	4629                	li	a2,10
 5f0:	000b2583          	lw	a1,0(s6)
 5f4:	8556                	mv	a0,s5
 5f6:	00000097          	auipc	ra,0x0
 5fa:	e72080e7          	jalr	-398(ra) # 468 <printint>
 5fe:	8b4a                	mv	s6,s2
      state = 0;
 600:	4981                	li	s3,0
 602:	bf85                	j	572 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 604:	008b0913          	addi	s2,s6,8
 608:	4681                	li	a3,0
 60a:	4641                	li	a2,16
 60c:	000b2583          	lw	a1,0(s6)
 610:	8556                	mv	a0,s5
 612:	00000097          	auipc	ra,0x0
 616:	e56080e7          	jalr	-426(ra) # 468 <printint>
 61a:	8b4a                	mv	s6,s2
      state = 0;
 61c:	4981                	li	s3,0
 61e:	bf91                	j	572 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 620:	008b0793          	addi	a5,s6,8
 624:	f8f43423          	sd	a5,-120(s0)
 628:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 62c:	03000593          	li	a1,48
 630:	8556                	mv	a0,s5
 632:	00000097          	auipc	ra,0x0
 636:	e14080e7          	jalr	-492(ra) # 446 <putc>
  putc(fd, 'x');
 63a:	85ea                	mv	a1,s10
 63c:	8556                	mv	a0,s5
 63e:	00000097          	auipc	ra,0x0
 642:	e08080e7          	jalr	-504(ra) # 446 <putc>
 646:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 648:	03c9d793          	srli	a5,s3,0x3c
 64c:	97de                	add	a5,a5,s7
 64e:	0007c583          	lbu	a1,0(a5)
 652:	8556                	mv	a0,s5
 654:	00000097          	auipc	ra,0x0
 658:	df2080e7          	jalr	-526(ra) # 446 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 65c:	0992                	slli	s3,s3,0x4
 65e:	397d                	addiw	s2,s2,-1
 660:	fe0914e3          	bnez	s2,648 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 664:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 668:	4981                	li	s3,0
 66a:	b721                	j	572 <vprintf+0x60>
        s = va_arg(ap, char*);
 66c:	008b0993          	addi	s3,s6,8
 670:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 674:	02090163          	beqz	s2,696 <vprintf+0x184>
        while(*s != 0){
 678:	00094583          	lbu	a1,0(s2)
 67c:	c9a1                	beqz	a1,6cc <vprintf+0x1ba>
          putc(fd, *s);
 67e:	8556                	mv	a0,s5
 680:	00000097          	auipc	ra,0x0
 684:	dc6080e7          	jalr	-570(ra) # 446 <putc>
          s++;
 688:	0905                	addi	s2,s2,1
        while(*s != 0){
 68a:	00094583          	lbu	a1,0(s2)
 68e:	f9e5                	bnez	a1,67e <vprintf+0x16c>
        s = va_arg(ap, char*);
 690:	8b4e                	mv	s6,s3
      state = 0;
 692:	4981                	li	s3,0
 694:	bdf9                	j	572 <vprintf+0x60>
          s = "(null)";
 696:	00000917          	auipc	s2,0x0
 69a:	63290913          	addi	s2,s2,1586 # cc8 <uthread_self+0x7a>
        while(*s != 0){
 69e:	02800593          	li	a1,40
 6a2:	bff1                	j	67e <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 6a4:	008b0913          	addi	s2,s6,8
 6a8:	000b4583          	lbu	a1,0(s6)
 6ac:	8556                	mv	a0,s5
 6ae:	00000097          	auipc	ra,0x0
 6b2:	d98080e7          	jalr	-616(ra) # 446 <putc>
 6b6:	8b4a                	mv	s6,s2
      state = 0;
 6b8:	4981                	li	s3,0
 6ba:	bd65                	j	572 <vprintf+0x60>
        putc(fd, c);
 6bc:	85d2                	mv	a1,s4
 6be:	8556                	mv	a0,s5
 6c0:	00000097          	auipc	ra,0x0
 6c4:	d86080e7          	jalr	-634(ra) # 446 <putc>
      state = 0;
 6c8:	4981                	li	s3,0
 6ca:	b565                	j	572 <vprintf+0x60>
        s = va_arg(ap, char*);
 6cc:	8b4e                	mv	s6,s3
      state = 0;
 6ce:	4981                	li	s3,0
 6d0:	b54d                	j	572 <vprintf+0x60>
    }
  }
}
 6d2:	70e6                	ld	ra,120(sp)
 6d4:	7446                	ld	s0,112(sp)
 6d6:	74a6                	ld	s1,104(sp)
 6d8:	7906                	ld	s2,96(sp)
 6da:	69e6                	ld	s3,88(sp)
 6dc:	6a46                	ld	s4,80(sp)
 6de:	6aa6                	ld	s5,72(sp)
 6e0:	6b06                	ld	s6,64(sp)
 6e2:	7be2                	ld	s7,56(sp)
 6e4:	7c42                	ld	s8,48(sp)
 6e6:	7ca2                	ld	s9,40(sp)
 6e8:	7d02                	ld	s10,32(sp)
 6ea:	6de2                	ld	s11,24(sp)
 6ec:	6109                	addi	sp,sp,128
 6ee:	8082                	ret

00000000000006f0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6f0:	715d                	addi	sp,sp,-80
 6f2:	ec06                	sd	ra,24(sp)
 6f4:	e822                	sd	s0,16(sp)
 6f6:	1000                	addi	s0,sp,32
 6f8:	e010                	sd	a2,0(s0)
 6fa:	e414                	sd	a3,8(s0)
 6fc:	e818                	sd	a4,16(s0)
 6fe:	ec1c                	sd	a5,24(s0)
 700:	03043023          	sd	a6,32(s0)
 704:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 708:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 70c:	8622                	mv	a2,s0
 70e:	00000097          	auipc	ra,0x0
 712:	e04080e7          	jalr	-508(ra) # 512 <vprintf>
}
 716:	60e2                	ld	ra,24(sp)
 718:	6442                	ld	s0,16(sp)
 71a:	6161                	addi	sp,sp,80
 71c:	8082                	ret

000000000000071e <printf>:

void
printf(const char *fmt, ...)
{
 71e:	711d                	addi	sp,sp,-96
 720:	ec06                	sd	ra,24(sp)
 722:	e822                	sd	s0,16(sp)
 724:	1000                	addi	s0,sp,32
 726:	e40c                	sd	a1,8(s0)
 728:	e810                	sd	a2,16(s0)
 72a:	ec14                	sd	a3,24(s0)
 72c:	f018                	sd	a4,32(s0)
 72e:	f41c                	sd	a5,40(s0)
 730:	03043823          	sd	a6,48(s0)
 734:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 738:	00840613          	addi	a2,s0,8
 73c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 740:	85aa                	mv	a1,a0
 742:	4505                	li	a0,1
 744:	00000097          	auipc	ra,0x0
 748:	dce080e7          	jalr	-562(ra) # 512 <vprintf>
}
 74c:	60e2                	ld	ra,24(sp)
 74e:	6442                	ld	s0,16(sp)
 750:	6125                	addi	sp,sp,96
 752:	8082                	ret

0000000000000754 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 754:	1141                	addi	sp,sp,-16
 756:	e422                	sd	s0,8(sp)
 758:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 75a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 75e:	00001797          	auipc	a5,0x1
 762:	8a27b783          	ld	a5,-1886(a5) # 1000 <freep>
 766:	a805                	j	796 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 768:	4618                	lw	a4,8(a2)
 76a:	9db9                	addw	a1,a1,a4
 76c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 770:	6398                	ld	a4,0(a5)
 772:	6318                	ld	a4,0(a4)
 774:	fee53823          	sd	a4,-16(a0)
 778:	a091                	j	7bc <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 77a:	ff852703          	lw	a4,-8(a0)
 77e:	9e39                	addw	a2,a2,a4
 780:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 782:	ff053703          	ld	a4,-16(a0)
 786:	e398                	sd	a4,0(a5)
 788:	a099                	j	7ce <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 78a:	6398                	ld	a4,0(a5)
 78c:	00e7e463          	bltu	a5,a4,794 <free+0x40>
 790:	00e6ea63          	bltu	a3,a4,7a4 <free+0x50>
{
 794:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 796:	fed7fae3          	bgeu	a5,a3,78a <free+0x36>
 79a:	6398                	ld	a4,0(a5)
 79c:	00e6e463          	bltu	a3,a4,7a4 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a0:	fee7eae3          	bltu	a5,a4,794 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 7a4:	ff852583          	lw	a1,-8(a0)
 7a8:	6390                	ld	a2,0(a5)
 7aa:	02059713          	slli	a4,a1,0x20
 7ae:	9301                	srli	a4,a4,0x20
 7b0:	0712                	slli	a4,a4,0x4
 7b2:	9736                	add	a4,a4,a3
 7b4:	fae60ae3          	beq	a2,a4,768 <free+0x14>
    bp->s.ptr = p->s.ptr;
 7b8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7bc:	4790                	lw	a2,8(a5)
 7be:	02061713          	slli	a4,a2,0x20
 7c2:	9301                	srli	a4,a4,0x20
 7c4:	0712                	slli	a4,a4,0x4
 7c6:	973e                	add	a4,a4,a5
 7c8:	fae689e3          	beq	a3,a4,77a <free+0x26>
  } else
    p->s.ptr = bp;
 7cc:	e394                	sd	a3,0(a5)
  freep = p;
 7ce:	00001717          	auipc	a4,0x1
 7d2:	82f73923          	sd	a5,-1998(a4) # 1000 <freep>
}
 7d6:	6422                	ld	s0,8(sp)
 7d8:	0141                	addi	sp,sp,16
 7da:	8082                	ret

00000000000007dc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7dc:	7139                	addi	sp,sp,-64
 7de:	fc06                	sd	ra,56(sp)
 7e0:	f822                	sd	s0,48(sp)
 7e2:	f426                	sd	s1,40(sp)
 7e4:	f04a                	sd	s2,32(sp)
 7e6:	ec4e                	sd	s3,24(sp)
 7e8:	e852                	sd	s4,16(sp)
 7ea:	e456                	sd	s5,8(sp)
 7ec:	e05a                	sd	s6,0(sp)
 7ee:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f0:	02051493          	slli	s1,a0,0x20
 7f4:	9081                	srli	s1,s1,0x20
 7f6:	04bd                	addi	s1,s1,15
 7f8:	8091                	srli	s1,s1,0x4
 7fa:	0014899b          	addiw	s3,s1,1
 7fe:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 800:	00001517          	auipc	a0,0x1
 804:	80053503          	ld	a0,-2048(a0) # 1000 <freep>
 808:	c515                	beqz	a0,834 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 80c:	4798                	lw	a4,8(a5)
 80e:	02977f63          	bgeu	a4,s1,84c <malloc+0x70>
 812:	8a4e                	mv	s4,s3
 814:	0009871b          	sext.w	a4,s3
 818:	6685                	lui	a3,0x1
 81a:	00d77363          	bgeu	a4,a3,820 <malloc+0x44>
 81e:	6a05                	lui	s4,0x1
 820:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 824:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 828:	00000917          	auipc	s2,0x0
 82c:	7d890913          	addi	s2,s2,2008 # 1000 <freep>
  if(p == (char*)-1)
 830:	5afd                	li	s5,-1
 832:	a88d                	j	8a4 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 834:	00001797          	auipc	a5,0x1
 838:	9ec78793          	addi	a5,a5,-1556 # 1220 <base>
 83c:	00000717          	auipc	a4,0x0
 840:	7cf73223          	sd	a5,1988(a4) # 1000 <freep>
 844:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 846:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 84a:	b7e1                	j	812 <malloc+0x36>
      if(p->s.size == nunits)
 84c:	02e48b63          	beq	s1,a4,882 <malloc+0xa6>
        p->s.size -= nunits;
 850:	4137073b          	subw	a4,a4,s3
 854:	c798                	sw	a4,8(a5)
        p += p->s.size;
 856:	1702                	slli	a4,a4,0x20
 858:	9301                	srli	a4,a4,0x20
 85a:	0712                	slli	a4,a4,0x4
 85c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 85e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 862:	00000717          	auipc	a4,0x0
 866:	78a73f23          	sd	a0,1950(a4) # 1000 <freep>
      return (void*)(p + 1);
 86a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 86e:	70e2                	ld	ra,56(sp)
 870:	7442                	ld	s0,48(sp)
 872:	74a2                	ld	s1,40(sp)
 874:	7902                	ld	s2,32(sp)
 876:	69e2                	ld	s3,24(sp)
 878:	6a42                	ld	s4,16(sp)
 87a:	6aa2                	ld	s5,8(sp)
 87c:	6b02                	ld	s6,0(sp)
 87e:	6121                	addi	sp,sp,64
 880:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 882:	6398                	ld	a4,0(a5)
 884:	e118                	sd	a4,0(a0)
 886:	bff1                	j	862 <malloc+0x86>
  hp->s.size = nu;
 888:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 88c:	0541                	addi	a0,a0,16
 88e:	00000097          	auipc	ra,0x0
 892:	ec6080e7          	jalr	-314(ra) # 754 <free>
  return freep;
 896:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 89a:	d971                	beqz	a0,86e <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 89c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 89e:	4798                	lw	a4,8(a5)
 8a0:	fa9776e3          	bgeu	a4,s1,84c <malloc+0x70>
    if(p == freep)
 8a4:	00093703          	ld	a4,0(s2)
 8a8:	853e                	mv	a0,a5
 8aa:	fef719e3          	bne	a4,a5,89c <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 8ae:	8552                	mv	a0,s4
 8b0:	00000097          	auipc	ra,0x0
 8b4:	b7e080e7          	jalr	-1154(ra) # 42e <sbrk>
  if(p == (char*)-1)
 8b8:	fd5518e3          	bne	a0,s5,888 <malloc+0xac>
        return 0;
 8bc:	4501                	li	a0,0
 8be:	bf45                	j	86e <malloc+0x92>

00000000000008c0 <uswtch>:
 8c0:	00153023          	sd	ra,0(a0)
 8c4:	00253423          	sd	sp,8(a0)
 8c8:	e900                	sd	s0,16(a0)
 8ca:	ed04                	sd	s1,24(a0)
 8cc:	03253023          	sd	s2,32(a0)
 8d0:	03353423          	sd	s3,40(a0)
 8d4:	03453823          	sd	s4,48(a0)
 8d8:	03553c23          	sd	s5,56(a0)
 8dc:	05653023          	sd	s6,64(a0)
 8e0:	05753423          	sd	s7,72(a0)
 8e4:	05853823          	sd	s8,80(a0)
 8e8:	05953c23          	sd	s9,88(a0)
 8ec:	07a53023          	sd	s10,96(a0)
 8f0:	07b53423          	sd	s11,104(a0)
 8f4:	0005b083          	ld	ra,0(a1)
 8f8:	0085b103          	ld	sp,8(a1)
 8fc:	6980                	ld	s0,16(a1)
 8fe:	6d84                	ld	s1,24(a1)
 900:	0205b903          	ld	s2,32(a1)
 904:	0285b983          	ld	s3,40(a1)
 908:	0305ba03          	ld	s4,48(a1)
 90c:	0385ba83          	ld	s5,56(a1)
 910:	0405bb03          	ld	s6,64(a1)
 914:	0485bb83          	ld	s7,72(a1)
 918:	0505bc03          	ld	s8,80(a1)
 91c:	0585bc83          	ld	s9,88(a1)
 920:	0605bd03          	ld	s10,96(a1)
 924:	0685bd83          	ld	s11,104(a1)
 928:	8082                	ret

000000000000092a <uthread_create>:
struct uthread uthreads[MAX_UTHREADS];
struct uthread *currentThread;
int ids = 0;

int uthread_create(void (*start_func)(), enum sched_priority priority)
{
 92a:	1141                	addi	sp,sp,-16
 92c:	e422                	sd	s0,8(sp)
 92e:	0800                	addi	s0,sp,16
    int i;
    ids ++;
 930:	00000797          	auipc	a5,0x0
 934:	6dc78793          	addi	a5,a5,1756 # 100c <ids>
 938:	0007a303          	lw	t1,0(a5)
 93c:	2305                	addiw	t1,t1,1
 93e:	0067a023          	sw	t1,0(a5)

    for (i = 0; i < MAX_UTHREADS; i++)
 942:	00002717          	auipc	a4,0x2
 946:	88e70713          	addi	a4,a4,-1906 # 21d0 <uthreads+0xfa0>
 94a:	4781                	li	a5,0
 94c:	6605                	lui	a2,0x1
 94e:	02060613          	addi	a2,a2,32 # 1020 <buf>
 952:	4811                	li	a6,4
    {
        if (uthreads[i].state == FREE)
 954:	4314                	lw	a3,0(a4)
 956:	c699                	beqz	a3,964 <uthread_create+0x3a>
    for (i = 0; i < MAX_UTHREADS; i++)
 958:	2785                	addiw	a5,a5,1
 95a:	9732                	add	a4,a4,a2
 95c:	ff079ce3          	bne	a5,a6,954 <uthread_create+0x2a>
            break;
    }     

    if (i == MAX_UTHREADS)
        return -1;
 960:	557d                	li	a0,-1
 962:	a889                	j	9b4 <uthread_create+0x8a>
    if (i == MAX_UTHREADS)
 964:	4711                	li	a4,4
 966:	04e78a63          	beq	a5,a4,9ba <uthread_create+0x90>

    uthreads[i].context.ra = (uint64)start_func;
 96a:	00001897          	auipc	a7,0x1
 96e:	8c688893          	addi	a7,a7,-1850 # 1230 <uthreads>
 972:	00779693          	slli	a3,a5,0x7
 976:	00f68633          	add	a2,a3,a5
 97a:	0616                	slli	a2,a2,0x5
 97c:	9646                	add	a2,a2,a7
 97e:	6805                	lui	a6,0x1
 980:	00c80e33          	add	t3,a6,a2
 984:	faae3423          	sd	a0,-88(t3)
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
    uthreads[i].context.sp += sizeof(uint64);
 988:	00f68733          	add	a4,a3,a5
 98c:	0716                	slli	a4,a4,0x5
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
 98e:	fa080513          	addi	a0,a6,-96 # fa0 <digits+0x2d0>
 992:	972a                	add	a4,a4,a0
 994:	9746                	add	a4,a4,a7
    uthreads[i].context.sp += sizeof(uint64);
 996:	0721                	addi	a4,a4,8
 998:	faee3823          	sd	a4,-80(t3)
    uthreads[i].state = RUNNABLE;
 99c:	4709                	li	a4,2
 99e:	faee2023          	sw	a4,-96(t3)
    uthreads[i].priority = priority;
 9a2:	00be2c23          	sw	a1,24(t3)
    currentThread = &uthreads[i];
 9a6:	00000717          	auipc	a4,0x0
 9aa:	66c73523          	sd	a2,1642(a4) # 1010 <currentThread>

    currentThread->pid = ids;
 9ae:	006e2e23          	sw	t1,28(t3)

    return 0;
 9b2:	4501                	li	a0,0
}
 9b4:	6422                	ld	s0,8(sp)
 9b6:	0141                	addi	sp,sp,16
 9b8:	8082                	ret
        return -1;
 9ba:	557d                	li	a0,-1
 9bc:	bfe5                	j	9b4 <uthread_create+0x8a>

00000000000009be <get_state>:
  currentThread->state = RUNNABLE;
  schedule();
}


char* get_state(enum tstate s){
 9be:	1141                	addi	sp,sp,-16
 9c0:	e422                	sd	s0,8(sp)
 9c2:	0800                	addi	s0,sp,16
  switch (s)
 9c4:	4705                	li	a4,1
 9c6:	02e50763          	beq	a0,a4,9f4 <get_state+0x36>
 9ca:	87aa                	mv	a5,a0
 9cc:	4709                	li	a4,2
  case FREE:
    return "FREE";
  case  RUNNING:
    return "RUNNING";
  case RUNNABLE:
    return "RUNNABLE";
 9ce:	00000517          	auipc	a0,0x0
 9d2:	32250513          	addi	a0,a0,802 # cf0 <digits+0x20>
  switch (s)
 9d6:	00e78763          	beq	a5,a4,9e4 <get_state+0x26>
  }

  return "ERROR";
 9da:	00000517          	auipc	a0,0x0
 9de:	30e50513          	addi	a0,a0,782 # ce8 <digits+0x18>
  switch (s)
 9e2:	c781                	beqz	a5,9ea <get_state+0x2c>
}
 9e4:	6422                	ld	s0,8(sp)
 9e6:	0141                	addi	sp,sp,16
 9e8:	8082                	ret
    return "FREE";
 9ea:	00000517          	auipc	a0,0x0
 9ee:	31e50513          	addi	a0,a0,798 # d08 <digits+0x38>
 9f2:	bfcd                	j	9e4 <get_state+0x26>
  switch (s)
 9f4:	00000517          	auipc	a0,0x0
 9f8:	30c50513          	addi	a0,a0,780 # d00 <digits+0x30>
 9fc:	b7e5                	j	9e4 <get_state+0x26>

00000000000009fe <find_next>:
  uswtch(&cur->context, &next->context);
  
}


struct uthread *find_next(enum sched_priority priority){
 9fe:	1141                	addi	sp,sp,-16
 a00:	e422                	sd	s0,8(sp)
 a02:	0800                	addi	s0,sp,16
  
  struct uthread* next = 0;
  int i;
  int j;
  j = (currentThread - uthreads + 1) % MAX_UTHREADS;
 a04:	00000717          	auipc	a4,0x0
 a08:	60c73703          	ld	a4,1548(a4) # 1010 <currentThread>
 a0c:	00001797          	auipc	a5,0x1
 a10:	82478793          	addi	a5,a5,-2012 # 1230 <uthreads>
 a14:	8f1d                	sub	a4,a4,a5
 a16:	8715                	srai	a4,a4,0x5
 a18:	00000797          	auipc	a5,0x0
 a1c:	2587b783          	ld	a5,600(a5) # c70 <uthread_self+0x22>
 a20:	02f70733          	mul	a4,a4,a5
 a24:	0705                	addi	a4,a4,1
 a26:	43f75793          	srai	a5,a4,0x3f
 a2a:	03e7d693          	srli	a3,a5,0x3e
 a2e:	00d707b3          	add	a5,a4,a3
 a32:	8b8d                	andi	a5,a5,3
 a34:	8f95                	sub	a5,a5,a3
 a36:	4691                	li	a3,4

  for(i = 0; i < MAX_UTHREADS; i++){
    if((uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING) && uthreads[j].priority == priority){
 a38:	00000597          	auipc	a1,0x0
 a3c:	7f858593          	addi	a1,a1,2040 # 1230 <uthreads>
 a40:	6605                	lui	a2,0x1
 a42:	4805                	li	a6,1
 a44:	a819                	j	a5a <find_next+0x5c>
      next = &uthreads[j];
      break;
    }
    j = (j+1) % MAX_UTHREADS;    
 a46:	2785                	addiw	a5,a5,1
 a48:	41f7d71b          	sraiw	a4,a5,0x1f
 a4c:	01e7571b          	srliw	a4,a4,0x1e
 a50:	9fb9                	addw	a5,a5,a4
 a52:	8b8d                	andi	a5,a5,3
 a54:	9f99                	subw	a5,a5,a4
  for(i = 0; i < MAX_UTHREADS; i++){
 a56:	36fd                	addiw	a3,a3,-1
 a58:	ce9d                	beqz	a3,a96 <find_next+0x98>
    if((uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING) && uthreads[j].priority == priority){
 a5a:	00779713          	slli	a4,a5,0x7
 a5e:	973e                	add	a4,a4,a5
 a60:	0716                	slli	a4,a4,0x5
 a62:	972e                	add	a4,a4,a1
 a64:	9732                	add	a4,a4,a2
 a66:	fa072703          	lw	a4,-96(a4)
 a6a:	377d                	addiw	a4,a4,-1
 a6c:	fce86de3          	bltu	a6,a4,a46 <find_next+0x48>
 a70:	00779713          	slli	a4,a5,0x7
 a74:	973e                	add	a4,a4,a5
 a76:	0716                	slli	a4,a4,0x5
 a78:	972e                	add	a4,a4,a1
 a7a:	9732                	add	a4,a4,a2
 a7c:	4f18                	lw	a4,24(a4)
 a7e:	fca714e3          	bne	a4,a0,a46 <find_next+0x48>
      next = &uthreads[j];
 a82:	00779513          	slli	a0,a5,0x7
 a86:	953e                	add	a0,a0,a5
 a88:	0516                	slli	a0,a0,0x5
 a8a:	00000797          	auipc	a5,0x0
 a8e:	7a678793          	addi	a5,a5,1958 # 1230 <uthreads>
 a92:	953e                	add	a0,a0,a5
      break;
 a94:	a011                	j	a98 <find_next+0x9a>
  struct uthread* next = 0;
 a96:	4501                	li	a0,0
  }

  return next;
}
 a98:	6422                	ld	s0,8(sp)
 a9a:	0141                	addi	sp,sp,16
 a9c:	8082                	ret

0000000000000a9e <schedule>:
void schedule(){
 a9e:	1101                	addi	sp,sp,-32
 aa0:	ec06                	sd	ra,24(sp)
 aa2:	e822                	sd	s0,16(sp)
 aa4:	e426                	sd	s1,8(sp)
 aa6:	1000                	addi	s0,sp,32
  cur = currentThread;
 aa8:	00000497          	auipc	s1,0x0
 aac:	5684b483          	ld	s1,1384(s1) # 1010 <currentThread>
  next = find_next(HIGH);
 ab0:	4509                	li	a0,2
 ab2:	00000097          	auipc	ra,0x0
 ab6:	f4c080e7          	jalr	-180(ra) # 9fe <find_next>
  if(next == 0)
 aba:	c915                	beqz	a0,aee <schedule+0x50>
  currentThread = next;
 abc:	00000797          	auipc	a5,0x0
 ac0:	54a7ba23          	sd	a0,1364(a5) # 1010 <currentThread>
  currentThread->state = RUNNING;
 ac4:	6785                	lui	a5,0x1
 ac6:	00f50733          	add	a4,a0,a5
 aca:	4685                	li	a3,1
 acc:	fad72023          	sw	a3,-96(a4)
  uswtch(&cur->context, &next->context);
 ad0:	fa878793          	addi	a5,a5,-88 # fa8 <digits+0x2d8>
 ad4:	00f505b3          	add	a1,a0,a5
 ad8:	00f48533          	add	a0,s1,a5
 adc:	00000097          	auipc	ra,0x0
 ae0:	de4080e7          	jalr	-540(ra) # 8c0 <uswtch>
}
 ae4:	60e2                	ld	ra,24(sp)
 ae6:	6442                	ld	s0,16(sp)
 ae8:	64a2                	ld	s1,8(sp)
 aea:	6105                	addi	sp,sp,32
 aec:	8082                	ret
    next = find_next(MEDIUM);
 aee:	4505                	li	a0,1
 af0:	00000097          	auipc	ra,0x0
 af4:	f0e080e7          	jalr	-242(ra) # 9fe <find_next>
  if(next == 0)
 af8:	f171                	bnez	a0,abc <schedule+0x1e>
    next = find_next(LOW);
 afa:	00000097          	auipc	ra,0x0
 afe:	f04080e7          	jalr	-252(ra) # 9fe <find_next>
  if(next == 0)
 b02:	fd4d                	bnez	a0,abc <schedule+0x1e>
    exit(-1);
 b04:	557d                	li	a0,-1
 b06:	00000097          	auipc	ra,0x0
 b0a:	8a0080e7          	jalr	-1888(ra) # 3a6 <exit>

0000000000000b0e <uthread_yield>:
{
 b0e:	1141                	addi	sp,sp,-16
 b10:	e406                	sd	ra,8(sp)
 b12:	e022                	sd	s0,0(sp)
 b14:	0800                	addi	s0,sp,16
  currentThread->state = RUNNABLE;
 b16:	00000797          	auipc	a5,0x0
 b1a:	4fa7b783          	ld	a5,1274(a5) # 1010 <currentThread>
 b1e:	6705                	lui	a4,0x1
 b20:	97ba                	add	a5,a5,a4
 b22:	4709                	li	a4,2
 b24:	fae7a023          	sw	a4,-96(a5)
  schedule();
 b28:	00000097          	auipc	ra,0x0
 b2c:	f76080e7          	jalr	-138(ra) # a9e <schedule>
}
 b30:	60a2                	ld	ra,8(sp)
 b32:	6402                	ld	s0,0(sp)
 b34:	0141                	addi	sp,sp,16
 b36:	8082                	ret

0000000000000b38 <uthread_exit>:

void uthread_exit()
{
 b38:	1141                	addi	sp,sp,-16
 b3a:	e406                	sd	ra,8(sp)
 b3c:	e022                	sd	s0,0(sp)
 b3e:	0800                	addi	s0,sp,16
  currentThread->state = FREE;
 b40:	00000797          	auipc	a5,0x0
 b44:	4d07b783          	ld	a5,1232(a5) # 1010 <currentThread>
 b48:	6705                	lui	a4,0x1
 b4a:	97ba                	add	a5,a5,a4
 b4c:	fa07a023          	sw	zero,-96(a5)
  int remainingThreads = 0;
  for (int i = 0; i < MAX_UTHREADS; i++) {
 b50:	00001797          	auipc	a5,0x1
 b54:	68078793          	addi	a5,a5,1664 # 21d0 <uthreads+0xfa0>
 b58:	00005597          	auipc	a1,0x5
 b5c:	6f858593          	addi	a1,a1,1784 # 6250 <uthreads+0x5020>
  int remainingThreads = 0;
 b60:	4501                	li	a0,0
    if (uthreads[i].state == RUNNABLE) 
 b62:	4609                	li	a2,2
  for (int i = 0; i < MAX_UTHREADS; i++) {
 b64:	6685                	lui	a3,0x1
 b66:	02068693          	addi	a3,a3,32 # 1020 <buf>
 b6a:	a021                	j	b72 <uthread_exit+0x3a>
 b6c:	97b6                	add	a5,a5,a3
 b6e:	00b78763          	beq	a5,a1,b7c <uthread_exit+0x44>
    if (uthreads[i].state == RUNNABLE) 
 b72:	4398                	lw	a4,0(a5)
 b74:	fec71ce3          	bne	a4,a2,b6c <uthread_exit+0x34>
      remainingThreads++;
 b78:	2505                	addiw	a0,a0,1
 b7a:	bfcd                	j	b6c <uthread_exit+0x34>
  }

  if (remainingThreads == 0){
 b7c:	c909                	beqz	a0,b8e <uthread_exit+0x56>
    exit(0);
  }
  else 
  {
    schedule();
 b7e:	00000097          	auipc	ra,0x0
 b82:	f20080e7          	jalr	-224(ra) # a9e <schedule>
  }
}
 b86:	60a2                	ld	ra,8(sp)
 b88:	6402                	ld	s0,0(sp)
 b8a:	0141                	addi	sp,sp,16
 b8c:	8082                	ret
    exit(0);
 b8e:	00000097          	auipc	ra,0x0
 b92:	818080e7          	jalr	-2024(ra) # 3a6 <exit>

0000000000000b96 <uthread_set_priority>:

enum sched_priority uthread_set_priority(enum sched_priority priority)
{
 b96:	1141                	addi	sp,sp,-16
 b98:	e422                	sd	s0,8(sp)
 b9a:	0800                	addi	s0,sp,16
  enum sched_priority prevPriority = currentThread->priority;
 b9c:	00000797          	auipc	a5,0x0
 ba0:	4747b783          	ld	a5,1140(a5) # 1010 <currentThread>
 ba4:	6705                	lui	a4,0x1
 ba6:	97ba                	add	a5,a5,a4
 ba8:	4f98                	lw	a4,24(a5)
  currentThread->priority = priority;
 baa:	cf88                	sw	a0,24(a5)
  return prevPriority;
}
 bac:	853a                	mv	a0,a4
 bae:	6422                	ld	s0,8(sp)
 bb0:	0141                	addi	sp,sp,16
 bb2:	8082                	ret

0000000000000bb4 <uthread_get_priority>:

enum sched_priority uthread_get_priority()
{
 bb4:	1141                	addi	sp,sp,-16
 bb6:	e422                	sd	s0,8(sp)
 bb8:	0800                	addi	s0,sp,16
    return currentThread->priority;
 bba:	00000797          	auipc	a5,0x0
 bbe:	4567b783          	ld	a5,1110(a5) # 1010 <currentThread>
 bc2:	6705                	lui	a4,0x1
 bc4:	97ba                	add	a5,a5,a4
}
 bc6:	4f88                	lw	a0,24(a5)
 bc8:	6422                	ld	s0,8(sp)
 bca:	0141                	addi	sp,sp,16
 bcc:	8082                	ret

0000000000000bce <uthread_start_all>:

int uthreadStarted = 0;

int uthread_start_all() {
 bce:	7175                	addi	sp,sp,-144
 bd0:	e506                	sd	ra,136(sp)
 bd2:	e122                	sd	s0,128(sp)
 bd4:	fca6                	sd	s1,120(sp)
 bd6:	0900                	addi	s0,sp,144
  if (uthreadStarted) {
 bd8:	00000497          	auipc	s1,0x0
 bdc:	4304a483          	lw	s1,1072(s1) # 1008 <uthreadStarted>
 be0:	e4ad                	bnez	s1,c4a <uthread_start_all+0x7c>
    return -1;
  }
  uthreadStarted = 1;
 be2:	4785                	li	a5,1
 be4:	00000717          	auipc	a4,0x0
 be8:	42f72223          	sw	a5,1060(a4) # 1008 <uthreadStarted>

  struct context dummyContext;
  struct uthread *next; 

  next = find_next(HIGH);
 bec:	4509                	li	a0,2
 bee:	00000097          	auipc	ra,0x0
 bf2:	e10080e7          	jalr	-496(ra) # 9fe <find_next>
  if(next == 0)
 bf6:	c915                	beqz	a0,c2a <uthread_start_all+0x5c>
  if(next == 0)
    next = find_next(LOW);
  if(next == 0)
    exit(-1);

  currentThread = next;
 bf8:	00000797          	auipc	a5,0x0
 bfc:	40a7bc23          	sd	a0,1048(a5) # 1010 <currentThread>
  currentThread->state = RUNNING;
 c00:	6585                	lui	a1,0x1
 c02:	00b507b3          	add	a5,a0,a1
 c06:	4705                	li	a4,1
 c08:	fae7a023          	sw	a4,-96(a5)

  uswtch(&dummyContext, &currentThread->context);
 c0c:	fa858593          	addi	a1,a1,-88 # fa8 <digits+0x2d8>
 c10:	95aa                	add	a1,a1,a0
 c12:	f7040513          	addi	a0,s0,-144
 c16:	00000097          	auipc	ra,0x0
 c1a:	caa080e7          	jalr	-854(ra) # 8c0 <uswtch>

  return 0;
}
 c1e:	8526                	mv	a0,s1
 c20:	60aa                	ld	ra,136(sp)
 c22:	640a                	ld	s0,128(sp)
 c24:	74e6                	ld	s1,120(sp)
 c26:	6149                	addi	sp,sp,144
 c28:	8082                	ret
    next = find_next(MEDIUM);
 c2a:	4505                	li	a0,1
 c2c:	00000097          	auipc	ra,0x0
 c30:	dd2080e7          	jalr	-558(ra) # 9fe <find_next>
  if(next == 0)
 c34:	f171                	bnez	a0,bf8 <uthread_start_all+0x2a>
    next = find_next(LOW);
 c36:	00000097          	auipc	ra,0x0
 c3a:	dc8080e7          	jalr	-568(ra) # 9fe <find_next>
  if(next == 0)
 c3e:	fd4d                	bnez	a0,bf8 <uthread_start_all+0x2a>
    exit(-1);
 c40:	557d                	li	a0,-1
 c42:	fffff097          	auipc	ra,0xfffff
 c46:	764080e7          	jalr	1892(ra) # 3a6 <exit>
    return -1;
 c4a:	54fd                	li	s1,-1
 c4c:	bfc9                	j	c1e <uthread_start_all+0x50>

0000000000000c4e <uthread_self>:


struct uthread *uthread_self()
{
 c4e:	1141                	addi	sp,sp,-16
 c50:	e422                	sd	s0,8(sp)
 c52:	0800                	addi	s0,sp,16
    return currentThread;
 c54:	00000517          	auipc	a0,0x0
 c58:	3bc53503          	ld	a0,956(a0) # 1010 <currentThread>
 c5c:	6422                	ld	s0,8(sp)
 c5e:	0141                	addi	sp,sp,16
 c60:	8082                	ret
