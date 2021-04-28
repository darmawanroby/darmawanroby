USE [msdb]
GO

/****** Object:  Job [ProsesPelanggaran]    Script Date: 04/28/2021 09:46:33 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 04/28/2021 09:46:33 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ProsesPelanggaran', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'rekabio', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [HitunganMangkir]    Script Date: 04/28/2021 09:46:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'HitunganMangkir', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dTglAwal smalldatetime
DECLARE @dTglAkhir smalldatetime
DECLARE @iTahun smallint

set @iTahun = YEAR(GETDATE())
IF (@iTahun = 2012)
BEGIN
  select @dTglAwal = ''4/1/2012''
END
ELSE IF (month(GETDATE()) = 1)
BEGIN
  set @iTahun = @iTahun - 1
  select @dTglAwal = ''1/1/''+ CONVERT(CHAR(4),@iTahun)
END
ELSE
BEGIN
  select @dTglAwal = ''1/1/''+ CONVERT(CHAR(4),@iTahun)
END
  select @dTglAkhir = (dbo.firstdate(GETDATE())-1)

  exec proc_PelanggaranBulanan @dTglAwal , @dTglAkhir 
  exec proc_LambatCepatPulangBulanan @dTglAwal , @dTglAkhir 

DELETE FROM taPelanggaranBulanan WHERE BULAN = 0 AND TAHUN = @iTahun
INSERT INTO taPelanggaranBulanan
SELECT NIP, TAHUN, 0 AS BULAN, KONVERSI_MANGKIR AS JML_MANGKIR FROM q_LambatCepatPulang WHERE TAHUN = @iTahun

', 
		@database_name=N'DataReal', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'JadwalHitungMangkir', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=3, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20111006, 
		@active_end_date=99991231, 
		@active_start_time=60000, 
		@active_end_time=190000, 
		@schedule_uid=N'1d4012e7-05d0-4021-adc6-f43a968ecdc0'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


