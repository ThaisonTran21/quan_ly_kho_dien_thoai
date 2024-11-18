
CREATE DATABASE PhoneInventory
GO

USE PhoneInventory
GO

CREATE TABLE Users
(
    Username NVARCHAR(50) PRIMARY KEY not null,
    [Password] NVARCHAR(10) not null,
	FullName NVARCHAR(50) not null,
    Email NVARCHAR(255) not null,
    PhoneNumber NVARCHAR(10)not null,
    Adress NVARCHAR(255) not null,
    Position NVARCHAR(10) not null
)
GO

INSERT into Users
VALUES
    ('thao', '123', N'Nguyễn Thu Thảo', 'thao@gmail.com', '0123456789', 'Hai Duong', 'boss')
INSERT into Users
VALUES
    ('trinh', 'abc', N'Phạm Trường Trinh','trinh@gmail.com', '012356352', 'Nam Dinh', 'stocker')
INSERT into Users
VALUES
    ('tuan', 'abcd', N'Trần Ngọc Tuấn','tuan@gmail.com', '012356352', 'Hai Phong', 'saleclerk')


CREATE TABLE Brand -- của Điện thoại
(
    BrandID INT IDENTITY PRIMARY KEY not null,
    BrandName NVARCHAR(50) not null,
    BrandOrigin nvarchar(50) not null
)
GO


INSERT into Brand
    (BrandName, BrandOrigin)
VALUES
    ('APPLE', 'America'),
    ('SAMSUNG', 'Korea'),
    ('XIAOMI', 'China'),
    ('OPPO', 'China'),
    ('WINDOWS', 'America')

go


CREATE TABLE [Status]
(
    StatusID INT IDENTITY PRIMARY KEY,
    StatusName VARCHAR(20) NOT NULL
)



INSERT into [STATUS]
    (StatusName)
VALUES
    ('sole in'),
    ('sole out'),
    ('not sale')

CREATE TABLE Model
(
    ModelID INT IDENTITY PRIMARY KEY,
    ModelName NVARCHAR(60) not null,
	Color NVARCHAR(10) not null,
    Memory NVARCHAR(10) not null,
    BatteryCapacity NVARCHAR(10) not null,
	OperatingSystem NVARCHAR(10)not null,
	IsDelete Bit null default 0,
	-- Quantity INT CHECK(Quantity>100) not null, -- không thể hiện số lượng ở đây, muốn biết thì tạo view count()
	-- ngoài ra có rất nhiều thông tin về cấu hình khác

    StatusID INT not NULL DEFAULT 1 FOREIGN KEY REFERENCES [Status](StatusID),
    BrandID INT not null FOREIGN KEY REFERENCES Brand(BrandID),
    
    UNIQUE(ModelName,BrandID,Color, Memory, OperatingSystem)
)
GO



INSERT INTO Model 
    (ModelName, BrandID, Color, Memory, BatteryCapacity, OperatingSystem)
VALUES
    ('Model A', 3, 'Black', '8GB', '4000mAh', 'Android'),
    ('Model B', 1, 'White', '16GB', '5000mAh', 'iOS'),
    ('Model C', 2, 'Blue', '12GB', '4500mAh', 'Android'),
    ('Model D', 3, 'Red', '32GB', '6000mAh',  'Windows'),
    ('Model E', 1, 'Gold', '64GB', '5500mAh', 'iOS')

go
    

CREATE TABLE Batch -- lưu trữ từng đợt nhập
(
    BatchID INT IDENTITY PRIMARY KEY not null,
    Username  NVARCHAR(50) FOREIGN KEY REFERENCES Users(Username), -- người nhập hàng
    InputDate Date not null
)
GO



INSERT INTO Batch(InputDate, Username) VALUES
    ('2023-01-20', 'thao'),
    ('2023-01-20', 'trinh'),
    ('2023-02-10', 'trinh'),
    ('2023-01-20', 'trinh'),
    ('2023-02-27', 'thao'),
    ('2023-03-20', 'thao'),
    ('2023-01-23', 'trinh'),
    ('2023-01-15', 'thao'),
    ('2023-02-03', 'thao'),
    ('2023-02-21', 'trinh'),
    ('2023-01-24', 'trinh')
    

CREATE TABLE Origin
(
    OriginID INT IDENTITY PRIMARY KEY not null,
    Country NVARCHAR(10) not null
)
GO

INSERT INTO Origin(Country) VALUES ('Vietnam'), ('USA'), ('China'), ('Japan'), ('Germany'), ('Turkey')


CREATE TABLE OutStock -- Giống Order
(
    OutStock_id INT IDENTITY PRIMARY KEY,
    OutputDate DATETIME DEFAULT(GETDATE()) NOT NULL,
	CustomerEmail VARCHAR(255) NOT NULL, -- email bên nhận hàng
    Username NVARCHAR(50) NOT NULL FOREIGN KEY REFERENCES Users(Username), -- người xuất
	
)

INSERT INTO OutStock (OutputDate, Username, CustomerEmail)
VALUES
    ('2023-04-10', 'thao', 'kh@yahoo.com'),
    ('2023-04-11', 'trinh', 'kh@yahoo.com'),
    ('2023-04-11', 'trinh', 'kh@yahoo.com'),
    ('2023-04-12', 'trinh', 'kh@yahoo.com'),
    ('2023-04-19', 'thao' , 'kh@yahoo.com'),
    ('2023-04-10', 'tuan' , 'kh@yahoo.com'),
    ('2023-04-11', 'tuan', 'kh@yahoo.com' ),
    ('2023-04-12', 'tuan' , 'kh@yahoo.com'),

    ('2023-04-13', 'tuan' , 'kh@yahoo.com'),
    ('2023-04-14', 'tuan', 'kh@yahoo.com' ),
    ('2023-05-02', 'tuan', 'kh@yahoo.com' ),
    ('2023-05-08', 'trinh', 'kh@yahoo.com'),
    ('2023-05-11', 'trinh', 'kh@yahoo.com'),
    ('2023-06-25', 'tuan' , 'kh@yahoo.com'),
    ('2023-07-03', 'trinh', 'kh@yahoo.com'),
    (GETDATE(), 'tuan', 'kh@yahoo.com'),
    (GETDATE(), 'thao', 'kh@yahoo.com')


SELECT * FROM Users
SELECT * FROM Model
SELECT * FROM Batch
SELECT * FROM Model
SELECT * FROM OutStock

CREATE TABLE Phone
(
    MaDT INT IDENTITY not null PRIMARY KEY,
    ModelID INT not null,
    BatchID INT not null,
    OriginID INT not null,
	Price DECIMAL(20,2) not null, -- giá nhập
    YearManufacture DATE not null,
    IsDelete BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (ModelID) REFERENCES Model(ModelID),
    FOREIGN KEY (BatchID) REFERENCES Batch(BatchID),
    FOREIGN KEY (OriginID) REFERENCES Origin(OriginID),
)
GO

insert into Phone (ModelID, BatchID, OriginID, Price, YearManufacture) values
(1,1,1, 2000, '2019'),
(1,1,1, 2000, '2019'),
(1,1,1, 2000, '2019'),
(1,1,1, 2000, '2019'),
(1,1,1, 2000, '2019'),
(1,1,1, 2000, '2019'),
(2,1,1, 3000, '2019'),
(2,1,1, 3000, '2019'),
(2,1,1, 3000, '2019'),
(2,1,1, 3000, '2019'),
(2,1,1, 3000, '2019'),
(2,1,1, 3000, '2019'),
(2,1,1, 3000, '2019'),
(2,1,1, 3000, '2019'),
(1,2,3, 3000, '2019'),
(1,2,3, 3000, '2019'),
(1,2,3, 3000, '2019'),
(1,2,3, 3000, '2019'),
(1,2,3, 3000, '2019'),
(1,2,3, 3000, '2019'),
(1,2,3, 3000, '2019'),
(3,2,4, 6000, '2019'),
(3,2,4, 6000, '2019'),
(3,2,4, 6000, '2019'),
(3,2,4, 6000, '2019'),
(3,2,4, 6000, '2019'),
(3,2,4, 6000, '2019'),
(3,2,4, 6000, '2019'),
(3,2,4, 6000, '2019')
go



CREATE TABLE OutStockDetail
(
    OutStock_id INT not null FOREIGN KEY REFERENCES OutStock(OutStock_id),
    MaDT INT NOT NULL FOREIGN KEY REFERENCES Phone(MaDT) UNIQUE,
    PRIMARY KEY(OutStock_id, MaDT)
)


 INSERT INTO OutStockDetail VALUES
     --(1,2),(1,3),(1,4),
     (2,6),(2,7),(2,5),
     (1,8),(1,9),(2,10),
     (2,12),(3,13),(3,11),
     (3,14),(3,15),(4,16),
     (3,19),(6,18),(1,17),
     (1,20),(3,21),(2,22)
 
SELECT * FROM Phone
select * from OutStockDetail
go


----------------------------------------------------------
create view V_OutStockDetail
	as select ot.*, p.MaDT, p.ModelID, p.Price, ori.Country, p.YearManufacture from OutStock ot
	left join OutStockDetail otd on ot.OutStock_id = otd.OutStock_id
	inner join Phone p on p.MaDT = otd.MaDT
	inner join Origin ori on ori.OriginID = p.OriginID
go
select * from V_OutStockDetail where OutStock_id = 1
go


create or alter view V_OutStockAmount
	as select ot.OutStock_id, ot.OutputDate, ot.Username, ot.CustomerEmail, Count(p.MaDT) as Quantity, SUM(p.Price) as Amount from OutStock ot
	left join OutStockDetail otd on ot.OutStock_id = otd.OutStock_id
	left join Phone p on p.MaDT = otd.MaDT
	group by ot.OutStock_id, ot.OutputDate, ot.Username, ot.CustomerEmail
go
select * from V_OutStockAmount
go

--------------------------------------------

create or alter view V_BatchDetail
	as select b.*,  p.MaDT, p.ModelID, p.Price, ori.Country, p.YearManufacture from Batch b
	left join Phone p on p.BatchID = b.BatchID
	left join Origin ori on ori.OriginID = p.OriginID

go

create or alter view V_BatchModelAmout
	as select b.BatchID, b.InputDate, b.Username, p.ModelID, Count(p.MaDT) as Quantity, SUM( p.Price) as Amount from Batch b
	left join Phone p on p.BatchID = b.BatchID
	left join Origin ori on ori.OriginID = p.OriginID
	group by b.BatchID, b.InputDate, b.Username, p.ModelID
go
select * from V_BatchModelAmout
go

-- -- --
select BatchID, InputDate, Username,
	Count(ModelID) as 'SL Model',
	SUM(Quantity) as 'Tổng SLSP',
	SUM(Amount) as 'Tổng giá'
	from V_BatchModelAmout 
	group by BatchID, InputDate, Username
  
    