USE [msdb]
GO

/****** Object:  Job [ProsesTK]    Script Date: 04/28/2021 09:47:07 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 04/28/2021 09:47:07 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ProsesTK', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'WIN-NBLGQGR5FPS\Administrator', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [proses]    Script Date: 04/28/2021 09:47:08 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'proses', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @iBulan TINYINT
DECLARE @iTahun SMALLINT
DECLARE @iTahunSebelumnya SMALLINT
DECLARE @iBulanSebelumnya SMALLINT

SET @iBulan = MONTH(getdate())
SET @iTahun = YEAR(getdate())

IF @iBulan = 1
BEGIN
	SET @iTahunSebelumnya = @iTahun -1
	SET @iBulanSebelumnya = 12
END
ELSE
BEGIN
	SET @iTahunSebelumnya = @iTahun
	SET @iBulanSebelumnya = @iBulan - 1
END


IF (SELECT TGL_LAPORAN+1 FROM taVARIABEL)>=DAY(GETDATE())
BEGIN
--	exec proc_posting_tk @iBulanSebelumnya, @iTahunSebelumnya, 1, ''''
	exec proc_posting_tk_satker @iBulanSebelumnya, @iTahunSebelumnya, 1, ''001''
	exec proc_posting_tk_satker @iBulanSebelumnya, @iTahunSebelumnya, 1, ''002''
	exec proc_posting_tk_satker @iBulanSebelumnya, @iTahunSebelumnya, 1, ''003''
	exec proc_posting_tk_satker @iBulanSebelumnya, @iTahunSebelumnya, 1, ''005''
	exec proc_posting_tk_satker @iBulanSebelumnya, @iTahunSebelumnya, 1, ''006''

	exec proc_posting_tk_satker @iBulanSebelumnya, @iTahunSebelumnya, 1, ''000''
	exec proc_posting_tk_satker @iBulanSebelumnya, @iTahunSebelumnya, 1, ''007''
	exec proc_posting_tk_satker @iBulanSebelumnya, @iTahunSebelumnya, 1, ''008''
	exec proc_posting_tk_satker @iBulanSebelumnya, @iTahunSebelumnya, 1, ''009''
	exec proc_posting_tk_satker @iBulanSebelumnya, @iTahunSebelumnya, 1, ''010''

exec proc_cek_perubahan_tk @iBulanSebelumnya,  @iTahunSebelumnya
END

exec proc_posting_tk @iBulan, @iTahun, 1, ''''

/*
DECLARE @dTglAwal smalldatetime
DECLARE @dTglAkhir smalldatetime

IF (SELECT TGL_LAPORAN+1 FROM taVARIABEL)>DAY(GETDATE())
BEGIN
  select @dTglAwal = dbo.firstdate(dbo.firstdate(GETDATE())-1)
  select @dTglAkhir = (dbo.firstdate(GETDATE())-1)

  exec proc_ProsesTK @dTglAwal, @dTglAkhir
/*
update taTmpTK
set nilai_grade = (nilai_grade * 50 /100), nilai_tk = (nilai_grade * 50 /100) * tk_diterima /100, pajak_tk = dbo.PajakTK((nilai_grade * 50 /100) * tk_diterima /100)
where nip = ''180005050'' and tahun = year(@dTglAwal) and bulan = month(@dTglAwal)
*/
END

  select @dTglAwal = dbo.firstdate(dbo.firstdate(GETDATE()))
  select @dTglAkhir = (dbo.lastdate(GETDATE()))

  exec proc_ProsesTK @dTglAwal, @dTglAkhir
/*
update taTmpTK
set nilai_grade = (nilai_grade * 50 /100), nilai_tk = (nilai_grade * 50 /100) * tk_diterima /100, pajak_tk = dbo.PajakTK((nilai_grade * 50 /100) * tk_diterima /100)
where nip = ''180005050'' and tahun = year(@dTglAwal) and bulan = month(@dTglAwal)
*/
*/

exec proc_cek_perubahan_tk @iBulan,  @iTahun
', 
		@database_name=N'DataReal', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


