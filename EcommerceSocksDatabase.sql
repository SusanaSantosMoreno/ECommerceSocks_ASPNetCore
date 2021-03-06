/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  Table [dbo].[Product_size]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_size](
	[Product_size_id] [int] NOT NULL,
	[Product_id] [int] NULL,
	[Size_id] [int] NULL,
 CONSTRAINT [PK_Product_size] PRIMARY KEY CLUSTERED 
(
	[Product_size_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Size]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Size](
	[Size_id] [int] NOT NULL,
	[Size_US] [nvarchar](100) NULL,
	[Size_EUR] [nvarchar](100) NULL,
	[Size_UK] [nvarchar](100) NULL,
 CONSTRAINT [PK__Size__0B3801782E09AAAC] PRIMARY KEY CLUSTERED 
(
	[Size_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Products_sizes]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Products_sizes] AS

SELECT Product_size_id, product_id, Product_size.size_id, Size_US, Size_EUR, Size_UK 
FROM Product_size JOIN Size ON Product_size.size_id = Size.size_id;

GO
/****** Object:  Table [dbo].[Category]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Category_id] [int] NOT NULL,
	[Category_name] [nvarchar](100) NULL,
	[Category_description] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[Category_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Product_id] [int] NOT NULL,
	[Product_name] [nvarchar](100) NULL,
	[Product_description] [text] NULL,
	[Product_price] [float] NULL,
	[Product_style] [nvarchar](100) NULL,
	[Product_print] [nvarchar](100) NULL,
	[Product_color] [nvarchar](100) NULL,
	[Product_category] [int] NULL,
	[Product_subcategory] [int] NULL,
	[Product_discount] [int] NULL,
	[Product_collection] [int] NULL,
 CONSTRAINT [PK__Product__9833FF92BC9FA1D8] PRIMARY KEY CLUSTERED 
(
	[Product_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subcategory]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subcategory](
	[Subcategory_id] [int] NOT NULL,
	[Subcategory_name] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Subcategory_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Product_Complete]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Product_Complete] AS
	SELECT P.*, C.Category_name, C.category_description, S.subcategory_name FROM PRODUCT P JOIN CATEGORY C ON 
	P.Product_category = C.category_id  JOIN SUBCATEGORY S ON
	P.Product_subcategory = S.subcategory_id
GO
/****** Object:  Table [dbo].[Order_details]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_details](
	[Order_Details_id] [int] IDENTITY(1,1) NOT NULL,
	[Order_id] [int] NULL,
	[Product_id] [int] NULL,
	[Size_id] [int] NULL,
	[Amount] [int] NULL,
 CONSTRAINT [PK_Order_details] PRIMARY KEY CLUSTERED 
(
	[Order_Details_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Orders_id] [int] NOT NULL,
	[Orders_user] [int] NULL,
	[Orders_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Orders_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[orders_View]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[orders_View] AS

SELECT od.*, o.orders_user, o.orders_date 
from order_details od join orders o ON od.order_id = o.orders_id;

GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[Addresses_id] [int] NOT NULL,
	[Addresses_user] [int] NOT NULL,
	[Addresses_name] [nvarchar](100) NULL,
	[Addresses_street] [nvarchar](100) NULL,
	[Addresses_cp] [nvarchar](5) NULL,
	[Addresses_country] [nvarchar](50) NULL,
	[Addresses_province] [nvarchar](50) NULL,
	[Addresses_city] [nvarchar](50) NULL,
 CONSTRAINT [PK__Addresse__1A73DF8A132CEE31] PRIMARY KEY CLUSTERED 
(
	[Addresses_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Collections]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Collections](
	[Collections_id] [int] NOT NULL,
	[Collections_name] [nvarchar](100) NULL,
	[Collections_discount] [int] NULL,
 CONSTRAINT [PK__Collecti__3EED988700D176A5] PRIMARY KEY CLUSTERED 
(
	[Collections_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[Discount_id] [int] NOT NULL,
	[Discount_name] [nvarchar](100) NULL,
	[Discount_value] [float] NULL,
	[Discount_code] [nvarchar](100) NULL,
	[Discount_date] [datetime] NULL,
 CONSTRAINT [PK__Discount__63D7679C82ECD635] PRIMARY KEY CLUSTERED 
(
	[Discount_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favorite]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favorite](
	[Favorite_id] [int] NOT NULL,
	[Favorite_product] [int] NULL,
	[Favorite_user] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Favorite_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 17/02/2021 13:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Users_id] [int] NOT NULL,
	[Users_name] [nvarchar](100) NULL,
	[Users_lastName] [nvarchar](100) NULL,
	[Users_email] [nvarchar](100) NOT NULL,
	[Users_password] [nvarchar](50) NOT NULL,
	[Users_nationality] [nvarchar](100) NULL,
	[Users_phone] [nvarchar](20) NULL,
	[Users_birthDate] [date] NULL,
	[Users_salt] [nvarchar](50) NULL,
	[Users_gender] [nchar](10) NULL,
 CONSTRAINT [PK__Users__EB6B2D456514B206] PRIMARY KEY CLUSTERED 
(
	[Users_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Addresses] ([Addresses_id], [Addresses_user], [Addresses_name], [Addresses_street], [Addresses_cp], [Addresses_country], [Addresses_province], [Addresses_city]) VALUES (157995, 519874581, N'Casa', N'Bulevar Nueva, 85, 08456, Viver I Serrateix', N'08456', N'Spain', N'Barcelona', N'Barcelona')
INSERT [dbo].[Addresses] ([Addresses_id], [Addresses_user], [Addresses_name], [Addresses_street], [Addresses_cp], [Addresses_country], [Addresses_province], [Addresses_city]) VALUES (685744, 519874581, N'Trabajo', N'Placeta Catalunya, 32, 04459, Illar', N'08456', N'Spain', N'Barcelona', N'Barcelona')
GO
INSERT [dbo].[Category] ([Category_id], [Category_name], [Category_description]) VALUES (1, N'MEN', N'The touch of color and fun your look needed. Trendy and premium quality socks for men.')
INSERT [dbo].[Category] ([Category_id], [Category_name], [Category_description]) VALUES (2, N'WOMEN', N'Discover our women''s socks collection full of color and cute designs. You won''t be able to choose just one!')
INSERT [dbo].[Category] ([Category_id], [Category_name], [Category_description]) VALUES (3, N'KIDS', N'Cool kids deserve cool socks! Discover our large collection of crazy socks for kids of all ages.')
INSERT [dbo].[Category] ([Category_id], [Category_name], [Category_description]) VALUES (4, N'PACKS', N'Create your own pack from over 100 designs
or buy one of our pre-made packs.')
GO
INSERT [dbo].[Collections] ([Collections_id], [Collections_name], [Collections_discount]) VALUES (1, N'BACK TO THE FUTURE', NULL)
GO
INSERT [dbo].[Discount] ([Discount_id], [Discount_name], [Discount_value], [Discount_code], [Discount_date]) VALUES (1, N'SAVE UP TO 30%', 30, N'SAVE-30', CAST(N'2021-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Discount] ([Discount_id], [Discount_name], [Discount_value], [Discount_code], [Discount_date]) VALUES (2, N'SAVE UP TO 20%', 20, N'SAVE-20', CAST(N'2021-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Discount] ([Discount_id], [Discount_name], [Discount_value], [Discount_code], [Discount_date]) VALUES (3, N'SAVE UP TO 10%', 10, N'SAVE-10', CAST(N'2021-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Discount] ([Discount_id], [Discount_name], [Discount_value], [Discount_code], [Discount_date]) VALUES (4, N'BUY ONE GET ONE 50% OFF', 50, N'SAVE-2-50', CAST(N'2021-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Discount] ([Discount_id], [Discount_name], [Discount_value], [Discount_code], [Discount_date]) VALUES (5, N'OUTLET -25%', 25, N'OUTLET-25', CAST(N'2021-01-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Favorite] ([Favorite_id], [Favorite_product], [Favorite_user]) VALUES (1, 2, 519874581)
INSERT [dbo].[Favorite] ([Favorite_id], [Favorite_product], [Favorite_user]) VALUES (2, 3, 519874581)
GO
SET IDENTITY_INSERT [dbo].[Order_details] ON 

INSERT [dbo].[Order_details] ([Order_Details_id], [Order_id], [Product_id], [Size_id], [Amount]) VALUES (9, 9701, 4, 4, 1)
INSERT [dbo].[Order_details] ([Order_Details_id], [Order_id], [Product_id], [Size_id], [Amount]) VALUES (10, 7436, 3, 3, 1)
INSERT [dbo].[Order_details] ([Order_Details_id], [Order_id], [Product_id], [Size_id], [Amount]) VALUES (11, 7612, 3, 4, 1)
INSERT [dbo].[Order_details] ([Order_Details_id], [Order_id], [Product_id], [Size_id], [Amount]) VALUES (12, 7612, 18, 3, 1)
INSERT [dbo].[Order_details] ([Order_Details_id], [Order_id], [Product_id], [Size_id], [Amount]) VALUES (13, 8524, 18, 3, 1)
SET IDENTITY_INSERT [dbo].[Order_details] OFF
GO
INSERT [dbo].[Orders] ([Orders_id], [Orders_user], [Orders_date]) VALUES (7436, 519874581, CAST(N'2021-02-15T20:45:55.893' AS DateTime))
INSERT [dbo].[Orders] ([Orders_id], [Orders_user], [Orders_date]) VALUES (7612, 519874581, CAST(N'2021-02-17T11:44:55.633' AS DateTime))
INSERT [dbo].[Orders] ([Orders_id], [Orders_user], [Orders_date]) VALUES (8524, 519874581, CAST(N'2021-02-17T13:13:04.823' AS DateTime))
INSERT [dbo].[Orders] ([Orders_id], [Orders_user], [Orders_date]) VALUES (9701, 519874581, CAST(N'2021-02-15T19:40:51.437' AS DateTime))
GO
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (1, N'FOX HEAD', N'78% Combed Cotton, 20% Polyamide, 2% Elastane. 
Not many designs will elevate your outfit like these fox socks. The orange fox head design, 
complete with red hair and perky ears, really contrast against the dramatic black background. 
Add the finishing touch to your outfit with these original socks. Don’t be without them!', 9, N'Casual', N'Animals', N'Black', 1, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (2, N'BLACK SHEEP', N'70% Combed Cotton, 28% Polyamide, 2% Elastane.
Don''t let anyone tell you you can''t be the black sheep of the herd, ok? Don''t be afraid to 
stand out and go out there rocking your wool and your funny Black Sheep socks.', 7.2, N'Casual', N'Animals', N'Turquoise', 1, 2, 2, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (3, N'EGGS', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.
Something smells good! These bacon and egg socks have our mouths watering. 
Even better, there are sausages too! What more do you need to get the day 
off to a great start? The diet can wait since these patterned socks are more 
than worth it. The best thing of all is that you get to choose between pink or blue. 
Up to you!', 7.2, N'Casual', N'Food', N'Pink', 2, 2, 2, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (4, N'OCTOPUS', N'78% Combed Cotton, 20% Polyamide, 2% Elastane', 9, N'Casual', N'Animals', N'Turquoise', 2, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (5, N'RIBBED', N'Classic mid-calf socks come in some original colors including 
striking yellow, red and purple to more neutral gray and black. This plain sock collection goes with 
everything and can be paired with both classic or more daring looks.', 6.3, N'Basics', N'Plain', N'Red', 1, 2, 1, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (6, N'RIBBED', N'Classic mid-calf socks come in some original colors including 
striking yellow, red and purple to more neutral gray and black. This plain sock collection goes with 
everything and can be paired with both classic or more daring looks.', 6.3, N'Basics', N'Plain', N'Yellow', 1, 2, 1, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (7, N'RIBBED', N'Classic mid-calf socks come in some original colors including 
striking yellow, red and purple to more neutral gray and black. This plain sock collection goes with 
everything and can be paired with both classic or more daring looks.', 6.3, N'Basics', N'Plain', N'Purple', 1, 2, 1, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (8, N'RIBBED', N'Classic mid-calf socks come in some original colors including 
striking yellow, red and purple to more neutral gray and black. This plain sock collection goes with 
everything and can be paired with both classic or more daring looks.', 6.3, N'Basics', N'Plain', N'Grey', 1, 2, 1, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (9, N'RIBBED', N'Classic mid-calf socks come in some original colors including 
striking yellow, red and purple to more neutral gray and black. This plain sock collection goes with 
everything and can be paired with both classic or more daring looks.', 6.3, N'Basics', N'Plain', N'Black', 1, 2, 1, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (10, N'KIDS JURASSIC BABY', N'70% Combed Cotton, 28% Polyamide, 2% Elastane
What better companion could there be to join kids on their adventures than Baby Dino? He''s freshly 
hatched but already wants to play. These baby dinosaur socks are not only the perfect pet, 
but combine effortlessly with their favorite shoes.', 7, N'Casual', N'Adventures', N'Blue', 3, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (11, N'KIDS KOALAS', N'70% Combed Cotton, 28% Polyamide, 2% Elastane
Up until now, you had to pay a visit to Australia to see a koala. Now you can enjoy having 
them close by thanks to these koala socks. Nobody can resist the charms of these adorable 
animals and the same goes for these original socks!', 7, N'Casual', N'Animals', N'Turquoise', 3, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (12, N'KIDS FAST FOOD', N'70% Combed Cotton, 28% Polyamide, 2% Elastane', 7, N'Casual', N'Food', N'Dark Red', 3, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (13, N'KIDS BREAD', N'70% Combed Cotton, 28% Polyamide, 2% Elastane.
There is nothing better than the feeling you get when you 
walk into a bakery and it smells like fresh bread. Truth? Kids love it. In addition, the black color 
accentuates the pattern of these cool socks and will make your day more fun. Let the feast begin with 
these bread and croissant socks!', 7, N'Casual', N'Food', N'Black', 3, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (14, N'KIDS CHILLIES', N'70% Combed Cotton, 28% Polyamide, 2% Elastane.', 7, N'Casual', N'Food', N'Blue', 3, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (15, N'Reef', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.Did you know that our planet''s coral 
			reefs started to form over 50 million years ago? Their spectacular colors come from 
			the millions of algae they are home to, and now they can adorn your feet. These funky 
			socks will make you feel like you''re gliding through tropical waters. Do you know what 
			else? These socks for men and women are the perfect gift for any nature lover.', 12, N'Casual', N'Nature', N'Blue', 2, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (16, N'Hedgehog', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.aa', 12, N'Casual', N'Animals', N'Turquoise', 2, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (17, N'Ribbed', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.Classic mid-calf socks come in 14 original 
			colors including striking yellow, red and purple to more neutral gray and black. This plain 
			sock collection goes with everything and can be paired with both classic or more daring looks.', 12, N'Basics', N'Plain', N'Pink', 2, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (18, N'Toucan Sock', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.YellowYellow', 12, N'Casual', N'Animals', N'Yellow', 2, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (19, N'Camo', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.Camouflage has made a triumphant 
			return this season as a truly iconic print. If you’re on the hunt for original socks, 
			these are the perfect pair. Featuring a camo pattern available in green and blue hues, 
			their versatile nature sets them apart. Perfect for enhancing work wear, as well as outfits 
			that are more casual.', 12, N'Casual', N'Travel', N'Dark Green', 1, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (20, N'Camo', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.Camouflage has made a triumphant return 
			this season as a truly iconic print. If you’re on the hunt for original socks, these are 
			the perfect pair. Featuring a camo pattern available in green and blue hues, their versatile 
			nature sets them apart. Perfect for enhancing work wear, as well as outfits that are more 
			casual.', 12, N'Casual', N'Travel', N'Blue', 2, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (21, N'Turtles', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.The Safari socks are made with premium 
			quality combed cotton to provide maximum comfort to your feet. Designed in collaboration 
			with our friends of B The Travel Brand, these socks will make you stand out with any look.
			Available for men and women in various sizes.', 12, N'Casual', N'Animals', N'Acqua', 2, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (22, N'Ghosts', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.', 12, N'Casual', N'Adventures', N'Black', 1, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (23, N'KH Galaxy', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.aa', 14, N'Casual', N'Adventures', N'Grey', 2, 1, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (24, N'KH Fast Food', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.aa', 14, N'Casual', N'Food', N'Dark Blue', 1, 1, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (25, N'KH Ribbed', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.Classic knee-high socks are casual 
			and minimalist in style. Perfect for any occasion, add an original touch to your 
			signature look. With 14 fun colors to choose from, you''re sure to find something 
			to suit all styles. Plain socks in every color!', 14, N'Basics', N'Plain', N'Dark Blue', 1, 1, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (26, N'KH Bees', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.We truly hope you are not allergic to bee stings, 
			because these little evil friends of us are gonna be all over your feet and calves! Go all in and 
			straight to the knee high version of the Bees design, one of the best sellers in The Farm collection.', 14, N'Casual', N'Animals', N'Grey', 2, 1, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (27, N'Athletic Wolf Ankle', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.Are you looking for a training gear that is as 
			fierce as your workouts? Don’t search no more! These sport ankle socks have been specially 
			designed to help you improve your performance while working out due to its strategic cushioning 
			in the toe, heel and footbed. Not only will this help you stay more comfortable while training, 
			but will also prevent the appearance of blisters and chuffing caused by sport shoes or long workouts. 
			Tennis, golf, football, gym… these athletic ankle socks are perfect for any practice, so score a sock 
			point with these Athletic Wolf Ankle!', 12, N'Athletic', N'Animals', N'White', 1, 3, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (28, N'Penguins Ankle', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.aa', 10, N'Casual', N'Animals', N'Red', 2, 3, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (29, N'Winter Deer', N'36% wool, 27% viscose, 25% nylon, 9% cashmere, 3% spandex 
Deer are one of the animals that most remind us of winter and with these fun socks, you can take them with you throughout the season. 
The original drawing of the deer is complemented by geometric figures that give it a very special touch. You dare?', 15, N'Casual', N'Animals', N'Light Blue', 1, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (30, N'Athletic Wolf', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.aa', 14, N'Athletic', N'Animals', N'White', 2, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (31, N'Salad', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.', 12, N'Casual', N'Food', N'Dark Pink', 2, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (32, N'Flamingo', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.TurquoiseTurquoise', 12, N'Casual', N'Animals', N'Turquoise', 2, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (33, N'HVN Polka Dot', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.Old-fashioned style? Cuteness overload?  
			There''s way too much opinions about polka dots, but still they are one of Harley''s 
			favourite prints! Some things just never get old so add this classic HVN Polka Dot 
			style to your wardrobe!', 12, N'Casual', N'Nature', N'Red', 1, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (34, N'Lizard Ankle', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.aa', 10, N'Casual', N'Nature', N'Blue', 2, 3, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (35, N'Hedgehog No Show', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.You''ve probably tried plenty 
			of animal themed socks over the years, but these no-show ones are in a league
			of their own thanks to these unique hedgehogs! If you''ve always fancied one 
			as a pet you''re in luck! Now you can take them home and get to know them. 
			They can''t wait to meet you!', 7, N'Casual', N'Animals', N'Turquoise', 2, 4, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (36, N'Mahou Beers No Show', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.Our Mahou Beer design now available 
			as no-show socks. Great summer looks, wearing sneakers or shoes...Who said no-show 
			socks were boring?', 7, N'Casual', N'Food', N'Green', 1, 4, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (37, N'Jurassic Dinos No Show', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.Attention all those dinosaur fans! 
			Far from extinct, these no-show socks are from our official Jurassic World collection, 
			ready to be worn daily. What better accessory for your closet is there than a T-Rex? 
			Take a walk on the wild side with these dinosaur socks!', 7, N'Casual', N'Animals', N'Blue', 1, 4, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (38, N'Acqualung', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.', 9, N'Casual', N'Adventures', N'Blue', 1, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (39, N'Kids Jurassic T-Rex', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.The ground is shaking... 
			T-Rex has arrived! He roams freely, clad in these original socks. The socks'' vivid 
			colors and stunning design will add a wild side to your kids'' outfits, 
			while their imagination will go crazy. Perfect fun for the whole family!', 7, N'Casual', N'Animals', N'Black', 3, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (40, N'Kids Parrots', N'36% wool, 27% viscose, 25% nylon, 9% cashmere, 3% spandex 
Every bird of great plumage was only a baby bird first, just like you are. So good news for you…the best is yet to come! 
Let your imagination fly with our Parrots socks and create the coolest outfits for school. ', 7, N'Casual', N'Food', N'Yellow', 3, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (41, N'Kids Eggs', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.
			¡Que bien huele! Se nos hace la boca agua… Con estos calcetines para niños de huevos y bacon, 
			tendrán toda la energía que necesitan para afrontar el día. Y además, ¡tienen salchichas! 
			Dale un toque divertido a su día a día con estos calcetines estampados. ¡Les encantarán!', 7, N'Casual', N'Food', N'Pink', 3, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (42, N'Kids Rock', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.Tonight is the big night, all stadium tickets 
			have been sold and everyone’s already on their seats waiting for your big performance. 
			Mics, drums and guitars are tuned…so let the show begin! Dreamers gonna dream, so what 
			if the stadium is just your home’s living room; the crowd, all your toys, 
			and instruments are just part of your imagination? Maybe today’s shows are just the rehearsals 
			for the big star that you will tomorrow become. Let your inner star out with these colorful 
			kids socks and rock out!', 7, N'Casual', N'Adventures', N'Red', 3, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (43, N'Kids Sailboat Racing', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.Las carreras de barcos es uno de los deportes más divertidos. 
			El viento, el océano, los colores de las velas… Con los calcetines originales Sailboat Racing, tu hijo se 
			sentirá como un auténtico marinero, pero ¡sin salir de casa! Quién sabe, quizá sea el ganador de la carrera 
			con estos divertidos calcetines para niños de barcos.', 7, N'Casual', N'Adventures', N'Blue', 3, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (44, N'Kids Pacha Cherries', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.
			Who said Pacha is not a kids'' business? The well-known Pacha Cherries are the perfect touch of 
			color and fun for the looks of the coolest kids! Thanks to Pacha, fruit will never be boring 
			again and every kid will want to bite the Cherries on these funky socks!', 7, N'Casual', N'Food', N'Black', 3, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (45, N'Dogs', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.aa', 12, N'Casual', N'Nature', N'Green', 1, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (46, N'Frida', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.', 12, N'Casual', N'Travel', N'Blue', 2, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (47, N'Wine', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.', 12, N'Casual', N'Food', N'Dark Red', 2, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (48, N'Byron Bay', N'78% Combed Cotton, 20% Polyamide, 2% Elastane.Some people say Byron Bay is 
			paradise on earth. This little coastal town is Australia''s easternmost point 
			and is more fashionable than ever. Live the Australian dream with these original 
			socks, and enjoy the waves, the weather, the environment and Byron Bay''s good vibes. 
			Be a real surfer and go with the flow with these colorful socks for men and women.', 12, N'Casual', N'Holliday', N'Turquoise', 2, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (49, N'GALAXY PACK', N'For lovers of outer space we have this pack that will add a "galactic" touch to your look', 39.95, N'Casual', N'Adventures', N'Various', 4, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (50, N'Safari Pack', N'We´re going on safari! Pack all your things and embark on this adventure 
with our socks inspired by a dangerous safari in the African savannah.', 39.95, N'Casual', N'Adventures', N'Various', 4, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (51, N'Chef Pack', N'Show off your culinary skills with these fun food socks. 
A cheese board, a Rioja or a good breakfast of eggs and bacon, why choose!	', 39.95, N'Casual', N'Food', N'Various', 4, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (52, N'Clean Ocean Pack', N'Inspired by the ocean and its creatures, show your friends that 
you are an animal lover with these fun socks!', 39.95, N'Casual', N'Animals', N'Various', 4, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (53, N'Pacha Pack', N'Looking for the perfect gift that represents the spirit of summer? 
Pacha Ibiza comes to your aid! This 4 Pacha Pack, which includes two 
versions of the Pacha Cherries model, accompanied by the Flower Power 
and Beach model, brings together the essence of the island and takes 
us back to the magical summer nights at the most legendary Pacha parties. 
Give this pack of funny socks to whoever you love the most, 
or take it with you as a souvenir! ', 39.95, N'Casual', N'Holliday', N'Various', 4, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (54, N'Babies Piglet Pack', N'If you were looking for the perfect pair of baby socks, here you’ve found the perfect pack instead!', 29.95, N'Casual', N'Holliday', N'Various', 4, 2, NULL, NULL)
INSERT [dbo].[Product] ([Product_id], [Product_name], [Product_description], [Product_price], [Product_style], [Product_print], [Product_color], [Product_category], [Product_subcategory], [Product_discount], [Product_collection]) VALUES (55, N'Babies Pup Pack', N'Expecting parents often get so overwhelmed with all they need to have ready 
before their baby comes, that can easily forget about the basic stuff…like cool baby socks!', 29.95, N'Casual', N'Holliday', N'Various', 4, 2, NULL, NULL)
GO
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (1, 1, 1)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (2, 1, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (3, 2, 1)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (4, 2, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (5, 3, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (6, 3, 4)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (7, 4, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (8, 4, 4)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (9, 5, 1)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (10, 5, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (11, 6, 1)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (12, 6, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (13, 7, 1)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (14, 7, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (15, 8, 1)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (16, 8, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (17, 9, 1)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (18, 9, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (19, 10, 5)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (20, 10, 6)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (21, 10, 7)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (22, 11, 5)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (23, 11, 6)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (24, 11, 7)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (25, 12, 5)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (26, 12, 6)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (27, 12, 7)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (28, 13, 5)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (29, 13, 6)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (30, 13, 7)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (31, 14, 5)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (32, 14, 6)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (33, 14, 7)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (34, 11, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (35, 11, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (36, 12, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (37, 12, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (38, 13, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (39, 13, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (40, 14, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (41, 14, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (42, 15, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (43, 15, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (44, 16, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (45, 16, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (46, 17, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (47, 17, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (48, 18, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (49, 19, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (50, 19, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (51, 20, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (52, 20, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (53, 21, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (54, 21, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (55, 22, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (56, 22, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (57, 23, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (58, 23, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (59, 24, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (60, 24, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (61, 25, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (62, 25, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (63, 26, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (64, 26, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (65, 27, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (66, 27, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (67, 28, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (68, 28, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (69, 29, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (70, 29, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (71, 30, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (72, 30, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (73, 31, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (74, 31, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (75, 32, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (76, 32, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (77, 33, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (78, 33, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (79, 34, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (80, 34, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (81, 35, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (82, 35, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (83, 36, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (84, 36, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (85, 37, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (86, 37, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (87, 38, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (88, 38, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (89, 39, 5)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (90, 39, 6)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (91, 39, 7)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (92, 40, 5)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (93, 40, 6)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (94, 40, 7)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (95, 41, 5)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (96, 41, 6)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (97, 41, 7)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (98, 42, 5)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (99, 42, 6)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (100, 42, 7)
GO
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (101, 43, 5)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (102, 43, 6)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (103, 43, 7)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (104, 44, 5)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (105, 44, 6)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (106, 44, 7)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (107, 45, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (108, 45, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (109, 46, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (110, 46, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (111, 47, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (112, 47, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (113, 48, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (114, 48, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (115, 49, 1)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (116, 49, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (117, 49, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (118, 49, 4)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (119, 50, 1)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (120, 50, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (121, 50, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (122, 50, 4)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (123, 51, 1)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (124, 51, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (125, 51, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (126, 51, 4)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (127, 52, 1)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (128, 52, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (129, 52, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (130, 52, 4)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (131, 53, 1)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (132, 53, 2)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (133, 53, 3)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (134, 53, 4)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (135, 53, 5)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (136, 53, 6)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (137, 53, 7)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (138, 54, 5)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (139, 54, 6)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (140, 54, 7)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (141, 55, 5)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (142, 55, 6)
INSERT [dbo].[Product_size] ([Product_size_id], [Product_id], [Size_id]) VALUES (143, 55, 7)
GO
INSERT [dbo].[Size] ([Size_id], [Size_US], [Size_EUR], [Size_UK]) VALUES (1, N'4.5-7.5', N'36-40', N'4-7')
INSERT [dbo].[Size] ([Size_id], [Size_US], [Size_EUR], [Size_UK]) VALUES (2, N'7.5-11.5', N'41-46', N'8-12')
INSERT [dbo].[Size] ([Size_id], [Size_US], [Size_EUR], [Size_UK]) VALUES (3, N'3.5-6.5', N'36-40', N'6-9')
INSERT [dbo].[Size] ([Size_id], [Size_US], [Size_EUR], [Size_UK]) VALUES (4, N'10-12.5', N'41-46', N'7-11')
INSERT [dbo].[Size] ([Size_id], [Size_US], [Size_EUR], [Size_UK]) VALUES (5, N'4.5-8', N'21-25', N'5.5-9')
INSERT [dbo].[Size] ([Size_id], [Size_US], [Size_EUR], [Size_UK]) VALUES (6, N'8.5-12', N'26-30', N'9.5-13')
INSERT [dbo].[Size] ([Size_id], [Size_US], [Size_EUR], [Size_UK]) VALUES (7, N'12.5-2.5', N'31-35', N'13.5-3.5')
GO
INSERT [dbo].[Subcategory] ([Subcategory_id], [Subcategory_name]) VALUES (1, N'KNEE-HIGH')
INSERT [dbo].[Subcategory] ([Subcategory_id], [Subcategory_name]) VALUES (2, N'MID-CALF')
INSERT [dbo].[Subcategory] ([Subcategory_id], [Subcategory_name]) VALUES (3, N'ANKLE')
INSERT [dbo].[Subcategory] ([Subcategory_id], [Subcategory_name]) VALUES (4, N'NO-SHOW')
GO
INSERT [dbo].[Users] ([Users_id], [Users_name], [Users_lastName], [Users_email], [Users_password], [Users_nationality], [Users_phone], [Users_birthDate], [Users_salt], [Users_gender]) VALUES (519874581, N'admin', N'admin', N'admin@gmail.com', N'1234', N'españa', N'659208749', CAST(N'2000-05-07' AS Date), NULL, N'F         ')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_principal_name]    Script Date: 17/02/2021 13:31:25 ******/
ALTER TABLE [dbo].[sysdiagrams] ADD  CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users_1]    Script Date: 17/02/2021 13:31:25 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [IX_Users_1] UNIQUE NONCLUSTERED 
(
	[Users_email] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK__Addresses_user] FOREIGN KEY([Addresses_user])
REFERENCES [dbo].[Users] ([Users_id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK__Addresses_user]
GO
ALTER TABLE [dbo].[Collections]  WITH CHECK ADD  CONSTRAINT [FK__Collectio__Colle__4E88ABD4] FOREIGN KEY([Collections_discount])
REFERENCES [dbo].[Discount] ([Discount_id])
GO
ALTER TABLE [dbo].[Collections] CHECK CONSTRAINT [FK__Collectio__Colle__4E88ABD4]
GO
ALTER TABLE [dbo].[Favorite]  WITH CHECK ADD  CONSTRAINT [FK__Favorite__Favori__00200768] FOREIGN KEY([Favorite_user])
REFERENCES [dbo].[Users] ([Users_id])
GO
ALTER TABLE [dbo].[Favorite] CHECK CONSTRAINT [FK__Favorite__Favori__00200768]
GO
ALTER TABLE [dbo].[Favorite]  WITH CHECK ADD  CONSTRAINT [FK__Favorite__Favori__02084FDA] FOREIGN KEY([Favorite_user])
REFERENCES [dbo].[Users] ([Users_id])
GO
ALTER TABLE [dbo].[Favorite] CHECK CONSTRAINT [FK__Favorite__Favori__02084FDA]
GO
ALTER TABLE [dbo].[Favorite]  WITH CHECK ADD  CONSTRAINT [FK__Favorite__Favori__33D4B598] FOREIGN KEY([Favorite_product])
REFERENCES [dbo].[Product] ([Product_id])
GO
ALTER TABLE [dbo].[Favorite] CHECK CONSTRAINT [FK__Favorite__Favori__33D4B598]
GO
ALTER TABLE [dbo].[Favorite]  WITH CHECK ADD  CONSTRAINT [FK__Favorite__Favori__7E37BEF6] FOREIGN KEY([Favorite_user])
REFERENCES [dbo].[Users] ([Users_id])
GO
ALTER TABLE [dbo].[Favorite] CHECK CONSTRAINT [FK__Favorite__Favori__7E37BEF6]
GO
ALTER TABLE [dbo].[Order_details]  WITH CHECK ADD  CONSTRAINT [FK__Order_det__Order__02FC7413] FOREIGN KEY([Order_id])
REFERENCES [dbo].[Orders] ([Orders_id])
GO
ALTER TABLE [dbo].[Order_details] CHECK CONSTRAINT [FK__Order_det__Order__02FC7413]
GO
ALTER TABLE [dbo].[Order_details]  WITH CHECK ADD  CONSTRAINT [FK__Order_det__Order__03F0984C] FOREIGN KEY([Order_id])
REFERENCES [dbo].[Orders] ([Orders_id])
GO
ALTER TABLE [dbo].[Order_details] CHECK CONSTRAINT [FK__Order_det__Order__03F0984C]
GO
ALTER TABLE [dbo].[Order_details]  WITH CHECK ADD  CONSTRAINT [FK__Order_det__Order__04E4BC85] FOREIGN KEY([Order_id])
REFERENCES [dbo].[Orders] ([Orders_id])
GO
ALTER TABLE [dbo].[Order_details] CHECK CONSTRAINT [FK__Order_det__Order__04E4BC85]
GO
ALTER TABLE [dbo].[Order_details]  WITH CHECK ADD  CONSTRAINT [FK__Order_det__Produ__3B75D760] FOREIGN KEY([Product_id])
REFERENCES [dbo].[Product] ([Product_id])
GO
ALTER TABLE [dbo].[Order_details] CHECK CONSTRAINT [FK__Order_det__Produ__3B75D760]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK__Orders__Orders_u__09A971A2] FOREIGN KEY([Orders_user])
REFERENCES [dbo].[Users] ([Users_id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK__Orders__Orders_u__09A971A2]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK__Orders__Orders_u__0A9D95DB] FOREIGN KEY([Orders_user])
REFERENCES [dbo].[Users] ([Users_id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK__Orders__Orders_u__0A9D95DB]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK__Orders__Orders_u__0B91BA14] FOREIGN KEY([Orders_user])
REFERENCES [dbo].[Users] ([Users_id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK__Orders__Orders_u__0B91BA14]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK__Product__Product__286302EC] FOREIGN KEY([Product_category])
REFERENCES [dbo].[Category] ([Category_id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK__Product__Product__286302EC]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK__Product__Product__29572725] FOREIGN KEY([Product_subcategory])
REFERENCES [dbo].[Subcategory] ([Subcategory_id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK__Product__Product__29572725]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK__Product__Product__4AB81AF0] FOREIGN KEY([Product_discount])
REFERENCES [dbo].[Discount] ([Discount_id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK__Product__Product__4AB81AF0]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK__Product__Product__4F7CD00D] FOREIGN KEY([Product_collection])
REFERENCES [dbo].[Collections] ([Collections_id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK__Product__Product__4F7CD00D]
GO
ALTER TABLE [dbo].[Product_size]  WITH CHECK ADD FOREIGN KEY([Product_id])
REFERENCES [dbo].[Product] ([Product_id])
GO
ALTER TABLE [dbo].[Product_size]  WITH CHECK ADD FOREIGN KEY([Size_id])
REFERENCES [dbo].[Size] ([Size_id])
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 17/02/2021 13:31:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 17/02/2021 13:31:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 17/02/2021 13:31:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 17/02/2021 13:31:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 17/02/2021 13:31:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 17/02/2021 13:31:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 17/02/2021 13:31:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
EXEC sys.sp_addextendedproperty @name=N'microsoft_database_tools_support', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sysdiagrams'
GO
