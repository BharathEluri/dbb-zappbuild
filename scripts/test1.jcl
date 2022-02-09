//*===================================================================
//*
//*                   PROCESSEUR ENDEVOR GCB3A
//*
//*        COBOL ENTREPRISE BATCH ET CICS + DLI + XDLI + DB2 + ...
//*
//*===================================================================
//*
//*===================================================================
//*======= H I S T O R I Q U E   D E S   M A I N T E N A N C E S =====
//*===================================================================
//*   DATE   * RSP * DESCRIPTION
//*----------* --- * -------------------------------------------------
//* ../../16 *     *
//*----------* --- * -------------------------------------------------
//* 12/03/19 * MTT * EVOL: - GESTION DE CHANGEMENT PRC GRP POUR GFA:
//*          *     *         DE DB2/DLI VERS DB2 AVEC DEL BTCHLOA2
//*          *     *       - EXTTRACTION DES DONNEES DE SUIVI DE
//*          *     *         COMPILATION POUR LE CENTRE DE SERVICE MF
//*----------* --- * -------------------------------------------------
//* 08/08/18 * PPN * EVOL: SUPPRESSION BIB LKDSEAN='SYS1C.MVS.LINKLIB'
//*          *     * QUI SE TROUVE EN LINKLIB ET N'A RIEN A FAIRE DANS
//*          *     * LES PROCESSEURS ENDEVOR
//*----------* --- * -------------------------------------------------
//* 16/03/16 * PB  * EVOL: MEO ODM OPER DECISION MNGR
//*          *     * CCID=CHG141020PB1
//*          *     * - UPDATE SYSLIB COMPILE AVEC SHBRCOBC
//*----------* --- * -------------------------------------------------
//* 27/01/14 * PB  * EVOL : SQLDYN WITH DBIQ + RLF                     *
//*          *     * - RETRAIT OPTION PROC GROUP SUR GENERATE          *
//*          *     * - AJOUT DD CWPWBNV  POUR COMPUWARE                *
//*          *     * - USE CEE.SCEELKED VERSUS SYS1                    *
//*----------* --- * -------------------------------------------------
//* 11/01/13 * PB  * UPDT : RETRAIT KEYFAST
//*----------* --- * -------------------------------------------------
//* 09/11/12 * PB  * UPDT : INVARIANCE TECE-BCP2
//*----------* --- * -------------------------------------------------
//* 11/09/12 * PB  * UPDT : DSN DDIO COMPATIBLE TECE-BCP2
//*----------* --- * -------------------------------------------------
//* 02/02/12 * PB  * UPDT : STEPLIB COBOL
//*----------* --- * -------------------------------------------------
//* 28/09/10 * PB  * ACTIVATION DE L'INVERSION ANALYSE METRIXWARE
//*          *     * PRINT LISTING SI STEP MTXCOBBP KO
//*----------* --- * -------------------------------------------------
//* 16/09/10 * PB  * UPD : DFHEILID EST DANS SDFHSAMP DEPUIS CTS310
//*----------* --- * -------------------------------------------------
//* 28/04/10 * PB  * EVOL : REGLE ANALYSE METRIXWARE INVERSEE
//*          *     *        MTX EST A LA DEMANDE (PLUS OBLIGATOIRE)
//*----------* --- * -------------------------------------------------
//* 04/01/10 * PB  * UPD : CHAMP PARM POUR METRIXWARE
//*----------+-----+---------------------------------------------------*
//* 07/09/09 * PB  * UPDT : OPTION COBOL SSR EN F : COBODEV
//*          *     *       PAS DE MODIF DU PROCESSEUR (DOCONLY)
//*          *     *       MODIF DES PGRP
//*----------+-----+---------------------------------------------------*
//* 17/06/09 * PB  * UPDT : STEPLIB METRIXWARE
//*          *     * INC : ERREUR SYSIN GENERATE DPK
//*          *     * UPDT : METRIXW ERREUR DD EXPANCE
//*          *     * INC : ERREUR DELETE DPK APRES MOVE EN F
//*----------+-----+---------------------------------------------------*
//* 27/04/09 * PB  * INCIDENT I18175734 : FOOTPRINT SUR DPKBTCH        *
//*          *     * MSG C1G0030E, C1G0014E                            *
//*          *     * DEVL ONLY BIND DT01 PUIS BIND D11T                *
//*          *     * BYPASS TEMPORAIRE POUR DEBLOQUER : DELETE DPKBTCH *
//*----------* --- * -------------------------------------------------
//* 21/04/09 * PB  * MIGRATION R12 : INCIDENT DOUBLE QUOTE (FIN)
//*----------* --- * -------------------------------------------------
//* 19/04/09 * PB  * MIGRATION R12 : INCIDENT DOUBLE QUOTE
//*          *     * MAINTENANCE : SUPPRESSION B ET W
//*----------* --- * -------------------------------------------------
//* 01/04/09 * PB  * SUPPRESSION INTERTEST + DIVERS
//*----------* --- * -------------------------------------------------
//* 13/03/09 * PB  * INC : -805 EN PROD : PERTE VERSION DB2
//*          *     * MAINT : RETRAIT BIB PTF DB2
//*----------* --- * -------------------------------------------------
//* 03/03/09 * PB  * MAINT : AJOUT NOOPT SUR COMPILE POUR CONFORMITE
//*          *     *         COMPUWARE
//*----------* --- * -------------------------------------------------
//* 06/02/09 * PB  * INCIDENT : -927 SUR CE05G0
//*          *     * REFONTE CONCATENATION SYSLIB LKD INCLUDE LKD
//*          *     * RECONDUCTION OPT COBOL2 : NODYNAM, NOFASTSRT, ...
//*----------* --- * -------------------------------------------------
//* 03/02/09 * PB  * INCIDENT : 1708 SUR TRACE01 DE PRTDEV
//*          *     * INCIDENT : STAGE R ABSENT SUR CONCATENATION
//*----------* --- * -------------------------------------------------
//* 02/02/09 * PB  * INCIDENT -927 AVEC EXEC DLI+DB2
//*          *     * MAINTENANCES DIVERSES
//*----------* --- * -------------------------------------------------
//* 17/12/08 * PB  * MAINTENANCE INCIDENT 17743404
//*          *     * MSG PV001 SUR MOVE EN PROD (VERIF COL 71)
//*----------* --- * -------------------------------------------------
//* 01/12/08 * PB  * MAINTENANCE : LIBERATION ENV B
//*          *     *               ON NE FAIT PLUS LE GENERATE DPK*
//*----------* --- * -------------------------------------------------
//* 30/10/08 * PB  * MAINTENANCE : STAGE B SE COMPORTE COMME STAGE V
//*----------* --- * -------------------------------------------------
//* 02/09/07 * PB  * CREATION INITIALE
//*===================================================================
//*
//*============ D E S C R I P T I O N   G E N E R A L E  =============
//*===================================================================
//* PROCESSEUR UNIQUE COBOL ENTREPRISE BATCH ET CICS.
//* IL PERMET LA COMPILATION DE TOUT TYPE DE PROGRAMME COBOL.
//* LA COMPILATION COBOL PEUT INTEGRER LE TRANSLATOR CICS ET/OU
//* LE PRE-COMPILATEUR DB2.
//*
//* LES STEPS A EXECUTER SONT DETERMINES GRACE A LA CODIFICATION DU
//* PROCESSEUR GROUPE.
//* ---> NORME DES PROCESSEURS GROUPE COBOL3
//* VVCCOO : <VV : VERSION COMPILATEUR><CC : CONTEXTE><OO : OPTIONS>
//*   VV : 'CE' POUR COBOL ENTERPRISE
//*   CC : CONTEXTE DU SOURCE (CC EST IMPERATIVEMENT NUMERIQUE)
//*       BATCH
//*        01 = BTCH, 02 = BTCH+DB2, 03 = BTCH+DLI,
//*        04 = BTCH+DLI+DB2, 05 = BTCH+DLI+DB2+2LK
//*        04 = BTCH+DLI+DB2, 05 = BTCH+DLI+DB2+2LK
//*        06 = (BTCH+XDLI OU BTCH+SUPR)
//*        07= (BTCH+XDLI+DB2 OU BTCH+SUPR+DB2)
//*       CICS SANS INTERTEST
//*        11 = CICS, 12 = CICS+DB2, 13 = CICS+XDLI,
//*        13 = (CICS+XDLI OU CICS+SUPR),
//*        14 = CICS+XDLI+DB2
//*       CICS AVEC INTERTEST TEMPORAIRE (OBSOLETE)
//*        16 = CICS, 17 = CICS+DB2, 18 = CICS+XDLI,
//*        19 = CICS+XDLI+DB2
//*       CICS AVEC INTERTEST PERMANENT  (OBSOLETE)
//*        21 = CICS, 22 = CICS+DB2, 23 = CICS+XDLI,
//*        24 = CICS+XDLI+DB2
//*   OO : OPTIONS DE COMPILATION
//*       OPTIONS GENERALES SANS DISTINCTION PARTICULIERES MAIS
//*       AVEC PRE-COMPILE DYNAMIQUE
//*        GO = OPTIONS STANDARDS ET PRE-COMPILE DYNAMIQUE
//*        G1 = G0 + DATA24
//*        G2 = G0 + G1 + AMODE24
//*        G3 = G0 + AMODE24
//*       OPTIONS POUR PRE-COMPILE NON DYNAMIQUE
//*        NO = OPTIONS STANDARDS
//*        N1 = N0 + DATA24
//*        N2 = N0 + N1 + AMODE24
//*        N3 = N0 + AMODE24
//*
//* TABLEAU DES CARACTERISTIQUES DES PROCESSEURS GROUPE
//*   SELON LA NORME RETENUE, LE TABLEAU QUI SUIT DONNE LA LISTE DES
//*   PROCESSEURS GROUPE ENVISAGEABLES. POUR CHAQUE PROCESSEUR GROUPE
//*   LA COLONNE "EXIST" INDIQUE S'IL N'EXISTE PAS (NON), S'IL
//*   N'EXISTERA JAMAIS (ALL N), S'IL CONCERNE INTERTEST (ITST) ET
//*   DONC N'EXISTE PAS NON PLUS (XPEDITEUR GENERALISE SOUS CICS)
//*   POUR CHAQUE CARACTERISTIQUE :
//*   BTC, CIC, DB2, (XDL OU SUP), DLI, LK2, ITT, ITP
//*   LA VALEUR EST Y (OUI) OU N (NON)
//*   SI TOUS LES CARACTERISTIQUES D'UN PROCESSEUR GROUPE SONT N,
//*   ALORS CE PROCESSEUR GROUPE N'EST PAS UTILISE (EXEMPLE CC=10)
//*   CE TABLEAU DE DECISION EST UTILISE PAR LE PROCESSEUR.
//*   LA PARTIE NUMERIQUE DU PROCESSEUR GROUPE EST L'INDICE DU
//*   TABLEAU.
//*
//*   ****************************************************
//*   *            LISTE DES GROUPES DE PROCESSEUR       *
//*   *  PROC  *EXIST*DYN*BTC*CIC*DB2*XDL*DLI*LK2*   *   *
//*   *  GRP   *     *   *   *   *   *SUP*   *   *   *   *
//*   *--------+-----+---+---+---+---+---+---+---+---+---*
//*   * CE01.. *     * . * Y * N * N * N * N * N * N * N *
//*   * CE02.. *     * . * Y * N * Y * N * N * N * N * N *
//*   * CE03.. * NON * . * Y * N * N * N * Y * N * N * N *
//*   * CE04.. * NON * . * Y * N * Y * N * Y * N * N * N *
//*   * CE05.. *     * . * Y * N * Y * N * Y * Y * N * N *
//*   * CE06.. *     * . * Y * N * N * Y * N * N * N * N *
//*   * CE07.. *     * . * Y * N * Y * Y * N * N * N * N *
//*   * CE08.. *ALL N* . * N * N * N * N * N * N * N * N *
//*   * CE09.. *ALL N* . * N * N * N * N * N * N * N * N *
//*   * CE10.. *ALL N* . * N * N * N * N * N * N * N * N *
//*   * CE11.. *     * . * N * Y * N * N * N * N * N * N *
//*   * CE12.. *     * . * N * Y * Y * N * N * N * N * N *
//*   * CE13.. *     * . * N * Y * N * Y * N * N * N * N *
//*   * CE14.. *     * . * N * Y * Y * Y * N * N * N * N *
//*   * CE15.. *ALL N* . * N * N * N * N * N * N * N * N *
//*   * CE16.. * FR1 * . * N * Y * N * N * N * N * Y * N *
//*   * CE17.. * FR1 * . * N * Y * Y * N * N * N * Y * N *
//*   * CE18.. * FR1 * . * N * Y * N * Y * N * N * Y * N *
//*   * CE19.. * FR1 * . * N * Y * Y * Y * N * N * Y * N *
//*   * CE20.. *ALL N* . * N * N * N * N * N * N * N * N *
//*   * CE16.. * FR2 * . * N * Y * N * N * N * N * N * Y *
//*   * CE17.. * FR2 * . * N * Y * Y * N * N * N * N * Y *
//*   * CE18.. * FR2 * . * N * Y * N * Y * N * N * N * Y *
//*   * CE19.. * FR2 * . * N * Y * Y * Y * N * N * N * Y *
//*   * CE.... *     * . * . * . * . * . * . * . * . * . *
//*
//*
//GCB3A    PROC @@@DSC1='DESCRIPTIF DU PROCESSEUR GROUPE',
//              @@@DSC2='SUITE DESCRIPTIF               ',
//*
//*         VARIABLES GLOBALES (COMMENCENT PAR "@")
//          @@BASEB='SYB&C1STGID.',    *** ALIAS BASE
//          @@BASEC='SYC&C1STGID.',    *** ALIAS CUSTO
//          @@CLI=&C1ENVMNT(1,1),      *** CODE CLIENT : C OU E OU G
//***       DUREE DESACTIVATION : TEMPORAIRE (MAINTENANCE PROCESSEUR)
//          @@DISMSG='PERMANENTE (SAUF JEU DESSAI)',
//***       AUTRES VALEURS PGRDIS : T (TEMPORAIRE), P (PERMANENTE)
//          @@PGRDIS='N',              ** "N" -> PROC GROUPE ENABLE
//          @@PRTSQL='N',              *** FORCE PRINT SYSOUT SQL
//          @@PRTTRN='N',              *** FORCE PRINT SYSOUT TRN
//          @@TYP=&C1TY(4,4),          *** BTCH OU CICS OU PSTK OU SUBR
//***       TABLE POUR DETERMINER CONTEXTE SELON PROCESSEUR GROUPE
//***       LE PROC GROUPE SERT D'INDEX DE CHAQUE TABLE (Y=YES, N=NON)
//          @#IDXTAB=&C1PRGRP(3,2),
//          @@TAB@@@='NE PAS OVERRIDER LES TAB*',
//          @@TABBTC='YYYYYYYNNNNNNNNNNNNNNNNN',   CONTXT BATCH
//          @@TABCIC='NNNNNNNNNNYYYYNYYYYNYYYY',   CONTXT CICS
//          @@TABDB2='NYNYYNYNNNNYNYNNYNYNNYNY',   CONTXT DB2
//          @@TABXDL='NNNNNYYNNNNNYYNNNYYNNNYY',   CONTXT XDLI/SUPRA
//          @@TABDLI='NNYYYNNNNNNNNNNNNNNNNNNN',   CONTXT DLI BATCH
//          @@TABLK2='NNNNYNNNNNNNNNNNNNNNNNNN',   CONTXT 2 LINK-EDIT
//          @@TABFR1='NNNNNNNNNNNNNNNNNNNNNNNN',   CONTXT LIBRE 1
//          @@TABFR2='NNNNNNNNNNNNNNNNNNNNNNNN',   CONTXT LIBRE 2
//*   *     §-------------------------------------------------*
//*   *     § SOUS CICS IL EST PREVU DE NE PLUS UTILISER      *
//*   *     § INTERTEST. ITT ET ITP SONT DONC PARTOUT A "N"   *
//*   *     § ON INDIQUE ICI LES VALEURS POUR ITT ET ITP POUR *
//*   *     § LE CAS OU INTERTEST SERAIT A NOUVEAU UTILISE.   *
//*   *     @@TABFR1='NNNNNNNNNNNNNNNYYYYNNNNN',   CONTXT INTRTST TEMP
//*   *     @@TABFR2='NNNNNNNNNNNNNNNNNNNNYYYY',   CONTXT INTRTST PERM
//          @BTC=&@@TABBTC(&@#IDXTAB,1),
//          @CIC=&@@TABCIC(&@#IDXTAB,1),
//          @DB2=&@@TABDB2(&@#IDXTAB,1),
//          @DLI=&@@TABDLI(&@#IDXTAB,1),
//          @LK2=&@@TABLK2(&@#IDXTAB,1),
//          @XDL=&@@TABXDL(&@#IDXTAB,1),
//          @ZIADMO='LIENV',     OVERRIDE ALIAS STAGE 2 IADM
//          @ZIADM2='LIENV',     ALIAS STAGE 2 IADM
//          @ZPGR3@6=&C1PRGRP(3,4),      SUFFIX PROCESSEUR GROUPE
//          @ZQ='"',                     POUR AJOUT " EN SYSIN
//          @ZSRC5@8=&C1ELEMENT(5,4),    SOURCE DU JEU D'ESSAI ?
//          @ZLST='&C1STGID.&@@CLI.ENV.ENDV.&@@TYP.LIST.&C1SY.',
//          @ZSYSOUT='*',
//*
//*         VARIABLES COMPUWARE-ABENDAID (COMMENCENT PAR "ABN")
//          ABN@VAR='//*-.- VARIABLES POUR COMPUWARE-ABENDAID -.-',
//*         -> CONSTANTES DE LA PARTITION BCP2 (GCONS PROD)
//          ABN1BCP2='&C1STGID.&@@CLI.ENV',    HLQ1 DDIO BCP2
//          ABN5BCP2='&C1SY',                  HLQ5 DDIO BCP2
//*         -> CONSTANTES DE LA PARTITION TECE (GCONS TECE)
//*            UN SEUL DDIO SUR TECE           DSN DDIO CMPWARE
//          ABN1TECE='SIENV',                  HLQ1 DDIO TECE
//          ABN5TECE='I',                      HLQ5 DDIO TECE
//*         -> VARIABLES TOUTE PARTITION
//          ABNHLQ1=&ABN1&C1SYSID..,  HLQ1 DSN DDIO (BCP2/TECE)
//          ABNHLQ34='MLX&@@TYP..SHRDIREC',
//          ABNHLQ5=&ABN5&C1SYSID..,  HLQ5 DSN DDIO (BCP2/TECE)
//          ABNDDIOF='&ABNHLQ1..ENDV.&ABNHLQ34..&ABNHLQ5',
//          ABNLIB='&ZOSSYB..MLCX.SLCXLOAD', *** CSS LOADLIB
//          ABNDPGM='CWPCMAIN',               *** NOM DU COMPILATEUR
//*         'IGYCRCTL' EST LE NOM DU COMPILATEUR IBM COBOL3
//*
//          CEELKED='CEE.SCEELKED',   LANGAGE ENVIRONNEMENT (LE)
//*
//*         VARIABLES CICS     (COMMENCENT PAR "CI")
//*         POUR LE NIVEAU CICS TS (220) ET COBOL (340), CBL XOPTS(
//*         N'EST PAS DISPONIBLE EN COMPILATION DYNAMIQUE.
//*         MSG=IGYOS4003-E   INVALID OPTION "XOPTS('DLI
//*         METTRE CBL CICS('... IMPLIQUE OPTION NODYNAM QUI N'EST PAS
//*         SOUHAITABLE EN BATCH AVEC EXEC DLI.
//*         UN PGM BATCH AVEC EXEC DLI UTILISERA LE TRANSLATEUR
//*         CICS NON INTEGRE.
//*         NOTE THAT THE COBOL COMPILER RECOGNIZES ONLY THE KEYWORD
//*         CICS FOR DEFINING TRANSLATOR OPTIONS, NOT THE ALTERNATIVE
//*         OPTIONS XOPT OR XOPTS AS IN THE CASE OF THE STAND-ALONE
//*         TRANSLATOR SUPPLIED WITH CICS TS.
//*         AUCUNE EVOLUTION EN CICS TS 320 INCIDENT 81530 DU 010208
//          CI@VAR='//*-.- VARIABLES POUR CICS -.-',
//        CICLKINC='&@@BASEB..CTS.SDFHSAMP.&@@CLI.&CICPX.', LKD CPYDSN
//        CICLKMBR='DFHEILID',                             LKD CPYMBR
//          CICPX='0',                    *** COMPLEXE CICS
//          CICS='CICS',   CICS SI CICS, SPACE SI XDLI ET BATCH
//          CICSLOAD='&@@BASEB..CTS.SDFHLOAD.&@@CLI.&CICPX.', LOD CICS
//          CITRNGRP='',                COMPLEMENT DE TRNOPT
//          CITRNOP1='SP,DLI,COBOL3,NOSEQ',
//          CITRNOPT='&CITRNOP1,&CITRNGRP.',
//          CITRNRM1='XDLOP1, XCIOP1 : MODELE OVERRIDE CITRNOP1 SI',
//          CITRNRM2='MODULE AVEC EXEC DLI OU EXCI',
//          CIXCIOP1='EXCI,COBOL3,NOSEQ',
//          CIXCIOPT='(''&CIXCIOP1,&CITRNGRP.'')',
//          CIXDLOP1='DLI,COBOL3,NOSEQ,NOEDF,NOLINKAGE',
//          CIXDLOPT='&CIXDLOP1,&CITRNGRP.',
//*
//*         VARIABLES COMPILATION CB3 (COMMENCENT PAR "CO")
//          CO@VAR='//*-.- VARIABLES POUR CB3 -.-',
//          COBASFM='&ZOSSYC..ASF.COBMAC',                 *** ASF
//          COBCICM='&@@BASEB..CTS.SDFHCOB.&@@CLI.&CICPX.', *** CICS
//          COBLIB='IGY.SIGYCOMP',       COBOL ENTERPRISE
//          COBODMM='&@@BASEB..ODM.SHBRCOBC', COPYBOOK ODM
//          COBODEV='',                  OPTION POUR STAGE LIKE DEVL
//          COBOGRP=',',                         COMPLEMENT DE COBOPT1
//          COBOPT1='APOST,ARITH(E),CP(297),MAP,&COBOGRP,SIZE(8000K)',
//          COBOPT2='NODYNAM,NOFASTSRT,NOOPT',
//          COBPRNTM='&@@BASEB..PRINT.COPY.&@@CLI.', *** PRINT MA.
//          COBSHDM='&ZOSSYB..SHADOW.SAMP',          *** SHADOW
//          COB3DYN='Y',    PRE-COMPILE DYNAMIQUE
//          COB3PGM='IGYCRCTL', NOM DU COMPILATEUR COBOL3 NATIF
//          COCPSTG0='//*-.- SYSLIB CB3 : CONCATENATION -.-',
//          COCPSTG1='&C1STGID.&@@CLI.ENV.ENDV.COPYLIB.&C1SY.',
//          COCPSTG2='&C1STGID2.&@@CLI.ENV.ENDV.COPYLIB.&C1SY.',
//*         COMPLEMENT USER SYSLIB COBOL
//          COCPUSR1='SYS1.VIDE.BSCOS39S',
//          COCPUSR2='SYS1.VIDE.BSCOS39S',
//          COCPUSR3='SYS1.VIDE.BSCOS39S',
//          COINSTG1='&C1STGID.&@@CLI.ENV.ENDV.INCLUDE.&C1SY.',
//          COINSTG2='&C1STGID2.&@@CLI.ENV.ENDV.INCLUDE.&C1SY.',
//          COMPILER=&ABNDPGM,
//          COSTGPCP='P&@@CLI.ENV.ENDV.COPYLIB.&C1SY.',
//          COSTGRCP='R&@@CLI.ENV.ENDV.COPYLIB.&C1SY.',
//          COSTGPIN='P&@@CLI.ENV.ENDV.INCLUDE.&C1SY.',
//          COSTGRIN='R&@@CLI.ENV.ENDV.INCLUDE.&C1SY.',
//*
//*         VARIABLES DB2      (COMMENCENT PAR "DB2")
//          DB2@@VAR='//*-.- VARIABLES POUR DB2 -.-',
//*         -> CONSTANTES DE LA PARTITION BCP2 (GCONS PROD)
//          DB2BCP2V=&DB2NAME., DB2ID STG='V' LPAR='BCP2'
//          DB2BCP2F=&DB2NAME., DB2ID STG='F' LPAR='BCP2'
//          DB2BCP2R=&DB2NAME., DB2ID STG='R' LPAR='BCP2'
//          DB2BCP2O=&DB2NAME., DB2ID STG='O' LPAR='BCP2'
//          DB2BCP2P=&DB2NAME., DB2ID STG='P' LPAR='BCP2'
//          DB2BCP2J=&DB2NAME., DB2ID STG='J' LPAR='BCP2'
//          DB2BCP2Z=&DB2NAME., DB2ID STG='Z' LPAR='BCP2'
//          DB2BBCP2=&@@BASEB., ALIAS SYB- POUR DB2 LPAR='BCP2'
//          DB2CBCP2=&@@BASEC., ALIAS SYC- POUR DB2 LPAR='BCP2'
//*         -> CONSTANTES DE LA PARTITION TECE (GCONS TECE)
//          DB2TECEV=D00S,     DB2ID STG='V' LPAR='TECE'
//          DB2TECEF=D00S,     DB2ID STG='F' LPAR='TECE'
//          DB2TECER=D00S,     DB2ID STG='R' LPAR='TECE'
//          DB2TECEO=D00S,     DB2ID STG='O' LPAR='TECE'
//          DB2TECEP=D00S,     DB2ID STG='P' LPAR='TECE'
//          DB2TECEJ=D00S,     DB2ID STG='J' LPAR='TECE'
//          DB2TECEZ=D00S,     DB2ID STG='Z' LPAR='TECE'
//          DB2BTECE=SYBS,     ALIAS SYB- POUR DB2 LPAR='TECE'
//          DB2CTECE=SYCS,     ALIAS SYC- POUR DB2 LPAR='TECE'
//*         -> VARIABLES TOUTE PARTITION
//          DB2@VERS='VERSION(&C1FOOTPRT(48,16))',  POUR PACKAGE DB2
//          DB2SYB=&DB2B&C1SYSID..,  ALIAS SYB- POUR DB2
//          DB2SYC=&DB2C&C1SYSID..,  ALIAS SYC- POUR DB2
//          DB2DCLG='&C1SI.&@@CLI.ENV.DCLGEN.&DB2ID..&C1SY.',
//          DB2EXIT='&DB2SYC..DB2.SDSNEXIT.&DB2ID.',  *** DB2 EXIT
//          DB2ID=&DB2&C1SYSID&C1SI..,  DB2ID POUR STAGE-LPAR
//          DB2LOAD='&DB2SYB..DB2.SDSNLOAD.&DB2ID.',  *** DB2 LOAD
//***       DB2PTFS='SYSB.DB2710A.SDSNLOAD.PTF',  *** TEMP DB2 PTFS
//          DB2NAME='NOM-DU-DB2',
//          DB2OGRP='',                         COMPLEMENT DE DB2OPT
//          DB2OPT='&DB2@VERS,&DB2OPT1,&DB2OGRP.',
//          DB2OPT1='HOST(IBMCOB),SOURCE',
//          DB2RMLB='&C1STGID.&@@CLI.ENV.ENDV.&@@TYP.DBRM.&C1SY.',
//*
//*         VARIABLES IMS      (COMMENCENT PAR "IMS")
//          IMS@@VAR='//*-.- VARIABLES POUR IMS -.-',
//*         -> CONSTANTES DE LA PARTITION BCP2 (GCONS PROD)
//          IMSBCP2V=&IMSNAME, IMSID STG='V' LPAR='BCP2' FUTURE USE
//          IMSBBCP2=&@@BASEB., ALIAS SYB- POUR IMS LPAR='BCP2'
//          IMSCBCP2=&@@BASEC., ALIAS SYC- POUR IMS LPAR='BCP2'
//*         -> CONSTANTES DE LA PARTITION TECE (GCONS TECE)
//          IMSTECEV=IMIS,     IMSID STG='V' LPAR='BCP2' FUTURE USE
//          IMSBTECE=SYBS,     ALIAS SYB- POUR IMS LPAR='TECE'
//          IMSCTECE=SYCS,     ALIAS SYC- POUR IMS LPAR='TECE'
//*         -> VARIABLES TOUTE PARTITION
//          IMSSYB=&IMSB&C1SYSID..,  ALIAS SYB- POUR IMS
//          IMSSYC=&IMSC&C1SYSID..,  ALIAS SYC- POUR IMS
//          IMSNAME='NOM-DE-IMS',            FUTURE USE
//          IMSID=&IMS&C1SYSID&C1SI..,  IMSID POUR STAGE-LPAR FUTURE USE
//*
//*         VARIABLES DU LINKEDIT   (COMMENCENT PAR "L")
//          LKD@VAR='//*-.- VARIABLES POUR LKD -.-',
//          LKDOGRP=',',                         COMPLEMENT DE LKDOPT
//          LKDOPT='MAP,LIST(ALL),&LKDOGRP,OPTIONS=DDLKDOPT',
//          LKDCIC='RENT,RES',
//          LKDBTC='LET,REUS',
//          LOADLIB='&C1STGID.&@@CLI.ENV.ENDV.&@@TYP.LOAD.&C1SY.',
//          LOADLIB2='&C1STGID.&@@CLI.ENV.ENDV.&@@TYP.LOA2.&C1SY.',
//          LKDS@LIB='//*-.- SYSLIB LKD : USR CONCATENATION -.-',
//          LKDSIMS='&IMSSYB..IMS.RESLIB.&C1SY.',       *** IMS
//***       LKDSIMS='&IMSSYB..IMS.SDFSRESL.&C1SY.',   FUTURE USE
//          LKDSLIB1='SYS1.VIDE.BSCOS39L',  COMPLEMENT USER SYSLIB LKD
//          LKDSLIB2='SYS1.VIDE.BSCOS39L',  COMPLEMENT USER SYSLIB LKD
//          LKDSLIB3='SYS1.VIDE.BSCOS39L',  COMPLEMENT USER SYSLIB LKD
//          LKDSLIB4='SYS1.VIDE.BSCOS39L',  COMPLEMENT USER SYSLIB LKD
//          LKDSLIB5='SYS1.VIDE.BSCOS39L',  COMPLEMENT USER SYSLIB LKD
//          LKDSLIB6='SYS1.VIDE.BSCOS39L',  COMPLEMENT USER SYSLIB LKD
//          LKDSLIN0='//*-.- SYSLIN LKD : CONCATENATION -.-',
//          LKDSLIN1='*',    COMPLEMENT USER SYSLIN LKD
//          LKDSLIN2='*',    PERMET D'AJOUTER AU LINKEDIT
//          LKDSLIN3='*',    DES ORDRES SPECIFQUES INCLUDE
//          LKDSLIN4='*',    EN FONCTION DU TYPE DE
//          LKDSLIN5='*',    COMPILATION
//          LKDSLIN6='*',
//          LSTG0LD='//*-.- SYSLIN LKD : NDV CONCATENATION -.-',
//          LSTG2LD='&C1STGID2.&@@CLI.ENV.ENDV.&@@TYP.LOAD.&C1SY.',
//          LSTG2LD2='&C1STGID2.&@@CLI.ENV.ENDV.&@@TYP.LOA2.&C1SY.',
//          LSTGPLD='P&@@CLI.ENV.ENDV.&@@TYP.LOAD.&C1SY.',
//          LSTGPLD2='P&@@CLI.ENV.ENDV.&@@TYP.LOA2.&C1SY.',
//          LSTGRLD='R&@@CLI.ENV.ENDV.&@@TYP.LOAD.&C1SY.',
//          LSTGRLD2='R&@@CLI.ENV.ENDV.&@@TYP.LOA2.&C1SY.',
//*
//*
//*         VARIABLES DE METRIXWARE  (COMMENCENT PAR "M")
//          MTX@VAR='//*-.- VARIABLES POUR METRIXWARE -.-',
//          MTX=Y,     ANALYSE METRIXWARE ACTIVE
//          MTXBYETU='PKENV.ENDV.ANALYMTX.BYPASETU',
//          MTXBYSOE='PKENV.ENDV.ANALYMTX.BYPASSOE',
//          MTXINEX='INCL-VERSUS-EXCL', REGLE ANALYSE EXCL OU INCL
//          MTXLEVEL='999999',
//          MTXXMLMB='&C1STGID.&C1ENVMNT(1,1)&C1ELTYPE(4,4)&MTXXMLSU.',
//          MTXXMLSU='00',
//*
//*190313   VARIABLES DE CHANGEMENT PROC GRP (MD*)
//          MDACTIF='NON',
//          MDPDS='V&@@CLI.ENV.ENDV.TABLE.&@@CLI',   DSNAME DU PDS NDV
//          MDMBR='MDPRCGRP',                     NOM MBR DANS 'MDPDS'
//*
//*190313   VARIABLES DE SUIVI DE COMPILATION EN DEV (SV*)
//          SVACTIF='OUI',
//          SVP1='&C1EN &C1SY &C1SU &C1SI &C1ELEMENT &C1TY &C1PRGRP',
//          SVP2='&C1USERID',                               SUITE
//          SVP3='',                                        EXTENSION
//          SVPARM='&SVP1 &SVP2 &SVP3',
//*
//*         VARIABLES ZOS      (COMMENCENT PAR "ZOS")
//*         -> CONSTANTES DE LA PARTITION BCP2 (GCONS PROD)
//          ZOSBBCP2=&@@BASEB., ALIAS SYB- POUR ZOS LPAR='BCP2'
//          ZOSCBCP2=&@@BASEC., ALIAS SYC- POUR ZOS LPAR='BCP2'
//*         -> CONSTANTES DE LA PARTITION TECE (GCONS TECE)
//          ZOSBTECE=SYBS,     ALIAS SYB- POUR ZOS LPAR='TECE'
//          ZOSCTECE=SYCS,     ALIAS SYC- POUR ZOS LPAR='TECE'
//*         -> VARIABLES TOUTE PARTITION
//          ZOSSYB=&ZOSB&C1SYSID..,  ALIAS SYB- POUR ZOS
//          ZOSSYC=&ZOSC&C1SYSID..,  ALIAS SYC- POUR ZOS
//*                 (LAST VARIABLE SANS VIRGULE)
//          ZPRCNAME='NOM DU PROCESSEUR : GCB3A'
//*
//*
//*******************************************************************
//* -> ALLOCATION DES FICHIERS SYSPRINT DU PROCESSEUR
//*    EXEC SI : 1) RC OK
//*******************************************************************
//PREALLOC EXEC PGM=BC1PDSIN,MAXRC=0
//C1INIT00 DD DSN=&&ANOMALI0,DISP=(,PASS,DELETE),
//            UNIT=WORK,SPACE=(CYL,(1,2),RLSE),
//            DCB=(RECFM=FBA,LRECL=121)
//C1INIT01 DD DSN=&&ANOMALI1,DISP=(,PASS,DELETE),
//            UNIT=WORK,SPACE=(CYL,(1,2),RLSE),
//            DCB=(RECFM=FBA,LRECL=121)
//C1INIT02 DD DSN=&&CONTEXT,DISP=(,PASS,DELETE),
//            UNIT=WORK,SPACE=(CYL,(3,2),RLSE),
//            DCB=(RECFM=FBA,LRECL=133)
//C1INIT03 DD DSN=&&SQLLIST,DISP=(,PASS,DELETE),
//            UNIT=WORK,SPACE=(CYL,(1,2),RLSE),
//            DCB=(RECFM=FBA,LRECL=121)
//C1INIT04 DD DSN=&&TRNLIST,DISP=(,PASS,DELETE),
//            UNIT=WORK,SPACE=(CYL,(1,2),RLSE),
//            DCB=(RECFM=FBA,LRECL=121)
//C1INIT05 DD DSN=&&COB0LST,DISP=(,PASS,DELETE),
//            UNIT=WORK,SPACE=(CYL,(3,5),RLSE),
//            DCB=(RECFM=FBA,LRECL=133)
//C1INIT06 DD DSN=&&CWPERRM,DISP=(,PASS,DELETE),
//            UNIT=WORK,SPACE=(CYL,(1,2),RLSE),
//            DCB=(RECFM=FBA,LRECL=133)
//C1INIT07 DD DSN=&&ANOMALI2,DISP=(,PASS,DELETE),
//            UNIT=WORK,SPACE=(CYL,(1,2),RLSE),
//            DCB=(RECFM=FBA,LRECL=121)
//C1INIT08 DD DSN=&&LKD1LST,DISP=(,PASS,DELETE),
//            UNIT=WORK,SPACE=(CYL,(1,2),RLSE),
//            DCB=(RECFM=FBA,LRECL=121,BLKSIZE=4840)
//C1INIT09 DD DSN=&&LKD2LST,DISP=(,PASS,DELETE),
//            UNIT=WORK,SPACE=(CYL,(1,2),RLSE),
//            DCB=(RECFM=FBA,LRECL=121,BLKSIZE=4840)
//C1INIT10 DD DSN=&&DPKMSGS,DISP=(,PASS,DELETE),
//            UNIT=WORK,SPACE=(CYL,(1,2),RLSE),
//            DCB=(LRECL=133,RECFM=FBA)
//C1INIT12 DD DSN=&&PRTOPT,DISP=(,PASS,DELETE),
//            UNIT=WORK,SPACE=(CYL,(1,2),RLSE),
//            DCB=(LRECL=133,RECFM=FBA)
//C1INIT13 DD DSN=&&IFMTXOUT,DISP=(,PASS,DELETE),
//            UNIT=WORK,SPACE=(CYL,(1,2),RLSE),
//            DCB=(LRECL=133,RECFM=FBA)
//C1INIT14 DD DSN=&&TRACE01,DISP=(,PASS,DELETE),
//            UNIT=WORK,SPACE=(CYL,(1,2),RLSE),
//            DCB=(RECFM=FBA,LRECL=121)
//C1INIT15 DD DSN=&&MDPRMSG,DISP=(,PASS,DELETE),          MODIF PRCGRP
//            UNIT=WORK,SPACE=(CYL,(1,2),RLSE),
//            DCB=(LRECL=133,RECFM=FBA)
//C1INIT16 DD DSN=&&INFOCPL,DISP=(,PASS,DELETE),          INFOR COMPIL
//            UNIT=WORK,SPACE=(CYL,(1,2),RLSE),
//            DCB=(LRECL=133,RECFM=FBA)
//*
//*******************************************************************
//* -> EMISSION MESSAGE TRACE JEU D'ESSAI
//*    . SI PROCESSEUR GROUPE DESACTIVE ET SOURCE DU JEU D'ESSAI
//*    ON DESACTIVE UN PROCESSEUR GROUPE POUR NE PLUS L'UTILISER
//*    EXEC SI : 1) RC OK
//*              2) @@PGRDIS=P  POUR LE PROCESSEUR GROUPE (PERM)
//*                 ET SOURCE JEU D'ESSAI
//*-------------------------------------------------------------------
//CTLEXEC  IF RC  LE  00  THEN
//IF_TST1  IF (&@@PGRDIS = P AND &@ZPGR3@6 = &@ZSRC5@8)  THEN
//TRACE01  EXEC PGM=IEBGENER,MAXRC=00
//SYSUT2   DD DISP=(OLD,PASS),DSN=&&TRACE01
//SYSPRINT DD SYSOUT=Z
//SYSIN    DD DUMMY
//SYSUT1   DD *
  LE PROCESSEUR GROUPE  &C1PRGRP  BIEN QUE DESACTIVE ACTUELLEMENT
  RESTE OPERATIONNEL POUR LE SOURCE '&C1ELEMENT' DU JEU D'ESSAI.
/*
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//*******************************************************************
//* -> EMISSION MESSAGE
//*    . SI PROCESSEUR GROUPE DESACTIVE
//*    ON DESACTIVE UN PROCESSEUR GROUPE POUR NE PLUS L'UTILISER
//*    EXEC SI : 1) RC OK
//*              2) @@PGRDIS=P  POUR LE PROCESSEUR GROUPE (PERM)
//*                 (SAUF SOURCE JEU D'ESSAI)
//*              3) @@PGRDIS=T  POUR LE PROCESSEUR GROUPE (TEMP)
//*              4) UN CONTEXTE PARTICULIER
//*                 BTC=Y ET XDL=Y ET COB3DYN=Y (XOPTS NON DISPONIBLE)
//*-------------------------------------------------------------------
//CTLEXEC  IF RC  LE  00  THEN
//IF_TST1  IF (&@@PGRDIS = P AND &@ZPGR3@6 NE &@ZSRC5@8)  OR
//            (&@@PGRDIS = T)  OR
//            (&@BTC = Y AND &@XDL = Y AND &COB3DYN = Y) THEN
//ANOMALI0 EXEC PGM=IEBGENER,MAXRC=00
//SYSUT2   DD DISP=(OLD,PASS),DSN=&&ANOMALI0
//SYSPRINT DD SYSOUT=Z
//SYSIN    DD DUMMY
//SYSUT1   DD *
  LE PROCESSEUR GROUPE  &C1PRGRP  EST DESACTIVE ACTUELLEMENT.
  DESACTIVATION &@@DISMSG
/*
//EL-TST1  ELSE
//CONTINU0 EXEC PGM=IEFBR14
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//*******************************************************************
//* -> ARRET DU PROCESSEUR SI MESSAGE EMIS
//* ON FORCE LE CODE RETOUR A 12 POUR TOUT ARRETER                  *
//*******************************************************************
//CTLEXEC  IF ANOMALI0.RC  GE  0  THEN
//FORCECR0 EXEC PGM=BR15,PARM='0012',MAXRC=00
//STEPLIB  DD DISP=SHR,DSN=SYS1.LOADBIB
//ENDCTL   ENDIF
//*
//*******************************************************************
//* -> EMISSION MESSAGE
//*    . SI PROCESSEUR GROUPE INCONNU
//*    LE PROCESSEUR GCB3A UTILISE DES TABLES DE CONTEXTE (TABCIC,
//*    TABDB2, ...) POUR CONNAITRE LES CARACTERISTIQUES DU PROCESSEUR
//*    GROUPE. SI LE PROCESSEUR GROUPE UTILISE N'EST NI BATCH (N DANS
//*    TABBTC) NI CICS (N DANS TABCIC) ALORS C'EST UNE ERREUR.
//*    (CAUSE PROPBABLE : CREATION D'UN NOUVEAU PROCESSEUR GROUPE SANS
//*     MODIFICATION DU PROCESSEUR.)
//*    EXEC SI : 1) RC OK
//*              2) CIC=N ET BTC=N
//*-------------------------------------------------------------------
//CTLEXEC  IF RC  LE  00  THEN
//IF_TST1  IF ((&@CIC = Y AND &@BTC = N)   OR
//             (&@CIC = N AND &@BTC = Y))  AND
//            (&@#IDXTAB NE '00')  THEN
//CONTINU1 EXEC PGM=IEFBR14
//EL-TST1  ELSE
//ANOMALI1 EXEC PGM=IEBGENER,MAXRC=00
//SYSUT2   DD DISP=(OLD,PASS),DSN=&&ANOMALI1
//SYSPRINT DD SYSOUT=Z
//SYSIN    DD DUMMY
//SYSUT1   DD *
  LE PROCESSEUR GROUPE  &C1PRGRP  EST INVALIDE POUR LE PROCESSEUR GCB3A.
/*
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//*******************************************************************
//* -> ARRET DU PROCESSEUR SI MESSAGE EMIS
//* ON FORCE LE CODE RETOUR A 12 POUR TOUT ARRETER                  *
//*******************************************************************
//CTLEXEC  IF ANOMALI1.RC  GE  0  THEN
//FORCECR1 EXEC PGM=BR15,PARM='0012',MAXRC=00
//STEPLIB  DD DISP=SHR,DSN=SYS1.LOADBIB
//ENDCTL   ENDIF
//*
//********************************************************************
//* -> INDICATION DU CONTEXTE DE COMPILATION DU SOURCE
//*    EXEC SI : 1) RC OK
//*-------------------------------------------------------------------
//CTLEXEC  IF RC = 00 THEN
//CONTEXT  EXEC PGM=IEBGENER,MAXRC=0
//SYSUT2   DD DISP=(OLD,PASS),DSN=&&CONTEXT
//SYSPRINT DD SYSOUT=Z
//SYSIN    DD DUMMY
//*        ...........................................................
//*        . CONTEXTE DE COMPILATION SOURCE SELON PROCESSEUR GROUPE  .
//*        -> PRECOMPILE DYNAMIQUE  = OUI                            .
//*        -> PRECOMPILE DYNAMIQUE  = NON                            .
//*        -> BATCH = OUI ET CONTEXTE (DB2, DLI, XDLI, LK2)          .
//*        -> CICS  = OUI ET CONTEXTE (DB2, XDLI, INTERTEST)         .
//*        -> OVERRIDES OPTIONS SQL                                  .
//*        -> OVERRIDES OPTIONS TRN                                  .
//*        -> OVERRIDES OPTIONS COMPILE ET LINK-EDIT                 .
//*        ...........................................................
//SYSUT1   DD *
 -> LE COMMENTAIRE DESCRIPTIF DU PROCESSEUR GROUPE UTILISE EST
    @@@DSC1= &@ZQ.&@@@DSC1.&@ZQ
    @@@DSC2= &@ZQ.&@@@DSC2.&@ZQ
 -> LE CALCUL PAR LE PROCESSEUR DU CONTEXTE DE COMPILATION DU SOURCE
    '&C1ELEMENT' EST LE SUIVANT :
       TYPE=&C1ELTYPE, PROCESSEUR GROUP=&C1PRGRP AVEC
       UNE VALEUR DE IDXTAB = &@ZQ.&@#IDXTAB.&@ZQ
/*
//IF_TST1  IF &COB3DYN = Y    THEN
//*        -> PRECOMPILE DYNAMIQUE  = OUI                            .
//         DD *
  . UNE PRE-COMPILATION CICS/DB2 DYNAMIQUE AVEC COBOL (SI CICS/DB2) DYN=Y
/*
//ND-TST1  ENDIF
//IF_TST1  IF &COB3DYN = N    THEN
//*        -> PRECOMPILE DYNAMIQUE  = NON                            .
//         DD *
  . UNE PRE-COMPILATION CICS/DB2 NON DYNAMIQUE AVEC COBOL (SI CICS/DB2) DYN=N
/*
//ND-TST1  ENDIF
//IF_TST1  IF &@BTC = Y    THEN
//*        -> BATCH = OUI ET CONTEXTE (DB2, DLI, XDLI, LK2)          .
//         DD *
    LES CARACTERISTIQUES SUIVANTES POUR LE MODULE :
     BATCH=&@BTC, CICS=&@CIC,
     DB2=&@DB2, XDLI=&@XDL, DLI=&@DLI, "2 LINK-EDIT"=&@LK2
/*
//ND-TST1  ENDIF
//IF_TST1  IF &@CIC = Y     THEN
//*        -> CICS  = OUI ET CONTEXTE (DB2, XDLI, INTERTEST)         .
//         DD *
    LES CARACTERISTIQUES SUIVANTES POUR LE MODULE :
     CICS=&@CIC, BATCH=&@BTC,
     DB2=&@DB2, XDLI=&@XDL, DLI=&@DLI, "2 LINK-EDIT"=&@LK2
/*
//ND-TST1  ENDIF
//IF_TST1  IF &@DB2 = Y   THEN
//*        -> OVERRIDES OPTIONS SQL                                  .
//         DD *
     AVEC OVERRIDES OPTIONS SQL
          DB2OPT  = &@ZQ.&DB2OPT.&@ZQ
/*
//ND-TST1  ENDIF
//IF_TST1  IF &@CIC = Y OR &@XDL = Y   THEN
//*        -> OVERRIDES OPTIONS TRN                                  .
//         DD *
     AVEC OVERRIDES OPTIONS TRN
          CITRNOPT = &@ZQ.&CITRNOPT.&@ZQ
/*
//ND-TST1  ENDIF
//*        -> OVERRIDES OPTIONS COMPILE ET LINK-EDIT                 .
//         DD *
     AVEC OVERRIDES OPTIONS COMPILE
          COBOGRP = &@ZQ.&COBOGRP.&@ZQ
          COBODEV = &@ZQ.&COBODEV.&@ZQ
     AVEC OVERRIDES OPTIONS LINK-EDIT
          LKDOGRP = &@ZQ.&LKDOGRP.&@ZQ
/*
//IF_TST1  IF &@CIC = Y     THEN
//*        -> CICS  = OUI                                            .
//         DD *
          LKDCIC  = &@ZQ.&LKDCIC.&@ZQ
/*
//ND-TST1  ENDIF
//IF_TST1  IF &@BTC = Y     THEN
//*        -> BATCH = OUI                                            .
//         DD *
          LKDBTC  = &@ZQ.&LKDBTC.&@ZQ
/*
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//********************************************************************
//* -> EXTRACTION DU SOURCE ET EXPANSION DES ++INCLUDES
//*    EXEC SI : 1) RC OK
//********************************************************************
//CTLEXEC  IF RC = 00 THEN
//CONWRITE  EXEC PGM=CONWRITE,PARM='EXPINCL(Y)',MAXRC=0
//C1INCL01  DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COINSTG1
//C1INCL02  DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COCPSTG1
//C1INCL03  DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COINSTG2
//C1INCL04  DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COCPSTG2
//C1INCL05  DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COSTGRIN
//C1INCL06  DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COSTGRCP
//C1INCL07  DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COSTGPIN
//C1INCL08  DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COSTGPCP
//ELMOUT    DD MONITOR=COMPONENTS,DISP=(,PASS),DSN=&&ELMOUT,
//             SPACE=(CYL,(3,1),RLSE),UNIT=WORK,
//             DCB=(RECFM=FB,LRECL=80)
//ENDCTL   ENDIF
//*
//********************************************************************
//* -> PREPARATION DES OPTIONS DE COMPILATION CICS ET DB2
//*    AJOUT EN TETE DU SOURCE DES OPTIONS DE COMPILATION
//*    PRINT IDCAMS DE L'AJOUT
//*    EXEC SI : 1) RC OK
//*              2) PRE-COMPILATION CICS/DB2 DYNAMIQUE
//*              3) CICS OU DB2 OU XDLI
//*-------------------------------------------------------------------
//CTLEXEC  IF RC = 00 THEN
//*        ...........................................................
//*        . CONDITIONS D'AJOUT                                      .
//*        -> PRECOMPILE DYNAMIQUE  = OUI                            .
//*        -> DB2 = OUI ET (CICS OU XDLI = OUI)                      .
//*        -> DB2 = OUI ET (CICS OU XDLI = NON)                      .
//*        -> DB2 = NON ET (CICS OU XDLI = OUI)                      .
//*        ...........................................................
//*        -> PRECOMPILE DYNAMIQUE  = OUI                            .
//IF_TST1  IF &COB3DYN = Y  AND
//            (&@CIC = Y  OR
//             &@DB2 = Y  OR
//             &@XDL = Y) THEN
//*        -> CICS OU DB2 OU XDLI = OUI                              .
//* ---> AJOUT DES OPTIONS DE COMPILATION                            .
//GNOPTION EXEC PGM=IEBGENER,MAXRC=0
//SYSPRINT DD SYSOUT=Z
//SYSIN    DD DUMMY
//SYSUT2   DD MONITOR=COMPONENTS,DISP=(,PASS),DSN=&&ELMNEW,
//            SPACE=(CYL,(3,1),RLSE),UNIT=WORK,
//            DCB=(RECFM=FB,LRECL=80)
//IF_TST2  IF (&@DB2 = Y) AND
//            (&@CIC = Y  OR
//             &@XDL = Y) THEN
//*        -> DB2 = OUI ET (CICS OU XDLI = OUI)                      .
//SYSUT1   DD *
CBL SQL(&@ZQ.&DB2OPT.&@ZQ)
CBL CICS(&@ZQ.&CITRNOPT.&@ZQ)
/*
//         DD DISP=(OLD,DELETE,DELETE),DSN=&ELMOUT
//ND-TST2  ENDIF
//IF_TST2  IF (&@DB2 = Y) AND
//            (&@CIC = N  OR
//             &@XDL = N) THEN
//*        -> DB2 = OUI ET (CICS OU XDLI = NON)                      .
//SYSUT1   DD *
CBL SQL(&@ZQ.&DB2OPT.&@ZQ)
/*
//         DD DISP=(OLD,DELETE,DELETE),DSN=&ELMOUT
//ND-TST2  ENDIF
//IF_TST2  IF (&@DB2 = N) AND
//            (&@CIC = Y  OR
//             &@XDL = Y) THEN
//*        -> DB2 = NON ET (CICS OU XDLI = OUI)                      .
//SYSUT1   DD *
CBL CICS(&@ZQ.&CITRNOPT.&@ZQ)
/*
//         DD DISP=(OLD,DELETE,DELETE),DSN=&ELMOUT
//ND-TST2  ENDIF
//* ---> PRINT IDCAMS DE L'AJOUT                                     .
//PRTOPT   EXEC PGM=IDCAMS,MAXRC=0
//SYSPRINT DD DSN=&&PRTOPT,DISP=(OLD,PASS)
//ENTREE   DD DISP=(OLD,PASS),DSN=&&ELMNEW
//SYSIN    DD *
  PRINT INFILE(ENTREE) CHAR                                      -
        COUNT (004)
/*
//EL-TST1  ELSE
//NOGNOPT  EXEC PGM=IEFBR14
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//********************************************************************
//* -> PRE-COMPILE DB2
//*    EXEC SI : 1) RC OK
//*              2) PRE-COMPILATION CICS/DB2 NON DYNAMIQUE
//*              3) DB2
//*-------------------------------------------------------------------
//CTLEXEC  IF RC = 00 THEN
//IF_TST1  IF &COB3DYN = N    THEN
//*        -> PRECOMPILE DYNAMIQUE  = NON                            .
//IF_TST2  IF &@DB2 = Y THEN
//*        -> SOURCE DB2 = OUI                                       .
//SQL      EXEC PGM=DSNHPC,MAXRC=4,
//         PARM='&DB2OPT'
//STEPLIB  DD DSN=&DB2EXIT,DISP=SHR
//***      DD DSN=&DB2PTFS,DISP=SHR    *** TEMP PTFS DB2
//         DD DSN=&DB2LOAD,DISP=SHR
//SYSPRINT DD DSN=&&SQLLIST,DISP=(OLD,PASS)
//SYSTERM  DD DUMMY
//SYSUT1   DD UNIT=VIO,SPACE=(TRK,(15,15)),DCB=BUFNO=1
//SYSUT2   DD UNIT=VIO,SPACE=(TRK,(15,15)),DCB=BUFNO=1
//SYSLIB   DD MONITOR=COMPONENTS,DISP=SHR,DSN=&DB2DCLG
//DBRMLIB  DD DSN=&&DBRM(&C1ELEMENT),DISP=(,PASS),
//            UNIT=WORK,SPACE=(CYL,(1,1,1)),
//            DCB=(RECFM=FB,BLKSIZE=80)
//SYSIN    DD DSN=&&ELMOUT,DISP=(OLD,DELETE)
//SYSCIN   DD DSN=&&SYSCIN,DISP=(,PASS),
//            UNIT=VIO,SPACE=(TRK,(15,15)),
//            DCB=(RECFM=FB,LRECL=80,BLKSIZE=8080,BUFNO=1)
//EL-TST2  ELSE
//NODB2N   EXEC PGM=IEFBR14
//ND-TST2  ENDIF
//EL-TST1  ELSE
//IF_TST2  IF &@DB2 = Y THEN
//DB2INCB3 EXEC PGM=IEFBR14
//EL-TST2  ELSE
//NODB2Y   EXEC PGM=IEFBR14
//ND-TST2  ENDIF
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//********************************************************************
//* -> TRANSLATION CICS
//*    EXEC SI : 1) RC OK
//*              2) PRE-COMPILATION CICS/DB2 NON DYNAMIQUE
//*              3) CICS OU XDLI
//*-------------------------------------------------------------------
//CTLEXEC  IF RC  LE  04  THEN
//IF_TST1  IF &COB3DYN = N    THEN
//*        -> PRECOMPILE DYNAMIQUE  = NON                            .
//IF_TST2  IF &@CIC = Y OR
//            &@XDL = Y THEN
//*        -> SOURCE CICS = OUI                                      .
//TRN      EXEC PGM=DFHECP1$,MAXRC=4,
//         PARM='&CITRNOPT'
//STEPLIB  DD DISP=SHR,DSN=&CICSLOAD
//SYSPRINT DD DSN=&&TRNLIST,DISP=(OLD,PASS)
//*        ...........................................................
//*        . LOCALISATION SYSIN CONTENANT LE SOURCE                  .
//*        -> PRECOMPILE DYNAMIQUE  = NON DB2=N       : SYSIN=ELMOUT .
//*        -> PRECOMPILE DYNAMIQUE  = NON DB2=Y       : SYSIN=SYSCIN .
//*        ...........................................................
//IF_TST3  IF &@DB2 = N THEN    (SOURCE FROM ENDEVOR)
//*        -> PRECOMPILE DYNAMIQUE  = NON DB2=N       : SYSIN=ELMOUT .
//SYSIN    DD DSN=&&ELMOUT,DISP=(OLD,DELETE)
//EL-TST3  ELSE                 (SOURCE FROM DSNHPC DB2)
//*        -> PRECOMPILE DYNAMIQUE  = NON DB2=Y       : SYSIN=SYSCIN .
//SYSIN    DD DSN=&&SYSCIN,DISP=(OLD,DELETE)
//ND-TST3  ENDIF
//SYSPUNCH DD DSN=&&SYSPUNCH,DISP=(,PASS),
//            UNIT=VIO,SPACE=(TRK,(15,5)),
//            DCB=(RECFM=FB,BLKSIZE=8080,LRECL=80,BUFNO=1)
//EL-TST2  ELSE
//NOCICSN  EXEC PGM=IEFBR14
//ND-TST2  ENDIF
//EL-TST1  ELSE
//IF_TST2  IF &@CIC = Y THEN
//CICINCB3 EXEC PGM=IEFBR14
//EL-TST2  ELSE
//NOCICSY  EXEC PGM=IEFBR14
//ND-TST2  ENDIF
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//********************************************************************
//* -> COMPILATION COBOL AVEC TRANSLATION CICS, PRE-COMPILE DB2
//*    EXEC SI : 1) RC OK
//*-------------------------------------------------------------------
//CTLEXEC  IF RC LT 05 THEN
//COMPIL   EXEC PGM=&COMPILER,MAXRC=4,
//         PARM='&COBOPT1,&COBOPT2,&COBODEV'
//*        ...........................................................
//*        . LOCALISATION SYSIN CONTENANT LE SOURCE                  .
//*        -> PRECOMPILE DYNAMIQUE  = NON ET CICS : SYSIN=SYSPUNCH   .
//*        -> PRECOMPILE DYNAMIQUE  = NON ET DB2  : SYSIN=SYSCIN     .
//*        -> PRECOMPILE DYNAMIQUE  = NON         : SYSIN=ELMOUT     .
//*        -> PRECOMPILE DYNAMIQUE  = OUI ET CICS/DB2 : SYSIN=ELMNEW .
//*        -> PRECOMPILE DYNAMIQUE  = OUI NOT CICS/DB2: SYSIN=ELMOUT .
//*        ...........................................................
//*        -> PRECOMPILE DYNAMIQUE  = NON => SELECTION DSN DU SOURCE
//IF_TST1  IF &COB3DYN = N  AND
//            (&@CIC = Y OR &@XDL = Y) AND
//            (&@DB2 = Y OR &@DB2 = N) THEN
//*        -> PRECOMPILE DYNAMIQUE  = NON ET CICS : SYSIN=SYSPUNCH   .
//SYSIN    DD DSN=&&SYSPUNCH,DISP=(OLD,PASS)
//ND-TST1       ENDIF
//IF_TST1  IF &COB3DYN = N  AND
//            (&@CIC = N AND &@XDL = N) AND
//            (&@DB2 = Y)  THEN
//*        -> PRECOMPILE DYNAMIQUE  = NON ET DB2 : SYSIN=SYSCIN      .
//SYSIN    DD DSN=&&SYSCIN,DISP=(OLD,PASS)
//ND-TST1       ENDIF
//IF_TST1  IF &COB3DYN = N  AND
//            (&@CIC = N AND &@XDL = N) AND
//            (&@DB2 = N)  THEN
//*        -> PRECOMPILE DYNAMIQUE  = NON       : SYSIN=ELMOUT       .
//SYSIN    DD DSN=&&ELMOUT,DISP=(OLD,PASS)
//ND-TST1       ENDIF
//*        -> PRECOMPILE DYNAMIQUE  = OUI => SELECTION DSN DU SOURCE
//IF_TST1  IF &COB3DYN = Y  AND
//            (&@CIC = Y OR &@XDL = Y  OR
//             &@DB2 = Y)  THEN
//*        -> PRECOMPILE DYNAMIQUE  = OUI ET CICS/DB2 : SYSIN=ELMNEW .
//SYSIN    DD DSN=&&ELMNEW,DISP=(OLD,PASS)
//ND-TST1  ENDIF
//IF_TST1  IF &COB3DYN = Y  AND
//            (&@CIC = N AND &@XDL = N  AND
//             &@DB2 = N)  THEN
//*        -> PRECOMPILE DYNAMIQUE  = OUI NOT CICS/DB2: SYSIN=ELMOUT .
//SYSIN    DD DSN=&&ELMOUT,DISP=(OLD,PASS)
//ND-TST1  ENDIF
//*        ...........................................................
//*        . ALLOCATION DBRMLIB                                      .
//*        -> PRECOMPILE DYNAMIQUE = OUI ET DB2 : ALLOCATION=OUI     .
//*        -> AUTRES CAS                        : ALLOCATION=NON     .
//*        ...........................................................
//IF_TST1  IF &COB3DYN = Y AND &@DB2 = Y THEN
//DBRMLIB  DD DSN=&&DBRM(&C1ELEMENT),DISP=(,PASS),
//            UNIT=WORK,SPACE=(CYL,(1,1,40)),
//            DCB=(RECFM=FB,BLKSIZE=80)
//ND-TST1  ENDIF
//*        ...........................................................
//*        . CONCATENATION SYSLIB                                    .
//*        -> ALL                : SHADOW, ODM                       .
//*        -> CIC=Y              : MACLIB CICS, ASF                  .
//*        -> BTC=Y              : MACLIB PRINT MANAGER              .
//*        -> DB2=Y              : DCLGEN                            .
//*        ...........................................................
//SYSLIB   DD DISP=SHR,DSN=SYS1.VIDE.BSCOS39S
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COCPUSR1
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COCPUSR2
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COCPUSR3
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COBSHDM
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COBODMM
//IF_TST1  IF &@CIC = Y  THEN
//*        -> CIC=Y              : MACLIB CICS, ASF                  .
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COBCICM
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COBASFM
//ND-TST1  ENDIF
//IF_TST1  IF &@BTC = Y THEN
//*        -> BTC=Y              : MACLIB PRINT MANAGER              .
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COBPRNTM
//ND-TST1  ENDIF
//IF_TST1  IF &@DB2 = Y THEN
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&DB2DCLG
//ND-TST1  ENDIF
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COCPSTG1
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COCPSTG2
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COSTGRCP
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&COSTGPCP
//*        ...........................................................
//*        . ALLOCATION SANS CONDITION                               .
//*        ...........................................................
//SYSLIN   DD DSN=&&SYSLIN,DISP=(,PASS),
//            UNIT=VIO,SPACE=(CYL,(1,1),RLSE),
//            DCB=(BLKSIZE=3200,BUFNO=1),FOOTPRNT=CREATE
//SYSPRINT DD DSN=&&COB0LST,DISP=(OLD,PASS)
//STEPLIB  DD DISP=SHR,DSN=&COBLIB      *** COBOL ENTERPRISE
//         DD DISP=SHR,DSN=&ABNLIB      *** CSS COMPUWARE
//         DD DISP=SHR,DSN=&CICSLOAD    *** CICS TS (EXEC CICS + DLI)
//IF_TST1  IF &@DB2 = Y THEN
//         DD DISP=SHR,DSN=&DB2EXIT     *** DB2
//***      DD DISP=SHR,DSN=&DB2PTFS     *** TEMP PTFS DB2
//         DD DISP=SHR,DSN=&DB2LOAD     *** DB2
//ND-TST1  ENDIF
//SYSUT1   DD UNIT=VIO,SPACE=(CYL,(1,1))
//SYSUT2   DD UNIT=VIO,SPACE=(CYL,(1,1))
//SYSUT3   DD UNIT=VIO,SPACE=(CYL,(1,1))
//SYSUT4   DD UNIT=VIO,SPACE=(CYL,(1,1))
//SYSUT5   DD UNIT=VIO,SPACE=(CYL,(1,1))
//SYSUT6   DD UNIT=VIO,SPACE=(CYL,(1,1))
//SYSUT7   DD UNIT=VIO,SPACE=(CYL,(1,1))
//*        ...........................................................
//*        . ACTIVATION COMPUWARE                                    .
//*        -> COMPILATEUR = CWPCMAIN (COMPUWARE) (IGYCRCTL=COBOL3)   .
//*        ...........................................................
//IF_TST1  IF &COMPILER = CWPCMAIN THEN
//*        -> COMPILATEUR = CWPCMAIN (COMPUWARE) (IGYCRCTL=COBOL3)   .
//CWPDDIO  DD DISP=SHR,DSN=&ABNDDIOF
//CWPERRM  DD DSN=&&CWPERRM,DISP=(OLD,PASS)
//CWPWBNV  DD SYSOUT=Z
//SYSOUT   DD SYSOUT=Z  *** SYSOUT DU SORT ***
//*        ...........................................................
//*        . ALLOCATION CWPPRMO POUR COMPUWARE                       .
//*        -> CIC=Y                : DD CWPPRMO SPECIFIQUE CICS      .
//*        -> BTC=Y                : DD CWPPRMO SPECIFIQUE BATCH     .
//*        ...........................................................
//IF_TST2  IF &@CIC = Y  THEN
//*        -> CIC=Y                : DD CWPPRMO SPECIFIQUE CICS      .
//CWPPRMO  DD *
LANGUAGE(COBOLZ/OS)
COBOL(OUTPUT(NOPRINT,NODDIO))
PROCESSOR(OUTPUT(PRINT,DDIO))
PROCESSOR(TEXT(NONE))
PROCESSOR(NOBYPASS)
PROCESSOR(ERRORS(MIXED-CASE))
DDIO(OUTPUT(FIND,COMPRESS,NOLIST))
PRINT(OUTPUT(SOURCE,NOLIST))
CICSTEST(OPTIONS(WARNING))
//ND-TST2  ENDIF
//IF_TST2  IF &@BTC = Y THEN
//*        -> BTC=Y              : DD CWPPRMO SPECIFIQUE BATCH       .
//CWPPRMO  DD *
LANGUAGE(COBOLZ/OS)
COBOL(OUTPUT(NOPRINT,NODDIO))
PROCESSOR(OUTPUT(PRINT,DDIO))
PROCESSOR(TEXT(NONE))
PROCESSOR(NOBYPASS)
PROCESSOR(ERRORS(MIXED-CASE))
DDIO(OUTPUT(FIND,COMPRESS,NOLIST))
PRINT(OUTPUT(SOURCE,NOLIST))
//ND-TST2  ENDIF
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//*******************************************************************
//* -> EMISSION MESSAGE SI TYPE DU SOURCE EST "COBPSTK"
//*    COBPSTK N'EST PAS OPERATIONNEL.
//*    LE PROCESSEUR DE BIND PACKAGE EST A MODIFIER.
//*    IL FAUT TESTER LE TYPE=DPKPSTK
//*    EXEC SI : 1) RC OK
//*              2) SOURCE DE TYPE COBPSTK
//*-------------------------------------------------------------------
//CTLEXEC  IF RC  LE  04  THEN
//IF_TST1  IF &@@TYP = PSTK THEN
//ANOMALI2 EXEC PGM=IEBGENER,MAXRC=00
//SYSUT2   DD DISP=(OLD,PASS),DSN=&&ANOMALI2
//SYSPRINT DD SYSOUT=Z
//SYSIN    DD DUMMY
//SYSUT1   DD *
  LE PROCESSEUR GCB3A NECESSITE DES ADAPTATIONS POUR LE TYPE COBPSTK.
/*
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//*******************************************************************
//* -> ARRET DU PROCESSEUR SI MESSAGE EMIS
//* ON FORCE LE CODE RETOUR A 12 POUR TOUT ARRETER                  *
//*******************************************************************
//CTLEXEC  IF ANOMALI2.RC  GE  0  THEN
//FORCECR2 EXEC PGM=BR15,PARM='0012',MAXRC=00
//STEPLIB  DD DISP=SHR,DSN=SYS1.LOADBIB
//ENDCTL   ENDIF
//*
//********************************************************************
//* -> ANALYSE METRIXWARE DU SOURCE
//*    EXEC SI : 1) RC OK
//*              2) DISPONIBILITE GENERALE METRIXWARE (MTX=)
//*              3) STAGE DE TYPE DEVL
//* A -> DEBRAYAGE (SOE OU ETUDES) ANALYSE REQUIS POUR CE SOURCE ?
//*      EXEC SI : 1) RC OK
//*      . MODE EXCLUSION ACTIF -> ANALYSE REALISEE SAUF SI EXCLUS
//*      . MODE INCLUSION ACTIF -> ANALYSE REALISEE QUE  SI INCLUS
//* B -> ANALYSE PHASE 1 + 2 + 3
//*      EXEC SI : 1) RC OK
//*                2) RC DEBRAYAGE = 00
//*-------------------------------------------------------------------
//CTLEXEC  IF RC  LE  04  THEN
//IF_TST1  IF &MTX = Y THEN
//*        -> DISPONIBILITE GENERALE METRIXWARE (MTX=)               .
//IF_TST2  IF &C1SI = D OR
//            &C1SI = J OR
//            &C1SI = V THEN
//*         -> STAGE DE TYPE DEVL
//* ---> DEBRAYAGE (SOE OU ETUDES) ANALYSE REQUIS POUR CE SOURCE ?
//IFMTX    EXEC PGM=IKJEFT01,MAXRC=4
//SYSUT1   DD DISP=SHR,DSN=&MTXBYETU
//SYSUT2   DD DISP=SHR,DSN=&MTXBYSOE
//SYSEXEC   DD DISP=SHR,DSN=&@ZIADMO..ENDV.EXEC
//          DD DISP=SHR,DSN=&@ZIADM2..ENDV.EXEC
//IF_TSTA  IF &MTXINEX = 'INCL-VERSUS-EXCL' THEN
//*        -> MODE INCLUSION ACTIF -> ANALYSE REALISEE QUE  SI INCLUS
//SYSTSIN  DD *
  /* ---> APPEL                                                      */
  PROFILE NOPREFIX
  ISPSTART CMD(%EN0R005  EN0R004M &C1ELEMENT)
/*
//EL-TSTA  ELSE        * MTXINEX='EXCL-VERSUS-INCL'
//*        -> MODE EXCLUSION ACTIF -> ANALYSE REALISEE SAUF SI EXCLUS
//SYSTSIN  DD *
  /* ---> APPEL                                                      */
  PROFILE NOPREFIX
  ISPSTART CMD(%EN0R004  EN0R004M &C1ELEMENT)
/*
//ND-TSTA  ENDIF
//SYSTSPRT DD DISP=(OLD,PASS),DSN=&&IFMTXOUT
//* REM = CONCURRENCE D'ACCES ENTRE BATCH AVEC ISPPROF VIDE          *
//*       POUR EVITER MSG ISPT036 LE PREMIER DSN DE ISPTLIB DOIT ETRE*
//*       DIFFERENT POUR CHAQUE BATCH                                *
//ISPTLIB  DD DISP=(,PASS),DCB=(LRECL=80,RECFM=FB,DSORG=PO),
//            SPACE=(CYL,(1,1,40)),UNIT=WORK
//         DD DSN=SYS1.SISPTENU,DISP=SHR
//ISPPROF  DD DISP=(,PASS),DCB=(LRECL=80,RECFM=FB,DSORG=PO),
//            SPACE=(CYL,(1,1,40)),UNIT=WORK
//ISPPLIB  DD DSN=SYS1.SISPPENU,DISP=SHR
//ISPMLIB  DD DSN=SYS1.SISPMENU,DISP=SHR
//ISPSLIB  DD DSN=SYS1.SISPSLIB,DISP=SHR
//ISPLOG   DD SYSOUT=Z,DCB=(RECFM=VA,LRECL=125,BLKSIZE=0)
//IF_TST3  IF IFMTX.RC = 00 THEN
//* ---> ANALYSE PHASE 1 + 2 + 3 : PHASE 1
//MTXEXPAN EXEC PGM=EXPCOB,PARM='OFFD=-8',COND=(4,LT),MAXRC=4
//STEPLIB  DD DSN=&@@BASEC..METRIXW.LINKLIB,DISP=SHR
//*        ...........................................................
//*        . LOCALISATION SYSIN CONTENANT LE SOURCE (IDEM STEP COBOL).
//*          ON CONSERVE LA MEME LOGIQUE D'ALLOCATION STEP COBOL.    .
//*          METTRE DISP=(OLD,PASS) SUR ELMOUT ET L'UTILISER ICI     .
//*          RISQUE DE MASQUER UN 1708 SUR SVC 99 DANS STEP TRN, SQL .
//*          OU COBOL.                                               .
//*        -> PRECOMPILE DYNAMIQUE  = NON ET CICS : SYSIN=SYSPUNCH   .
//*        -> PRECOMPILE DYNAMIQUE  = NON ET DB2  : SYSIN=SYSCIN     .
//*        -> PRECOMPILE DYNAMIQUE  = NON         : SYSIN=ELMOUT     .
//*        -> PRECOMPILE DYNAMIQUE  = OUI ET CICS/DB2 : SYSIN=ELMNEW .
//*        -> PRECOMPILE DYNAMIQUE  = OUI NOT CICS/DB2: SYSIN=ELMOUT .
//*        ...........................................................
//*        -> PRECOMPILE DYNAMIQUE  = NON => SELECTION DSN DU SOURCE
//IF_TST4  IF &COB3DYN = N  AND
//            (&@CIC = Y OR &@XDL = Y) AND
//            (&@DB2 = Y OR &@DB2 = N) THEN
//*        -> PRECOMPILE DYNAMIQUE  = NON ET CICS : SYSIN=SYSPUNCH   .
//SOURCE   DD DSN=&&SYSPUNCH,DISP=(OLD,DELETE)
//ND-TST4       ENDIF
//IF_TST4  IF &COB3DYN = N  AND
//            (&@CIC = N AND &@XDL = N) AND
//            (&@DB2 = Y)  THEN
//*        -> PRECOMPILE DYNAMIQUE  = NON ET DB2 : SYSIN=SYSCIN      .
//SOURCE   DD DSN=&&SYSCIN,DISP=(OLD,DELETE)
//ND-TST4       ENDIF
//IF_TST4  IF &COB3DYN = N  AND
//            (&@CIC = N AND &@XDL = N) AND
//            (&@DB2 = N)  THEN
//*        -> PRECOMPILE DYNAMIQUE  = NON       : SYSIN=ELMOUT       .
//SOURCE   DD DSN=&&ELMOUT,DISP=(OLD,DELETE)
//ND-TST4       ENDIF
//*        -> PRECOMPILE DYNAMIQUE  = OUI => SELECTION DSN DU SOURCE
//IF_TST4  IF &COB3DYN = Y  AND
//            (&@CIC = Y OR &@XDL = Y  OR
//             &@DB2 = Y)  THEN
//*        -> PRECOMPILE DYNAMIQUE  = OUI ET CICS/DB2 : SYSIN=ELMNEW .
//SOURCE   DD DSN=&&ELMNEW,DISP=(OLD,DELETE)
//ND-TST4  ENDIF
//IF_TST4  IF &COB3DYN = Y  AND
//            (&@CIC = N AND &@XDL = N  AND
//             &@DB2 = N)  THEN
//*        -> PRECOMPILE DYNAMIQUE  = OUI NOT CICS/DB2: SYSIN=ELMOUT .
//SOURCE   DD DSN=&&ELMOUT,DISP=(OLD,DELETE)
//ND-TST4  ENDIF
//EXPANCE  DD DSN=&&COB0LST,DISP=(OLD,PASS)
//SORTIE   DD DSN=&&EXPCOB,
//            DCB=(DSCB,RECFM=FB,LRECL=80,BLKSIZE=0),
//            SPACE=(CYL,(5,1),RLSE),
//            DISP=(,PASS)
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//CEEDUMP  DD SYSOUT=*
//* ---> ANALYSE PHASE 1 + 2 + 3 : PHASE 2
//MTXQCCOB EXEC PGM=QCCOBOL,COND=(4,LT),MAXRC=0
//STEPLIB  DD DSN=&@@BASEC..METRIXW.LINKLIB,DISP=SHR
//ENTREE   DD DSN=&&EXPCOB,DISP=(OLD,PASS)
//TVL      DD DSN=&&TVL,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=44,BLKSIZE=444),
//            SPACE=(CYL,(10,5),RLSE)
//TLINK    DD DSN=&&TLINK,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=104,BLKSIZE=1044),
//            SPACE=(CYL,(10,5),RLSE)
//TPFMETRI DD DSN=&&TPFMETRI,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=54,BLKSIZE=544),
//            SPACE=(CYL,(10,5),RLSE)
//TCOMPTAG DD DSN=&&TCOMPTAG,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=36,BLKSIZE=364),
//            SPACE=(CYL,(10,5),RLSE)
//TEXECSQL DD DSN=&&TEXECSQL,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=15004,BLKSIZE=15008),
//            SPACE=(CYL,(10,5),RLSE)
//TEXECCIC DD DSN=&&TEXECCIC,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=4204,BLKSIZE=8412),
//            SPACE=(CYL,(10,5),RLSE)
//TPICTURE DD DSN=&&TPICTURE,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=104,BLKSIZE=1044),
//            SPACE=(CYL,(10,5),RLSE)
//TFD      DD DSN=&&TFD,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=1104,BLKSIZE=4420),
//            SPACE=(CYL,(10,5),RLSE)
//TFS      DD DSN=&&TFS,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=154,BLKSIZE=1544),
//            SPACE=(CYL,(10,5),RLSE)
//ANALYSE  DD DSN=&&ANALYSE,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=104,BLKSIZE=1044),
//            SPACE=(CYL,(10,5),RLSE)
//ALIAS    DD DSN=&&ALIAS,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=260,BLKSIZE=2604),
//            SPACE=(CYL,(10,5),RLSE)
//AINST    DD DSN=&&AINST,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=74,BLKSIZE=744),
//            SPACE=(CYL,(10,5),RLSE)
//ASSIGN   DD DSN=&&ASSIGN,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=54,BLKSIZE=544),
//            SPACE=(CYL,(10,5),RLSE)
//TVERBE   DD DSN=&&TVERBE,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=34,BLKSIZE=344),
//            SPACE=(CYL,(10,5),RLSE)
//TCOMWORK DD DSN=&&TCOMWORK,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=84,BLKSIZE=844),
//            SPACE=(CYL,(10,5),RLSE)
//TCOMPROC DD DSN=&&TCOMPROC,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=84,BLKSIZE=844),
//            SPACE=(CYL,(10,5),RLSE)
//TVAL     DD DSN=&&TVAL,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=104,BLKSIZE=1044),
//            SPACE=(CYL,(10,5),RLSE)
//TVERBCPT DD DSN=&&TVERBCPT,DISP=(,PASS),
//            DCB=(DSCB,RECFM=VB,LRECL=34,BLKSIZE=344),
//            SPACE=(CYL,(10,5),RLSE)
//ATRAIT   DD DSN=&&ATRAIT,DISP=(,PASS),
//            DCB=(DSCB,RECFM=FB,LRECL=66,BLKSIZE=660),
//            SPACE=(CYL,(10,5),RLSE)
//TERR     DD DSN=&&TERR,DISP=(,PASS),
//            DCB=(DSCB,RECFM=FB,LRECL=31,BLKSIZE=3100),
//            SPACE=(CYL,(10,5),RLSE)
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//CEEDUMP  DD SYSOUT=*
//* ---> ANALYSE PHASE 1 + 2 + 3 : PHASE 3
//MTXCOBBP EXEC PGM=COBOLBP,COND=(4,LT),MAXRC=1,
//         PARM='-S:&MTXLEVEL -N:&C1ELEMENT -U:&C1USERID'
//STEPLIB  DD DSN=&@@BASEC..METRIXW.LINKLIB,DISP=SHR
//CONFIG   DD DSN=&@@BASEC..METRIXW.XLMCONF(&MTXXMLMB.),DISP=SHR
//ENTREE   DD DSN=&&EXPCOB,DISP=(OLD,PASS)
//TVL      DD DSN=&&TVL,DISP=(OLD,PASS)
//TLINK    DD DSN=&&TLINK,DISP=(OLD,PASS)
//TPFMETRI DD DSN=&&TPFMETRI,DISP=(OLD,PASS)
//TCOMPTAG DD DSN=&&TCOMPTAG,DISP=(OLD,PASS)
//TEXECSQL DD DSN=&&TEXECSQL,DISP=(OLD,PASS)
//TEXECCIC DD DSN=&&TEXECCIC,DISP=(OLD,PASS)
//TPICTURE DD DSN=&&TPICTURE,DISP=(OLD,PASS)
//TFD      DD DSN=&&TFD,DISP=(OLD,PASS)
//TFS      DD DSN=&&TFS,DISP=(OLD,PASS)
//ANALYSE  DD DSN=&&ANALYSE,DISP=(OLD,PASS)
//ALIAS    DD DSN=&&ALIAS,DISP=(OLD,PASS)
//AINST    DD DSN=&&AINST,DISP=(OLD,PASS)
//ASSIGN   DD DSN=&&ASSIGN,DISP=(OLD,PASS)
//TVERBE   DD DSN=&&TVERBE,DISP=(OLD,PASS)
//TCOMWORK DD DSN=&&TCOMWORK,DISP=(OLD,PASS)
//TCOMPROC DD DSN=&&TCOMPROC,DISP=(OLD,PASS)
//TVAL     DD DSN=&&TVAL,DISP=(OLD,PASS)
//TVERBCPT DD DSN=&&TVERBCPT,DISP=(OLD,PASS)
//ATRAIT   DD DSN=&&ATRAIT,DISP=(OLD,PASS)
//TERR     DD DSN=&&TERR,DISP=(OLD,PASS)
//RESULT   DD SYSOUT=*,DCB=(DSCB,RECFM=VB,LRECL=154,BLKSIZE=1544)
//FLOG     DD SYSOUT=*,DCB=(DSCB,RECFM=VB,LRECL=154,BLKSIZE=1544)
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//CEEDUMP  DD SYSOUT=*
//SYSUDUMP DD DUMMY
//EL-TST3  ELSE
//NOANAMTX EXEC PGM=IEFBR14
//ND-TST3  ENDIF
//ND-TST2  ENDIF
//EL-TST1  ELSE
//NOMTX    EXEC PGM=IEFBR14
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//*******************************************************************
//* -> LINK-EDIT NUMERO 1
//*    EXEC SI : 1) RC OK
//*------------------------------------------------------------------
//CTLEXEC  IF RC  LE  04  THEN
//LKD1     EXEC PGM=IEWL,MAXRC=4,
//         PARM='&LKDOPT'
//SYSLMOD  DD DISP=SHR,DSN=&LOADLIB(&C1ELEMENT),
//            MONITOR=COMPONENTS,FOOTPRNT=CREATE
//SYSPRINT DD DSN=&&LKD1LST,DISP=(OLD,PASS)
//SYSUT1   DD UNIT=VIO,SPACE=(TRK,(15,15)),DCB=BUFNO=1
//*        ...........................................................
//*        . COMPLEMENT DES OPTIONS DE LKD BATCH/CICS                .
//*        -> CICS=Y             : LKDCIC='RENT,CALL,RES',           .
//*        -> BTCH=Y             : LKDBTC='LET(08),REUS',            .
//*        ...........................................................
//IF_TST1  IF &@CIC = Y THEN
//*        -> CICS=Y             : LKDCIC='RENT,CALL,RES',           .
//DDLKDOPT DD *,DCB=BLKSIZE=80
 &LKDCIC
/*
//ND-TST1  ENDIF
//IF_TST1  IF &@BTC = Y THEN
//*        -> BTCH=Y             : LKDBTC='LET(08),REUS',            .
//DDLKDOPT DD *,DCB=BLKSIZE=80
 &LKDBTC
/*
//ND-TST1  ENDIF
//*        ...........................................................
//*        . CONCATENATION SYSLIB                                    .
//*        -> COBOL3 INUTILE                                         .
//*        -> LANGAGE ENVIRONNEMENT OBLIGATOIRE ET UNIQUE BATCH/CICS .
//*        -> DB2=Y              : SDSNLOAD (AVANT RESLIB HISTORIQUE).
//*        -> CICS=Y OU XDLI=Y   : SDFHLOAD                          .
//*        -> BTCH=Y             : RESLIB                            .
//*        -> BTCH=Y             : EANSRC                            .
//*        -> AUTRES DSN EN OVERRIDE PROCESSEUR GROUPE               .
//*        -> ALLOCATION SANS CONDITION (AUTRES STAGES ENDEVOR)      .
//*        ...........................................................
//*        -> LANGAGE ENVIRONNEMENT OBLIGATOIRE ET UNIQUE BATCH/CICS .
//SYSLIB   DD MONITOR=COMPONENTS,DISP=SHR,DSN=&CEELKED
//IF_TST1  IF &@DB2 = Y THEN
//*        -> DB2=Y              : SDSNLOAD (AVANT RESLIB HISTORIQUE).
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&DB2LOAD
//ND-TST1  ENDIF
//IF_TST1  IF &@CIC = Y OR &@XDL=Y THEN
//*        -> CICS=Y OU XDLI=Y   : SDFHLOAD                          .
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&CICSLOAD
//ND-TST1  ENDIF
//IF_TST1  IF &@BTC=Y THEN
//*        -> BTCH=Y             : RESLIB                            .
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSIMS
//ND-TST1  ENDIF
//*        ...........................................................
//*        . AUTRES DSN EN OVERRIDE PROCESSEUR GROUPE                .
//*        ...........................................................
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSLIB1
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSLIB2
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSLIB3
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSLIB4
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSLIB5
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSLIB6
//*        ...........................................................
//*        . ALLOCATION SANS CONDITION (AUTRES STAGES ENDEVOR)       .
//*        ...........................................................
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LOADLIB
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LSTG2LD
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LSTGRLD
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LSTGPLD
//*        ...........................................................
//*        . CONCATENATION SYSLIN                                    .
//*        DANS TOUS LES CAS COMPLEMENT AVEC SYSLIN OVERRIDE PROCGRP .
//*        -> BATCH ET XDLI      : RESLIB + &&SYSLIN+INCLUDE DFSLI000.
//*                                EX GBC2I, GBC2X, GBC2Z(LK2)       .
//*        -> BATCH ET NON XDLI  : &&SYSLIN ONLY                     .
//*                                EX GBC2N, GBC2D, GBC2Z(LK1)       .
//*        -> CICS ET DB2        : DFHELII  +&&SYSLIN+ INCLUDE DSNCLI.
//*                                EX GKC2X                          .
//*        -> CICS ET NON DB2    : DFHELII  + &&SYSLIN               .
//*                                EX GKC2I                          .
//*        -> COBPSTK (FUTURE USE: &&SYSLIN + INCLUDE DSNRLI         .
//*        ...........................................................
//*        -> BATCH ET XDLI      : RESLIB + &&SYSLIN+INCLUDE DFSLI000.
//IF_TST1  IF &@BTC = Y AND &@XDL=Y THEN
//RESLIB   DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSIMS
//SYSLIN   DD DSN=&&SYSLIN,DISP=(OLD,PASS)
//         DD *,DCB=BLKSIZE=80
 INCLUDE RESLIB(DFSLI000)
&LKDSLIN1
&LKDSLIN2
&LKDSLIN3
&LKDSLIN4
&LKDSLIN5
&LKDSLIN6
/*
//ND-TST1  ENDIF
//*        ...........................................................
//*        -> BATCH ET NON XDLI  : &&SYSLIN ONLY                     .
//IF_TST1  IF &@BTC = Y AND &@XDL=N THEN
//SYSLIN   DD DSN=&&SYSLIN,DISP=(OLD,PASS)
//         DD *,DCB=BLKSIZE=80
&LKDSLIN1
&LKDSLIN2
&LKDSLIN3
&LKDSLIN4
&LKDSLIN5
&LKDSLIN6
/*
//ND-TST1  ENDIF
//*        ...........................................................
//*        -> CICS ET DB2        : DFHELII  +&&SYSLIN+ INCLUDE DSNCLI.
//IF_TST1  IF &@CIC = Y AND &@DB2 = Y THEN
//SYSLIN   DD DSN=&CICLKINC(&CICLKMBR),DISP=SHR
//         DD DSN=&&SYSLIN,DISP=(OLD,PASS)
//         DD *,DCB=BLKSIZE=80
 INCLUDE SYSLIB(DSNCLI)
&LKDSLIN1
&LKDSLIN2
&LKDSLIN3
&LKDSLIN4
&LKDSLIN5
&LKDSLIN6
/*
//ND-TST1  ENDIF
//*        ...........................................................
//*        -> CICS ET NON DB2    : DFHELII  + &&SYSLIN               .
//IF_TST1  IF &@CIC = Y AND &@DB2=N THEN
//SYSLIN   DD DSN=&CICLKINC(&CICLKMBR),DISP=SHR
//         DD DSN=&&SYSLIN,DISP=(OLD,PASS)
//         DD *,DCB=BLKSIZE=80
&LKDSLIN1
&LKDSLIN2
&LKDSLIN3
&LKDSLIN4
&LKDSLIN5
&LKDSLIN6
/*
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//********************************************************************
//* -> LINK-EDIT NUMERO 2 : ATTACHEMENT DLI ET LOAD DANS BTCHLOA2
//*    SOUS-PROGRAMME DB2 APPELE EN CONTEXTE DLI
//*    EXEC SI : 1) RC OK
//*              2) LK2=Y
//*-------------------------------------------------------------------
//CTLEXEC  IF RC  LE  04  THEN
//IF_TST1  IF &@LK2 = Y THEN
//LKD2     EXEC PGM=IEWL,MAXRC=4,
//         PARM='&LKDOPT'
//SYSLMOD  DD DISP=SHR,DSN=&LOADLIB2(&C1ELEMENT), *** BTCHLOA2 ***
//            MONITOR=COMPONENTS,FOOTPRNT=CREATE
//SYSPRINT DD DSN=&&LKD2LST,DISP=(OLD,PASS)
//SYSUT1   DD UNIT=VIO,SPACE=(TRK,(15,15)),DCB=BUFNO=1
//*        ...........................................................
//*        . COMPLEMENT DES OPTIONS DE LKD BATCH                     .
//*        -> BTCH=Y             : LKDBTC='LET(08),REUS',            .
//*        ...........................................................
//IF_TST2  IF &@BTC = Y THEN
//*        -> BTCH=Y             : LKDBTC='LET(08),REUS',            .
//DDLKDOPT DD *,DCB=BLKSIZE=80
 &LKDBTC
/*
//ND-TST2  ENDIF
//*        ...........................................................
//*        . CONCATENATION SYSLIB                                    .
//*        -> 1 LANGAGE ENVIRONNEMENT OBLIGATOIRE + UNIQUE BATCH/CICS.
//*        -> 2 RESLIB (IMS POUR INCLUDE DFSLI000)                   .
//*        -> 3 SDSNLOAD (DB2)                                       .
//*        -> 4 SDFHLOAD (CICS POUR XDLI)                            .
//*        -> 5 AUTRES DSN EN OVERRIDE PROCESSEUR GROUPE             .
//*        -> 6 AUTRES STAGES ENDEVOR                                .
//*        ...........................................................
//SYSLIB   DD MONITOR=COMPONENTS,DISP=SHR,DSN=&CEELKED
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSIMS
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&DB2LOAD
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&CICSLOAD
//*        ...........................................................
//*        . AUTRES DSN EN OVERRIDE PROCESSEUR GROUPE                .
//*        ...........................................................
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSLIB1
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSLIB2
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSLIB3
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSLIB4
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSLIB5
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LKDSLIB6
//*        ...........................................................
//*        . ALLOCATION SANS CONDITION (AUTRES STAGES ENDEVOR)       .
//*        ...........................................................
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LOADLIB
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LOADLIB2
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LSTG2LD
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LSTG2LD2
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LSTGRLD
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LSTGRLD2
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LSTGPLD
//         DD MONITOR=COMPONENTS,DISP=SHR,DSN=&LSTGPLD2
//*        ...........................................................
//*        . CONCATENATION SYSLIN                                    .
//*        DANS TOUS LES CAS COMPLEMENT AVEC SYSLIN OVERRIDE PROCGRP .
//*        -> &&SYSLIN + INCLUDE DFSLI000 DE IMS ET NON DE DB2       .
//*        ...........................................................
//SYSLIN   DD DSN=&&SYSLIN,DISP=(OLD,PASS)
//         DD *,DCB=BLKSIZE=80
 INCLUDE SYSLIB(DFSLI000)
&LKDSLIN1
&LKDSLIN2
&LKDSLIN3
&LKDSLIN4
&LKDSLIN5
&LKDSLIN6
/*
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//********************************************************************
//* -> MENAGE DE BTCHLOA2
//*    EXEC SI : 1) RC OK
//*              2) MDACTIF='OUI'
//* &C1EN &C1ELEMENT &C1TY &C1PRGRP &LOADLIB2
//*-------------------------------------------------------------------
//CTLEXEC  IF RC  LE  04  THEN
//IF_TST1  IF &MDACTIF = OUI AND
//            &C1TY = COBBTCH THEN
//MDPRCGRP EXEC PGM=IKJEFT01,
//  PARM='%EN0R006 &C1EN &C1ELEMENT &C1TY &C1PRGRP &LOADLIB2'
//SYSEXEC  DD   DISP=SHR,DSN=&@ZIADMO..ENDV.EXEC
//         DD   DISP=SHR,DSN=&@ZIADM2..ENDV.EXEC
//TBLCHG   DD   DISP=SHR,DSN=&MDPDS(&MDMBR)
//SYSTSPRT DD   DISP=OLD,DSN=&&MDPRMSG
//SYSTSIN  DD   DUMMY
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//********************************************************************
//* -> SAUVEGARDE DU DBRM (AVEC ENQ ISPF VIA CORTEX)
//*    EXEC SI : 1) RC OK
//*              2) DB2
//*-------------------------------------------------------------------
//CTLEXEC  IF RC  LE  04  THEN
//IF_TST1  IF &@DB2 = Y THEN
//DBRMCOPY EXEC PGM=CZX2PZQL,PARM='-IEBGENER-',MAXRC=0
//STEPLIB   DD DISP=SHR,DSN=&@@BASEC..CORTK.EXITLIB
//          DD DISP=SHR,DSN=&@@BASEB..CORTK.LINKLIB
//SYSUT1    DD DSN=&&DBRM(&C1ELEMENT),DISP=(OLD,DELETE)
//SYSUT2    DD DISP=SHR,DSN=&DB2RMLB(&C1ELEMENT),
//             MONITOR=COMPONENTS,FOOTPRNT=CREATE
//ISPFE001  DD DISP=SHR,DSN=&DB2RMLB
//SYSPRINT  DD DUMMY
//SYSIN     DD DUMMY
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//*******************************************************************
//* -> GENERATE DU DPKCICS/DPKBTCH/DPKPSTK POUR FAIRE LE BIND PACKAGE
//*    AVEC OPTION CCID  POUR LIER SOURCE ET DPK....
//*    EXEC SI : 1) RC OK
//*              2) DB2
//*              3) STAGE DE TYPE DEVL (SAUF B CAR PLUS DE DB2)
//*-------------------------------------------------------------------
//CTLEXEC  IF RC  LE  04  THEN
//IF_TST1  IF &@DB2 = Y THEN
//IF_TST2  IF &C1SI = D OR
//            &C1SI = J OR
//            &C1SI = V THEN
//DPKGEN   EXEC PGM=C1BM3000,MAXRC=4,
//         PARM=(COMMNDES,MESSAGES)
//MESSAGES DD DSN=&&DPKMSGS,DISP=(OLD,PASS)
//COMMNDES DD *
  GENERATE ELEMENT '&C1ELEMENT'
      FROM ENV &C1ENVMNT
           STAGE &C1STGID
           SYSTEM '&C1SYSTEM'
           SUBSYSTEM '*'
    TYPE   'DPK*'
    OPTION COPYBACK
           CCID '&C1CCID'
           OVERRIDE SIGNOUT
           COMMENT 'BIND PACKAGE SUITE A COMPILATION'
  .
//IF_TST3  IF &C1TY = 'COBBTCH' THEN
//*        -> INCIDENT I18175734 : DELETE SYSTEMATIQUE FOOTPRINT     .
//*           NOTE : APRES UN MOVE EN F, LE FOOTPRINT N'EXISTE PLUS  .
//*                  EN V. UN DELETE AVANT GENERATE FAIT DONC CODE 12.
//         DD *
 DELETE ELEMENT '&C1ELEMENT'
    FROM   ENV &C1ENVMNT
           STAGE &C1STGID
           SYSTEM '&C1SYSTEM'
           SUBSYSTEM '*'
           TYPE 'DPKBTCH'
     OPTION
           CCID '&C1CCID'
           COMMENTS "I18175734 : RECHERCHE  BYPASS"
           ONLY COMPONENT
 .
//ND-TST3  ENDIF
//ND-TST2  ENDIF
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//*******************************************************************
//* SUIVI DES COMPILATIONS DANS L'ENVIRONNEMENT DE DEV ET D'INTEG
//*    EXEC SI : 1) ENV = 'V' (DEV GFA/EA/GVIE)
//*                 ENV = 'Y' (DEV GVIE)
//*                 ENV = 'J' (INT AUTONOME GFA)
//*                 ENV = 'F' (INT STANDARD GFA)
//*-------------------------------------------------------------------
//CTLEXEC  IF &C1SI = V OR
//            &C1SI = Y OR
//            &C1SI = J OR
//            &C1SI = F THEN
//SVCPL    EXEC PGM=IKJEFT01,
//  PARM='%EN0R007 &SVPARM'
//SYSEXEC  DD   DISP=SHR,DSN=&@ZIADMO..ENDV.EXEC
//         DD   DISP=SHR,DSN=&@ZIADM2..ENDV.EXEC
//SYSTSPRT DD   DISP=OLD,DSN=&&INFOCPL
//SYSTSIN  DD   DUMMY
//ENDCTL   ENDIF
//*
//*******************************************************************
//* -> SAUVEGARDE DES SYSOUTS
//*    EXEC SI : 1) RC OK
//*              2) STAGE= F OU R OU P OU J OU Z OU W OU B
//*-------------------------------------------------------------------
//CTLEXEC  IF COMPIL.RC    LE  04  OR
//            LKD1.RC      LE  04  OR
//            DPKGEN.RC    =   00  THEN
//IF_TST1  IF &C1SI = F OR
//            &C1SI = R OR
//            &C1SI = P OR
//            &C1SI = J OR
//            &C1SI = Z THEN
//SAVELIST  EXEC PGM=CONLIST,MAXRC=0,PARM=STORE
//C1BANNER DD UNIT=WORK,SPACE=(TRK,(1,1)),
//            DCB=(RECFM=FBA,LRECL=121,BLKSIZE=6171)
//C1LLIBO  DD MONITOR=COMPONENTS,DISP=SHR,DSN=&@ZLST
//LIST01   DD DSN=&&CONTEXT,DISP=(OLD,PASS)
//LIST12   DD DSN=&&PRTOPT,DISP=(OLD,PASS)
//LIST02   DD DSN=&&COB0LST,DISP=(OLD,PASS)
//LIST03   DD DSN=&&CWPERRM,DISP=(OLD,PASS)
//LIST04   DD DSN=&&LKD1LST,DISP=(OLD,PASS)
//LIST05   DD DSN=&&LKD2LST,DISP=(OLD,PASS)
//LIST06   DD DSN=&&DPKMSGS,DISP=(OLD,PASS)
//EL-TST1  ELSE
//NOSAVEL  EXEC PGM=IEFBR14
//ND-TST1  ENDIF
//ENDCTL   ENDIF
//*
//*******************************************************************
//* -> IMPRESSION DES SYSOUTS SI ERREUR
//*    EXEC SI : 1) SI ERREUR SUR UN STEP OU ABEND MTX
//*-------------------------------------------------------------------
//CTLEXEC  IF RC  GT  04  OR
//            (MTXCOBBP.ABEND)  THEN
//*        ...........................................................
//*        . CRITERES D'IMPRESSION DE LA SYSOUT DU STEP              .
//*        -> TRACE01  : STEP TRACE01  EXECUTE (TRACE JEU D'ESSAI)   .
//*        -> ANOMALI0 : STEP FORCECR0 EXECUTE (PGRP DESACTIVE)      .
//*        -> ANOMALI1 : STEP FORCECR1 EXECUTE (PGRP INVALIDE)       .
//*        -> CONTEXT  : TOUJOURS (GESTION DU DISP=PASS/DELETE)      .
//*        -> SQL      : @@PRTSQL = Y OU RC GT 4                     .
//*        -> TRN      : @@PRTTRN = Y OU RC GT 4                     .
//*        -> COMPIL   : RC GT 4 (+ SYSOUT = PRTOPT, CWPERRM)        .
//*        -> IFMTX    : RC GT 4                                     .
//*        -> MTXCOBBP : ABEND                                       .
//*        -> ANOMALI2 : STEP FORCECR2 EXECUTE (TYPE=COBPSTK)        .
//*        -> LKD1     : RC GT 4                                     .
//*        -> LKD2     : RC GT 4                                     .
//*        -> DPKGEN   : RC GT 0 (STAGE V GENERATION DU DPK....)     .
//ERROR     EXEC PGM=CONLIST,MAXRC=0,PARM=PRINT,COND=EVEN
//C1BANNER DD UNIT=WORK,SPACE=(TRK,(1,1)),
//            DCB=(RECFM=FBA,LRECL=121,BLKSIZE=6171)
//C1PRINT  DD SYSOUT=&@ZSYSOUT,FREE=CLOSE,
//            DCB=(RECFM=FBA,LRECL=133,BLKSIZE=1330)
//*        -> TRACE01  : STEP TRACE01  EXECUTE (TRACE JEU D'ESSAI)   .
//IF_TST2  IF TRACE01.RC = 00 THEN
//LIST14   DD DSN=&&TRACE01,DISP=(OLD,PASS)
//ND-TST2  ENDIF
//*        -> ANOMALI0 : STEP FORCECR0 EXECUTE (PGRP DESACTIVE)      .
//IF_TST2  IF FORCECR0.RC = 12 THEN
//LIST00   DD DSN=&&ANOMALI0,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//*        -> ANOMALI1 : STEP FORCECR1 EXECUTE (PGRP INVALIDE)       .
//IF_TST2  IF FORCECR1.RC = 12 THEN
//LIST01   DD DSN=&&ANOMALI1,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//*        -> CONTEXT  : TOUJOURS (GESTION DU DISP=PASS/DELETE)      .
//IF_TST2  IF (&@@PRTSQL = Y OR &@@PRTTRN = Y) THEN
//LIST02   DD DSN=&&CONTEXT,DISP=(OLD,PASS)
//EL-TST1  ELSE
//LIST02   DD DSN=&&CONTEXT,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//*        -> SQL      : @@PRTSQL = Y OU RC GT 4                     .
//IF_TST2  IF SQL.RC GT 4 OR &@@PRTSQL = Y  THEN
//LIST03   DD DSN=&&SQLLIST,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//*        -> TRN      : @@PRTTRN = Y OU RC GT 4                     .
//IF_TST2  IF TRN.RC GT 4 OR &@@PRTTRN = Y THEN
//LIST04   DD DSN=&&TRNLIST,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//*        -> COMPIL   : RC GT 4 (+ SYSOUT = PRTOPT, CWPERRM)        .
//IF_TST2  IF COMPIL.RC GT 4 THEN
//LIST12   DD DSN=&&PRTOPT,DISP=(OLD,DELETE)
//LIST05   DD DSN=&&COB0LST,DISP=(OLD,DELETE)
//LIST06   DD DSN=&&CWPERRM,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//*        -> IFMTX    : RC GT 4                                     .
//IF_TST2  IF IFMTX.RC GT 4 THEN
//LIST13   DD DSN=&&IFMTXOUT,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//*        -> MTXCOBBP : ABEND                                       .
//IF_TST2  IF (MTXCOBBP.ABEND)  OR  MTXCOBBP.RC GT 1  THEN
//LIST05   DD DSN=&&COB0LST,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//*        -> ANOMALI2 : STEP FORCECR2 EXECUTE (TYPE=COBPSTK)        .
//IF_TST2  IF FORCECR2.RC = 12 THEN
//LIST07   DD DSN=&&ANOMALI2,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//*        -> LKD1     : RC GT 4                                     .
//IF_TST2  IF LKD1.RC GT 4 THEN
//LIST08   DD DSN=&&LKD1LST,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//*        -> LKD2     : RC GT 4                                     .
//IF_TST2  IF LKD2.RC GT 4 THEN
//LIST09   DD DSN=&&LKD2LST,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//*        -> DPKGEN   : RC GT 0 (STAGE V GENERATION DU DPK....)     .
//IF_TST2  IF DPKGEN.RC GT 0 THEN
//LIST10   DD DSN=&&DPKMSGS,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//*
//IF_TST2  IF &MDACTIF = OUI THEN
//LIST15   DD DSN=&&MDPRMSG,DISP=(OLD,DELETE)          DELETE BTCHLOA2
//ND-TST2  ENDIF
//LIST16   DD DSN=&&INFOCPL,DISP=(OLD,DELETE)              INFO COMPIL
//*
//EL-CTL   ELSE
//NOERROR  EXEC PGM=IEFBR14
//ENDCTL   ENDIF
//*
//*******************************************************************
//* -> IMPRESSION DES SYSOUTS POUR STAGE LIKE DEVL
//*    EXEC SI : 1) RC OK
//*              2) STAGE= V OU D OU J OU B
//*-------------------------------------------------------------------
//*        ...........................................................
//*        . CRITERES D'IMPRESSION DE LA SYSOUT DU STEP              .
//*        -> TRACE01  : STEP TRACE01  EXECUTE (TRACE JEU D'ESSAI)   .
//*        -> CONTEXT  : TOUJOURS (GESTION DU DISP=PASS/DELETE)      .
//*        -> SQL      : @@PRTSQL = Y OU RC GT 4                     .
//*        -> TRN      : @@PRTTRN = Y OU RC GT 4                     .
//*        -> COMPIL   : RC GT 4 (+ SYSOUT = PRTOPT, CWPERRM)        .
//*        -> IFMTX    : RC GT 4                                     .
//*        -> ANOMALI2 : STEP FORCECR2 EXECUTE (TYPE=COBPSTK)        .
//*        -> LKD1     : RC GT 4                                     .
//*        -> LKD2     : RC GT 4                                     .
//*        ...........................................................
//CTLEXEC  IF RC  LT  05 THEN
//IF_TST1  IF &C1SI = D OR
//            &C1SI = J OR
//            &C1SI = V THEN
//PRTDEV    EXEC PGM=CONLIST,MAXRC=0,PARM=PRINT
//C1BANNER DD UNIT=WORK,SPACE=(TRK,(1,1)),
//            DCB=(RECFM=FBA,LRECL=121,BLKSIZE=6171)
//C1PRINT  DD SYSOUT=&@ZSYSOUT,FREE=CLOSE,
//            DCB=(RECFM=FBA,LRECL=133,BLKSIZE=1330)
//*        -> TRACE01  : STEP TRACE01  EXECUTE (TRACE JEU D'ESSAI)   .
//IF_TST2  IF TRACE01.RC = 00 THEN
//LIST14   DD DSN=&&TRACE01,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//LIST02   DD DSN=&&CONTEXT,DISP=(OLD,DELETE)
//LIST12   DD DSN=&&PRTOPT,DISP=(OLD,DELETE)
//*        -> SQL      : @@PRTSQL = Y OU RC GT 4                     .
//IF_TST2  IF &@@PRTSQL = Y  THEN
//LIST03   DD DSN=&&SQLLIST,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//*        -> TRN      : @@PRTTRN = Y OU RC GT 4                     .
//IF_TST2  IF &@@PRTTRN = Y THEN
//LIST04   DD DSN=&&TRNLIST,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//LIST05   DD DSN=&&COB0LST,DISP=(OLD,DELETE)
//LIST06   DD DSN=&&CWPERRM,DISP=(OLD,DELETE)
//LIST08   DD DSN=&&LKD1LST,DISP=(OLD,DELETE)
//LIST13   DD DSN=&&IFMTXOUT,DISP=(OLD,DELETE)
//IF_TST2  IF &@LK2 = Y  THEN
//LIST09   DD DSN=&&LKD2LST,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//LIST10   DD DSN=&&DPKMSGS,DISP=(OLD,DELETE)
//*
//IF_TST2  IF &MDACTIF = OUI THEN
//LIST15   DD DSN=&&MDPRMSG,DISP=(OLD,DELETE)          DELETE BTCHLOA2
//ND-TST2  ENDIF
//LIST16   DD DSN=&&INFOCPL,DISP=(OLD,DELETE)              INFO COMPIL
//*
//EL-TST1  ELSE
//NOPRTDEV EXEC PGM=IEFBR14
//ND-TST1  ENDIF
//EL-CTL   ELSE
//NOPRTDEV EXEC PGM=IEFBR14
//ENDCTL   ENDIF
//*
//*******************************************************************
//* -> IMPRESSION DES SYSOUTS DES AUTRES STAGES
//*    EXEC SI : 1) RC OK
//*              2) STAGE= P OU R OU F OU Z OU W
//*-------------------------------------------------------------------
//*        ...........................................................
//*        . CRITERES D'IMPRESSION DE LA SYSOUT DU STEP              .
//*        -> TRACE01  : STEP TRACE01  EXECUTE (TRACE JEU D'ESSAI)   .
//*        -> CONTEXT  : TOUJOURS (GESTION DU DISP=PASS/DELETE)      .
//*        -> SQL      : @@PRTSQL = Y OU RC GT 4                     .
//*        -> TRN      : @@PRTTRN = Y OU RC GT 4                     .
//*        ...........................................................
//CTLEXEC  IF RC  LT  05 THEN
//IF_TST1  IF &C1SI = P OR
//            &C1SI = R OR
//            &C1SI = Z OR
//            &C1SI = F THEN
//PRTPRD    EXEC PGM=CONLIST,MAXRC=0,PARM=PRINT
//C1BANNER DD UNIT=WORK,SPACE=(TRK,(1,1)),
//            DCB=(RECFM=FBA,LRECL=121,BLKSIZE=6171)
//C1PRINT  DD SYSOUT=&@ZSYSOUT,FREE=CLOSE,
//            DCB=(RECFM=FBA,LRECL=133,BLKSIZE=1330)
//*        -> TRACE01  : STEP TRACE01  EXECUTE (TRACE JEU D'ESSAI)   .
//IF_TST2  IF TRACE01.RC = 00 THEN
//LIST14   DD DSN=&&TRACE01,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//LIST02   DD DSN=&&CONTEXT,DISP=(OLD,DELETE)
//*
//IF_TST2  IF &MDACTIF = OUI THEN
//LIST15   DD DSN=&&MDPRMSG,DISP=(OLD,DELETE)          DELETE BTCHLOA2
//ND-TST2  ENDIF
//*
//EL-TST1  ELSE
//*        -> SQL      : @@PRTSQL = Y OU RC GT 4                     .
//IF_TST2  IF &@@PRTSQL = Y  THEN
//LIST03   DD DSN=&&SQLLIST,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//*        -> TRN      : @@PRTTRN = Y OU RC GT 4                     .
//IF_TST2  IF &@@PRTTRN = Y THEN
//LIST04   DD DSN=&&TRNLIST,DISP=(OLD,DELETE)
//ND-TST2  ENDIF
//NOPRTPRD EXEC PGM=IEFBR14
//ND-TST1  ENDIF
//EL-CTL   ELSE
//NOPRTPRD EXEC PGM=IEFBR14
//ENDCTL   ENDIF
//*
//*========================== FIN DU PROCESSEUR =====================
