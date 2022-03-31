import com.ibm.dbb.build.MVSExec



@Field BuildProperties props = BuildProperties.getInstance()

MVSExec sql = createSqlCommand(buildFile, logicalFile, member, logFile)
MVSExec trn = createTrnCommand(buildFile, logicalFile, member, logFile)
MVSExec compile = createCompileCommand(buildFile, logicalFile, member, logFile)
MVSExec lked1 = createLked1Command(buildFile, logicalFile, member, logFile)
MVSExec lked2 = createLked2Command(buildFile, logicalFile, member, logFile)
MVSExec dbrmcopy = createDbrmcopyCommand(buildFile, logicalFile, member, logFile)

// execute mvs commands in a mvs job
MVSJob job = new MVSJob()
job.start()
if ("${props.COB3DYN}"== "N" && "${props.@DB2}" == "Y") {
//	def sqlrc = sql.execute()
	if (sqlrc > 4)
		println("Pre Compile failed!  RC=$sqlrc")
	else
	{
		println("Pre Compile successful!  RC=$sqlrc")
		def copyrc= copySyscIn.execute()
		if (copyrc > 4)
			println("copy failed!  RC=$copyrc")
		else
			println("copy successful!  RC=$copyrc")
	}
}
job.stop()


def createSqlCommand(buildFile, logicalFile, member, logFile) {

	def sql = new MVSExec().pgm("DSNHPC").parm("${props.DB2OPT}")
	sql.dd(new DDStatement().name("TASKLIB").dsn("${props.DB2EXIT}").options("shr"))
	sql.dd(new DDStatement().dsn("${props.DB2LOAD}").options("shr"))
	sql.dd(new DDStatement().name("SYSPRINT").dsn("&&SQLLIST").options('cyl space(5,5) unit(vio) new').pass(true))
	sql.dd(new DDStatement().name("SYSTERM").options("DUMMY"))
	sql.dd(new DDStatement().name("SYSUT1").options("trk space(15,15) unit(vio) new"))
	sql.dd(new DDStatement().name("SYSUT2").options("trk space(5,5) unit(vio) new"))
	sql.dd(new DDStatement().name("SYSLIB").dsn("${props.DB2DCLG}").options("shr"))
	sql.dd(new DDStatement().name("DBRMLIB").dsn("&&DBRM"("${props.C1ELEMENT}").options("cyl space(1,1,1) unit(work) new recfm(F,B) blksize(80)").pass(true)))
	sql.dd(new DDStatement().name("SYSIN").dsn("&&ELEMOUT").options('shr'))
	sql.dd(new DDStatement().name("SYSCIN").dsn("&&SYSCIN").options('cyl space(5,5) unit(vio) new').pass(true))
}


def createTrnCommand(buildFile, logicalFile, member, logFile) {
}
def trn = new MVSExec().pgm("DFHECP1$").parm("{props.CITRNOPT}")
trn.dd(new DDStatement().name("TASKLIB").dsn("${props.CICSLOAD}".options("shr"))
trn.dd(new DDStatement().name("SYSPRINT").dsn("&&TRNLIST")("cyl space(5,5) unit(vio) new").pass(true old))
//if????? DB2=n (ELmount), DB2=y (SYSCIN) 
trn.dd(new DDStatement().name("SYSIN").dsn("${props.sysinDsn}(${C1ELEMENT})").options("shr"))
trn.dd(new DDStatement().name("Syspunch").dsn("&&SYSPUNCH")
.options("tracks space(15,5) unit(vio) new recfm(F,B) blksize(80) lrecl(80)").pass(

def createCompileCommand(buildFile, logicalFile, member, logFile) {
}

def createLked1Command(buildFile, logicalFile, member, logFile) {
	def lked1 = new MVSExec().pgm("IEWL").parm("&LKDOPT")
	lked1.dd(new DDStatement().name(SYSLMOD).dsn("{&LOADLIB2}(${&C1ELEMENT})").options(footprint = create))
	// Nachfragen wegen BTCHLOA2 /keine Ahnung was das ist 
	lked1.dd(new DDStatement().name(&&LKD2LST).pass(true old))
	lked1.dd(new DDStatement().name(SYSUT1).options("shr"))
		if ("${props.&@BTC}".toString().equals("Y")){
			DDLKDOPT = dcb=blksize(80)
		}
	// Nachfragen da monitroing und props vopn außen
	lked1.dd(new DDStatement().name(&&SYSLIN).options(new dcb blksize(80)).pass(true old))

}

def createLked2Command(buildFile, logicalFile, member, logFile) {
	def lked2 = new MVSExec().pgm("IEWL").("&LKDOPT")
	lked2.dd(new DDStatement().name(SYSLMOD).dsn("{&LOADLIB2}(${&C1ELEMENT})").options(footprint = create))
	// Nachfragen wegen BTCHLOA2 /keine Ahnung was das ist 
	lked1.dd(new DDStatement().name(&&LKD2LST).pass(true old))
	lked1.dd(new DDStatement().name(SYSUT1).options("shr"))
	// Nachfragen da monitroing und props vopn außen

}

def createDbrmcopyCommand(buildFile, logicalFile, member, logFile) {
	def dbrmcopy = new MVSExec().pgm("CZX2PZQL").parm("-IEBGENER")
	dbrmcopy.dd(new DDStatement().name("TASKLIB").dsn("{&BASEC}{CORT.EXITLIB}"))
	dbrmcopy.dd(new DDStatement().dsn("{&BASEB}{CORT.LINKLIB}"))
	// NAchfragen 550 nicht ganz klar
	dbrmcopy.dd(new DDStatement.name(SYSUT1).dsn("{&&DBRM}${&C1ELEMENT}").options(create ))
	dbrmcopy.dd(new DDStatement.name(SYSUT2).dsn("{&BASEB}{CORT.LINKLIB}"))
	dbrmcopy.dd(new DDStatement.name(SYSPRINT).dsn("DUMMY"))
	dbrmcopy.dd(new DDStatement.name(SYSIN).dsn("DUMMY"))
}
