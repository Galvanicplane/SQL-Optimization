-- ===========================================
-- 1. SADECE OKUMA (READ-ONLY) ROLÜ
-- ===========================================
CREATE USER readonly_user WITH PASSWORD 'readpass123';

-- Veritabanı şemasını (public) sadece görebilsin
GRANT USAGE ON SCHEMA public TO readonly_user;

-- Varolan tüm tabloları SADECE okuyabilsin (SELECT)
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;

-- Gelecekte oluşturulacak tablolarda da okuma izinleri baki kalsın
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly_user;

-- TEST: Okuma modunda yazmaya çalışmak "Permission denied" hatası vermelidir.
-- SET ROLE readonly_user;
-- INSERT INTO airports (id) VALUES (1);   <-- (BU SATIR ÇALIŞMAZ, HATA VERİR)
-- RESET ROLE;


-- ===========================================
-- 2. TAM YETKİLİ (DML) ROLÜ
-- ===========================================
CREATE USER dml_user WITH PASSWORD 'dmlpass123';

-- Tüm şema ve tablolara erişimi açıyoruz
GRANT USAGE ON SCHEMA public TO dml_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO dml_user;

-- Auto-increment (SERIAL) alanlarına insert yapabilmesi için Sequence yetkileri de verilmelidir:
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO dml_user;

-- TEST: Normal şekilde veri girebildiğini test edebilirsiniz.
-- SET ROLE dml_user;
-- INSERT INTO airports (id, ident, name) VALUES (99999, 'TEST', 'Test data entry');
-- RESET ROLE;
