select * from categories;
select * from product;
-- 1. Tạo view gồm các thông tin mã danh mục, tên danh mục, mã sản phẩm, tên sản phẩm
create view vw_categories_product
as 
select c.catalog_id, c.catalog_names, p.product_id,p.product_name
from categories c join product p on c.catalog_id = p.catalog_id;

-- 2. Xóa view
drop view vw_categories_product;
select * from vw_categories_product;
-- 3. Tạo index trên cột product_name của bảng product
create index name_index on product(product_name);
-- 4. Xóa index name_index
drop index name_index on product;
-- 5. Tạo procedure cho phép lấy tất sản phẩm
DELIMITER &&
create procedure get_all_product(
	-- Khai báo các tham số vào (IN - mặc định), các tham số ra (out)
    -- Tham số ra đặc biệt: resultSet
)
BEGIN
	select * from product;
END; &&
call get_all_product();
-- 6. Tạo procedure cho phép lấy sản phẩm theo id
DELIMITER &&
create procedure get_product_by_Id(id char(5))
BEGIN
	select * from product where product_id = id;
END; &&
call get_product_by_id('P001');
-- 7. Viết procedure tính tổng số sản phẩm theo mã danh mục
DELIMITER &&
Create procedure get_cnt_product_by_catalogId(
	catalogId int,
    out cnt_product int
)
BEGIN
	set cnt_product = 
		(select count(product_id) from product where catalog_id = catalogid);
END; &&
call get_cnt_product_by_catalogId(1,@cnt);
select @cnt;
-- 8. Viết procedure cho phép thêm mới 1 sản phẩm
DELIMITER &&
create procedure create_product(
	productid char(5),
    productname varchar(100),
    catalogid int,
    productstatus bit
)
BEGIN
	insert into product
    values(productid,productname,catalogid,productstatus);
END; &&
call create_product('P004','Áo phông',1,1);
-- 9. Cập nhật sản phẩm
DELIMITER &&
create procedure update_product(
	productid char(5),
    productname varchar(100),
    catalogid int,
    productstatus bit
)
BEGIN
	update product
    set product_name = productname,
		catalog_id = catalogid,
        product_status = productstatus
	where product_id = productid;
END; &&
call update_product('P004','Áo phông 123',1,1);