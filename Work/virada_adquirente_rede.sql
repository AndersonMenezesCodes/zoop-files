CREATE PROCEDURE `virada_adquirente_rede`()
BEGIN
-- Rede
-- Banco do Zoop EMV Cloud
DELETE FROM ZoopParameters WHERE name = 'force_acquirer' AND deviceId = '0' AND EMVSerialNumber = '0';
DELETE FROM ZoopParameters WHERE name = 'api_settings_last_update';
INSERT INTO tb_dba_logs (procedimento, executor, data) VALUES ('virada_adquirente_rede', user(), sysdate());