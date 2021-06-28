

-- APEX

-- SQL Workshop > Utilities > Data Workshop: Add Customers

alter table products add product_desc varchar2(1000) null;

update products
set product_desc = 
    case
        when mod(product_id, 6) = 0 then 'Proin porttitor nulla vitae quam porttitor, ut tempus nibh finibus. Aliquam dignissim odio eget dolor convallis sollicitudin. Vestibulum pharetra sem nisi, non varius nibh accumsan eu. Cras luctus augue felis, non sodales ante viverra sed. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec pretium, metus et pellentesque auctor, libero dui fermentum odio, vel lobortis ipsum libero quis urna. Phasellus efficitur lectus a egestas tincidunt.'
        when mod(product_id, 6) = 1 then 'Donec neque orci, egestas eu efficitur vitae, sollicitudin in arcu. Nullam ornare suscipit est a fringilla. Nam dapibus leo nec dui suscipit, sit amet suscipit ipsum dictum. Nam aliquet at metus nec faucibus. Mauris ut purus nec lacus faucibus pharetra sed nec augue. Nulla laoreet felis non neque cursus, et dignissim turpis blandit. Sed imperdiet gravida turpis, nec auctor ligula vulputate id. Integer sem ipsum, dictum tempor risus a, pellentesque tempor ante. Vestibulum lobortis nulla enim. Vestibulum maximus enim mi, eu malesuada urna laoreet in. Nam molestie at tellus at faucibus. Phasellus eleifend dapibus mauris a faucibus. Integer vitae odio risus.'
        when mod(product_id, 6) = 2 then 'Aenean id pretium purus, quis finibus mi. Nunc dictum condimentum justo in condimentum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Fusce malesuada, felis vel scelerisque cursus, erat tellus suscipit magna, quis viverra lectus risus ullamcorper mi. Maecenas fringilla libero non tincidunt lobortis. Fusce viverra sed odio at tristique. In auctor vehicula velit ut aliquam. Maecenas eu nibh nunc. Phasellus diam tortor, sodales congue lacus eu, suscipit convallis leo. Quisque vitae nibh velit. Praesent tellus ex, pellentesque ut dolor sed, elementum euismod nulla. Vivamus ut metus at tellus euismod eleifend. Vivamus ac velit sit amet urna semper pulvinar non ac ex. Nulla ultricies gravida dignissim. Cras ut consectetur ligula. Phasellus mattis orci diam, eget sodales arcu dignissim ut.'
        when mod(product_id, 6) = 3 then 'Ut non dictum ante. In rutrum faucibus lectus vitae convallis. Nullam ac convallis lectus. Aenean malesuada, tortor dictum scelerisque ultrices, leo ligula malesuada neque, eget faucibus erat nibh placerat neque. Nunc quis leo cursus lorem scelerisque pellentesque sed sit amet nibh. Cras vulputate facilisis lorem, ut euismod metus scelerisque in. Aenean gravida tempor mollis. Vivamus dui quam, elementum a cursus sed, porta in massa.'
        when mod(product_id, 6) = 4 then 'Proin felis lorem, blandit sit amet cursus nec, aliquet at sem. In cursus a sem non malesuada. Ut sem lectus, mattis ut risus nec, bibendum fermentum eros. Donec ligula dolor, pellentesque id fermentum eu, rhoncus et magna. Donec nunc tortor, dapibus in tortor sit amet, luctus mollis ipsum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras finibus at enim ac elementum. Pellentesque nec elit ex. Donec imperdiet feugiat pretium. Suspendisse vitae laoreet leo. Maecenas finibus aliquet enim, sed sodales erat faucibus mattis. Duis placerat pellentesque odio ac gravida. Aenean mollis fermentum orci, vel iaculis leo aliquam et. Suspendisse sit amet pellentesque ex.'
        when mod(product_id, 5) = 5 then 'Proin felis lorem, blandit sit amet cursus nec, aliquet at sem. In cursus a sem non malesuada. Ut sem lectus, mattis ut risus nec, bibendum fermentum eros. Donec ligula dolor, pellentesque id fermentum eu, rhoncus et magna. Donec nunc tortor, dapibus in tortor sit amet, luctus mollis ipsum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras finibus at enim ac elementum. Pellentesque nec elit ex. Donec imperdiet feugiat pretium. Suspendisse vitae laoreet leo. Maecenas finibus aliquet enim, sed sodales erat faucibus mattis. Duis placerat pellentesque odio ac gravida. Aenean mollis fermentum orci, vel iaculis leo aliquam et. Suspendisse sit amet pellentesque ex.'
    end
;

alter table customers add phone_number varchar(255);
alter table customers add pin number;
alter table customers add address_street varchar2(255);
alter table customers add address_city varchar2(255);
alter table customers add address_province varchar2(255);


-- Cleanup
update customers 
set 
    phone_number = null,
    pin = null,
    address_street = null,
    address_city = null,
    address_province = null
;

update customers
set 
    phone_number = '403-265-2622',
    address_street = '401 9 Ave SW',
    address_city = 'Calgary',
    address_province = 'Alberta'
where full_name = 'Adam Martinez'
;


-- Upload everything to Github

-- Copy Vanilla App
-- Rename to KSCOPE21-LIVE

-- Disable zooming (left it on so I could do rest of vanilla setup)


-- Simulator
/**
- iOS iPhone 11 Pro
- Toggle bezel (off)
- input Keyboard: (off to start / On after to zoom out)
https://apex.oracle.com/pls/apex/giffy/r/kscope21-live01
*/
