

-- Creating table 'Addresses'
CREATE TABLE [dbo].[Addresses] (
    [address_id] int IDENTITY(1,1) NOT NULL,
    [line_1_num_building] nvarchar(max)  NOT NULL,
    [line_2_num_street] nvarchar(max)  NOT NULL,
    [line_3_area_locality] nvarchar(max)  NOT NULL,
    [city] nvarchar(max)  NOT NULL,
    [zip_postcode] nvarchar(max)  NOT NULL,
    [state_province_country] nvarchar(max)  NOT NULL,
    [iso_country_code] nvarchar(max)  NOT NULL,
    [other_address_details] nvarchar(max)  NULL
);
GO

-- Creating table 'Customer_Address'
CREATE TABLE [dbo].[Customer_Address] (
    [customer_id] int  NULL,
    [address_id] int  NULL,
    [date_from] int IDENTITY(1,1) NOT NULL,
    [address_type_code] int  NULL,
    [date_to] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Customer_Orders'
CREATE TABLE [dbo].[Customer_Orders] (
    [order_id] int IDENTITY(1,1) NOT NULL,
    [customer_id] int  NOT NULL,
    [customer_payment_method_id] nvarchar(max)  NOT NULL,
    [order_status_code] nvarchar(max)  NOT NULL,
    [date_order_placed] int  NOT NULL,
    [date_order_paid] nvarchar(max)  NOT NULL,
    [der_order_price] nvarchar(max)  NOT NULL,
    [other_order_details] nvarchar(max)  NULL
);
GO

-- Creating table 'Customer_Orders_Delivery'
CREATE TABLE [dbo].[Customer_Orders_Delivery] (
    [date_reported] nvarchar(max)  NOT NULL,
    [delivery_status_code]  int  IDENTITY(1,1) NOT NULL,
    [order_id] int  NOT NULL
);
GO

-- Creating table 'Customer_Orders_Products'
CREATE TABLE [dbo].[Customer_Orders_Products] (
    [order_id] int IDENTITY(1,1) NOT NULL,
    [product_id] int  NOT NULL,
    [quantity] nvarchar(1)  NULL,
    [comments] nvarchar(1)  NULL,
    [Customer_Orders_order_id] int  NOT NULL
);
GO

-- Creating table 'Customers'
CREATE TABLE [dbo].[Customers] (
    [customer_id] int IDENTITY(1,1) NOT NULL,
    [customer_name] nvarchar(max)  NOT NULL,
    [customer_phone] nvarchar(max)  NOT NULL,
    [customer_email] nvarchar(max)  NOT NULL,
    [other_customer_details] nvarchar(max)  NULL
);
GO

-- Creating table 'Products'
CREATE TABLE [dbo].[Products] (
    [product_id] int IDENTITY(1,1) NOT NULL,
    [product_type_code] nvarchar(max)  NOT NULL,
    [procuct_price] decimal(19,4)  NOT NULL,
    [other_product_details] nvarchar(max)  NULL,
    [supplier_id] int  NOT NULL
);
GO

-- Creating table 'Ref_Address_Types'
CREATE TABLE [dbo].[Ref_Address_Types] (
    [address_type_code] int IDENTITY(1,1) NOT NULL,
    [address_type_description] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Suppliers'
CREATE TABLE [dbo].[Suppliers] (
    [supplier_id] int  NOT NULL,
    [supplier_name] nchar(10)  NOT NULL,
    [other_supplier_details] nchar(10)  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [address_id] in table 'Addresses'
ALTER TABLE [dbo].[Addresses]
ADD CONSTRAINT [PK_Addresses]
    PRIMARY KEY CLUSTERED ([address_id] ASC);
GO

-- Creating primary key on [date_from] in table 'Customer_Address'
ALTER TABLE [dbo].[Customer_Address]
ADD CONSTRAINT [PK_Customer_Address]
    PRIMARY KEY CLUSTERED ([date_from] ASC);
GO

-- Creating primary key on [order_id] in table 'Customer_Orders'
ALTER TABLE [dbo].[Customer_Orders]
ADD CONSTRAINT [PK_Customer_Orders]
    PRIMARY KEY CLUSTERED ([order_id] ASC);
GO

-- Creating primary key on [order_id] in table 'Customer_Orders_Delivery'
ALTER TABLE [dbo].[Customer_Orders_Delivery]
ADD CONSTRAINT [PK_Customer_Orders_Delivery]
    PRIMARY KEY CLUSTERED ([order_id] ASC);
GO

-- Creating primary key on [order_id] in table 'Customer_Orders_Products'
ALTER TABLE [dbo].[Customer_Orders_Products]
ADD CONSTRAINT [PK_Customer_Orders_Products]
    PRIMARY KEY CLUSTERED ([order_id] ASC);
GO

-- Creating primary key on [customer_id] in table 'Customers'
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [PK_Customers]
    PRIMARY KEY CLUSTERED ([customer_id] ASC);
GO

-- Creating primary key on [product_id] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [PK_Products]
    PRIMARY KEY CLUSTERED ([product_id] ASC);
GO

-- Creating primary key on [address_type_code] in table 'Ref_Address_Types'
ALTER TABLE [dbo].[Ref_Address_Types]
ADD CONSTRAINT [PK_Ref_Address_Types]
    PRIMARY KEY CLUSTERED ([address_type_code] ASC);
GO

-- Creating primary key on [supplier_id] in table 'Suppliers'
ALTER TABLE [dbo].[Suppliers]
ADD CONSTRAINT [PK_Suppliers]
    PRIMARY KEY CLUSTERED ([supplier_id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [address_id] in table 'Customer_Address'
ALTER TABLE [dbo].[Customer_Address]
ADD CONSTRAINT [FK_AddressesCustomer_Address]
    FOREIGN KEY ([address_id])
    REFERENCES [dbo].[Addresses]
        ([address_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_AddressesCustomer_Address'
CREATE INDEX [IX_FK_AddressesCustomer_Address]
ON [dbo].[Customer_Address]
    ([address_id]);
GO

-- Creating foreign key on [customer_id] in table 'Customer_Address'
ALTER TABLE [dbo].[Customer_Address]
ADD CONSTRAINT [FK_CustomersCustomer_Address]
    FOREIGN KEY ([customer_id])
    REFERENCES [dbo].[Customers]
        ([customer_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CustomersCustomer_Address'
CREATE INDEX [IX_FK_CustomersCustomer_Address]
ON [dbo].[Customer_Address]
    ([customer_id]);
GO

-- Creating foreign key on [address_type_code] in table 'Customer_Address'
ALTER TABLE [dbo].[Customer_Address]
ADD CONSTRAINT [FK_Ref_Address_TypesCustomer_Address]
    FOREIGN KEY ([address_type_code])
    REFERENCES [dbo].[Ref_Address_Types]
        ([address_type_code])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Ref_Address_TypesCustomer_Address'
CREATE INDEX [IX_FK_Ref_Address_TypesCustomer_Address]
ON [dbo].[Customer_Address]
    ([address_type_code]);
GO

-- Creating foreign key on [customer_id] in table 'Customer_Orders'
ALTER TABLE [dbo].[Customer_Orders]
ADD CONSTRAINT [FK_CustomersCustomer_Orders]
    FOREIGN KEY ([customer_id])
    REFERENCES [dbo].[Customers]
        ([customer_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CustomersCustomer_Orders'
CREATE INDEX [IX_FK_CustomersCustomer_Orders]
ON [dbo].[Customer_Orders]
    ([customer_id]);
GO

-- Creating foreign key on [product_id] in table 'Customer_Orders_Products'
ALTER TABLE [dbo].[Customer_Orders_Products]
ADD CONSTRAINT [FK_ProductsCustomer_Orders_Products]
    FOREIGN KEY ([product_id])
    REFERENCES [dbo].[Products]
        ([product_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductsCustomer_Orders_Products'
CREATE INDEX [IX_FK_ProductsCustomer_Orders_Products]
ON [dbo].[Customer_Orders_Products]
    ([product_id]);
GO

-- Creating foreign key on [supplier_id] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [FK_SupplierProducts]
    FOREIGN KEY ([supplier_id])
    REFERENCES [dbo].[Suppliers]
        ([supplier_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_SupplierProducts'
CREATE INDEX [IX_FK_SupplierProducts]
ON [dbo].[Products]
    ([supplier_id]);
GO

-- Creating foreign key on [Customer_Orders_order_id] in table 'Customer_Orders_Delivery'
ALTER TABLE [dbo].[Customer_Orders_Delivery]
ADD CONSTRAINT [FK_Customer_OrdersCustomer_Orders_Delivery]
    FOREIGN KEY ([Customer_Orders_order_id])
    REFERENCES [dbo].[Customer_Orders]
        ([order_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Customer_OrdersCustomer_Orders_Delivery'
CREATE INDEX [IX_FK_Customer_OrdersCustomer_Orders_Delivery]
ON [dbo].[Customer_Orders_Delivery]
    ([Customer_Orders_order_id]);
GO

-- Creating foreign key on [Customer_Orders_order_id] in table 'Customer_Orders_Products'
ALTER TABLE [dbo].[Customer_Orders_Products]
ADD CONSTRAINT [FK_Customer_OrdersCustomer_Orders_Products]
    FOREIGN KEY ([Customer_Orders_order_id])
    REFERENCES [dbo].[Customer_Orders]
        ([order_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Customer_OrdersCustomer_Orders_Products'
CREATE INDEX [IX_FK_Customer_OrdersCustomer_Orders_Products]
ON [dbo].[Customer_Orders_Products]
    ([Customer_Orders_order_id]);
GO

-- --------------------------------------------------
-- Script has ended
-- ----------------------------------