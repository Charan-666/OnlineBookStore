create database onlinebookstore;

use onlinebookstore;

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);


CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY IDENTITY,
    AuthorName VARCHAR(100) NOT NULL
);


CREATE TABLE Genres (
    GenreID INT PRIMARY KEY IDENTITY,
    GenreName VARCHAR(50) NOT NULL
);


CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY,
    Title VARCHAR(100) NOT NULL,
    GenreID INT,
    AuthorID INT,
    Price DECIMAL(10, 2),
    Stock INT DEFAULT 0,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Cart (
    CartID INT PRIMARY KEY IDENTITY,
    UserID INT,
    BookID INT,
    Quantity INT DEFAULT 1,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY,
    UserID INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY,
    OrderID INT,
    BookID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);


INSERT INTO Genres ( GenreName)
VALUES 
( 'Fiction'),
( 'Science'),
( 'Technology'),
( 'History'),
( 'Adventure'),
( 'Philosophy');


INSERT INTO Authors ( AuthorName)
VALUES
( 'J.K. Rowling'),
( 'Stephen Hawking'),
( 'Yuval Noah Harari'),
( 'Elon Musk'),
('J.R.R. Tolkien'),
( 'Paulo Coelho'),
( 'Dan Brown'),
( 'Bill Bryson');


INSERT INTO Users ( UserName, Email, Password)
VALUES
( 'Charan', 'charan@gmail.com', 'charan123'),
( 'hadiya', 'hadiya@gmail.com', 'hadiya123'),
( 'chaman', 'chaman@gmail.com', 'chaman123');



INSERT INTO Books ( Title, GenreID, AuthorID, Price, Stock)
VALUES
( 'Harry Potter', 1, 1, 499, 10),
( 'Brief History of Time', 2, 2, 399, 15),
( 'Sapiens', 4, 3, 450, 12),
( 'Elon Musk', 3, 4, 350, 7),
( 'The Hobbit', 5, 5, 299, 8),
( 'The Alchemist', 6, 6, 275, 20),
( 'Digital Fortress', 3, 7, 320, 14),
( 'A Brief History of Nearly Everything', 2, 8, 400, 6);




INSERT INTO Cart ( UserID, BookID, Quantity)
VALUES
( 1, 2, 1),
( 1, 3, 1),
( 2, 4, 2);


INSERT INTO Orders ( UserID, OrderDate, TotalAmount)
VALUES
( 1, GETDATE(), 949),
( 2, GETDATE(), 700);


INSERT INTO OrderDetails ( OrderID, BookID, Quantity)
VALUES
( 1, 2, 1),
( 1, 3, 1),
( 2, 4, 2);




--joins
SELECT 
  B.BookID,
  B.Title,
  A.AuthorName,
  G.GenreName,
  B.Price
FROM Books B
INNER JOIN Authors A ON B.AuthorID = A.AuthorID
INNER JOIN Genres G ON B.GenreID = G.GenreID;


SELECT 
  A.AuthorName,
  B.Title
FROM Authors A
LEFT JOIN Books B ON A.AuthorID = B.AuthorID;


SELECT 
  U.UserName,
  B.Title,
  B.Price,
  C.Quantity,
  (B.Price * C.Quantity) AS TotalPrice
FROM Cart C
INNER JOIN Users U ON C.UserID = U.UserID
INNER JOIN Books B ON C.BookID = B.BookID
WHERE U.UserID = 2;


--stored procedure

CREATE PROCEDURE GetAllBooks
AS
BEGIN
    SELECT 
        B.BookID, B.Title, A.AuthorName, G.GenreName, B.Price
    FROM Books B
    INNER JOIN Authors A ON B.AuthorID = A.AuthorID
    INNER JOIN Genres G ON B.GenreID = G.GenreID;
END

exec GetAllBooks;



CREATE PROCEDURE GetBooksByGenre
    @GenreName NVARCHAR(100)
AS
BEGIN
    SELECT 
        B.Title, A.AuthorName, G.GenreName, B.Price
    FROM Books B
    INNER JOIN Authors A ON B.AuthorID = A.AuthorID
    INNER JOIN Genres G ON B.GenreID = G.GenreID
    WHERE G.GenreName = @GenreName;
END


exec GetBooksByGenre @GenreName = 'Science';



CREATE PROCEDURE AddToCart
    @UserID INT,
    @BookID INT,
    @Quantity INT
AS
BEGIN
    INSERT INTO Cart (UserID, BookID, Quantity)
    VALUES (@UserID, @BookID, @Quantity);
END

EXEC AddToCart @UserID = 1, @BookID = 3, @Quantity = 2;

select * from Cart;


CREATE PROCEDURE ClearCart
    @UserID INT
AS
BEGIN
    DELETE FROM Cart WHERE UserID = @UserID;
END

EXEC ClearCart @UserID = 1;



--CTE


WITH BookDetails AS (
    SELECT 
        B.BookID, B.Title, A.AuthorName, G.GenreName, B.Price
    FROM Books B
    JOIN Authors A ON B.AuthorID = A.AuthorID
    JOIN Genres G ON B.GenreID = G.GenreID
)
SELECT * FROM BookDetails;



WITH AvgPriceCTE AS (
    SELECT AVG(Price) AS AvgPrice FROM Books
)
SELECT 
    B.Title, B.Price
FROM Books B, AvgPriceCTE
WHERE B.Price > AvgPriceCTE.AvgPrice;



WITH RankedBooks AS (
    SELECT 
        Title, Price,
        ROW_NUMBER() OVER (ORDER BY Price DESC) AS Rank
    FROM Books
)
SELECT * FROM RankedBooks
WHERE Rank <= 3;



--scalar functions

CREATE FUNCTION GetDiscountedPrice (@BookID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Price DECIMAL(10,2);
    SELECT @Price = Price FROM Books WHERE BookID = @BookID;

    RETURN @Price * 0.90; -- 10% discount
END;
GO

SELECT 
    Title, 
    Price AS OriginalPrice,
    dbo.GetDiscountedPrice(BookID) AS DiscountedPrice
FROM Books;


--lists books based on genre name(table valued function)
CREATE FUNCTION funGetBooksByGenre (@GenreName NVARCHAR(50))
RETURNS TABLE
AS
RETURN (
    SELECT 
        B.Title, B.Price, A.AuthorName
    FROM Books B
    JOIN Genres G ON B.GenreID = G.GenreID
    JOIN Authors A ON B.AuthorID = A.AuthorID
    WHERE G.GenreName = @GenreName
);
GO

SELECT * FROM dbo.funGetBooksByGenre('Science');


--triggers
use onlinebookstore
CREATE TABLE UserLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    Action VARCHAR(50),
    ActionDate DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER UserRegistrationLog
ON Users
AFTER INSERT
AS
BEGIN
    INSERT INTO UserLog (UserID, Action)
    SELECT UserID, 'Registered' FROM INSERTED;
END;


select * from UserLog;

insert into Users (Username,Email,Password) values('pradeep','pradeep@gmail.com','pradeep123');

use onlinebookstore;
select * from Users;




