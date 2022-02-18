CREATE PROCEDURE `virada_adquirente_cielo`()
BEGIN
    INSERT INTO ZoopParameters (`name`, `value`)
    VALUES ('force_acquirer', 'cielo')
    ON DUPLICATE KEY UPDATE value = VALUES(`value`);
    DELETE FROM ZoopParameters WHERE name = 'api_settings_last_update';
    INSERT INTO tb_dba_logs (`procedimento`, `executor`, `data`) VALUES ('virada_adquirente_cielo', user(), sysdate());