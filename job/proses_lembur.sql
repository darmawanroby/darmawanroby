USE [msdb]
GO

/****** Object:  Job [ProsesLembur]    Script Date: 04/28/2021 09:27:42 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 04/28/2021 09:27:42 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ProsesLembur', 
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
/****** Object:  Step [proses]    Script Date: 04/28/2021 09:27:42 ******/
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
		@command=N'DECLARE @dTglAwal smalldatetime
DECLARE @dTglAkhir smalldatetime
DECLARE @iBulan TINYINT
DECLARE @iTahun SMALLINT

IF (SELECT TGL_LAPORAN+1 FROM taVARIABEL)>=DAY(GETDATE())
BEGIN
  select @dTglAwal = dbo.firstdate(dbo.firstdate(GETDATE())-1)
  select @dTglAkhir = (dbo.firstdate(GETDATE())-1)

  set @iBulan = MONTH(@dTglAkhir)
  set @iTahun = YEAR(@dTglAkhir)

  exec proc_LemburHarian @dTglAwal, @dTglAkhir

  exec proc_posting_ul @iBulan, @iTahun, ''''
END

update taTmpLembur set taTmpLembur.KODE_SATKER = taMappingDeputi.KODE_DEPUTI_BARU
from taTmpLembur left join taMappingDeputi on taTmpLembur.KODE_SATKER = taMappingDeputi.KODE_DEPARTEMEN
where tgl_masuk >= @dTglAwal and taTmpLembur.KODE_SATKER like ''X%''
and NOT taMappingDeputi.KODE_DEPUTI_BARU IS NULL --14046

  select @dTglAwal = dbo.firstdate(dbo.firstdate(GETDATE()))
  select @dTglAkhir = (dbo.lastdate(GETDATE()))
  set @iBulan = MONTH(@dTglAkhir)
  set @iTahun = YEAR(@dTglAkhir)

  exec proc_LemburHarian @dTglAwal, @dTglAkhir

  exec proc_posting_ul @iBulan, @iTahun, ''''

update taTmpLembur set taTmpLembur.KODE_SATKER = taMappingDeputi.KODE_DEPUTI_BARU
from taTmpLembur left join taMappingDeputi on taTmpLembur.KODE_SATKER = taMappingDeputi.KODE_DEPARTEMEN
where tgl_masuk >= @dTglAwal and taTmpLembur.KODE_SATKER like ''X%''
and NOT taMappingDeputi.KODE_DEPUTI_BARU IS NULL --14046
', 
		@database_name=N'DataReal', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'proses_lembur', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20210322, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'f01c0d81-6322-4a35-b815-5c1a5d364265'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


