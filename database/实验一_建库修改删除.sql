-- 实验一：TPCH 数据库创建、修改、删除及重建

-- 1. 创建一个名为 TPCH 的数据库
-- 逻辑文件初始 10MB，最大 50MB，按 5% 增长
-- 日志文件初始 2MB，最大 5MB，按 1MB 增长
CREATE DATABASE TPCH
ON 
(
    NAME = 'TPCH_Data',
    FILENAME = 'D:\SQLdata\TPCH.mdf',
    SIZE = 10MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 5%
)
LOG ON
(
    NAME = 'TPCH_Log',
    FILENAME = 'D:\SQLdata\TPCH_log.ldf',
    SIZE = 2MB,
    MAXSIZE = 5MB,
    FILEGROWTH = 1MB
);
GO

-- 2. 对数据库的大小、增长方式做修改，最后复原
-- (1) 修改（扩大数据文件参数）
ALTER DATABASE TPCH
MODIFY FILE
(
    NAME = 'TPCH_Data',
    MAXSIZE = 100MB,
    FILEGROWTH = 10MB
);
GO

-- (2) 复原（还原原始参数，供后续实验二建表使用）
ALTER DATABASE TPCH
MODIFY FILE
(
    NAME = 'TPCH_Data',
    MAXSIZE = 50MB,
    FILEGROWTH = 5%
);
GO

-- 3. 删除所建数据库（演示删除与回滚）
USE master;
GO
-- 强制断开其他连接
ALTER DATABASE TPCH SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE TPCH;
GO

-- 4. 重建数据库，下次实验备用（实验二建表依赖此库）
CREATE DATABASE TPCH
ON 
(
    NAME = 'TPCH_Data',
    FILENAME = 'D:\SQLdata\TPCH.mdf',
    SIZE = 10MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 5%
)
LOG ON
(
    NAME = 'TPCH_Log',
    FILENAME = 'D:\SQLdata\TPCH_log.ldf',
    SIZE = 2MB,
    MAXSIZE = 5MB,
    FILEGROWTH = 1MB
);
GO

-- 切换至 TPCH 库，为实验二建表做准备
USE TPCH;
GO