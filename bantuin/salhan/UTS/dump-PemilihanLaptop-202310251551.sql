PGDMP      3            	    {            PemilihanLaptop    16.0    16.0 	    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24597    PemilihanLaptop    DATABASE     �   CREATE DATABASE "PemilihanLaptop" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Indonesian_Indonesia.1252';
 !   DROP DATABASE "PemilihanLaptop";
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1259    24598    laptop    TABLE       CREATE TABLE public.laptop (
    laptop character varying NOT NULL,
    harga character varying NOT NULL,
    ram character varying NOT NULL,
    kapasitasbaterai character varying NOT NULL,
    processor character varying NOT NULL,
    penyimpananinternal character varying NOT NULL
);
    DROP TABLE public.laptop;
       public         heap    postgres    false    4            �          0    24598    laptop 
   TABLE DATA           f   COPY public.laptop (laptop, harga, ram, kapasitasbaterai, processor, penyimpananinternal) FROM stdin;
    public          postgres    false    215   �                  2606    24604    laptop laptop_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.laptop
    ADD CONSTRAINT laptop_pk PRIMARY KEY (laptop);
 :   ALTER TABLE ONLY public.laptop DROP CONSTRAINT laptop_pk;
       public            postgres    false    215            �   �   x�M�;!��a"����I��n��+^,Hx<����Ũ���1OGg�+,�nP���B�h��2�c�S�:ԦȆ�Ή
����cU�%;��(-��b��ˌ'q}┘����Ђ��_)�D<�     