PGDMP                  	    {            pemilihan_restoran    16.0    16.0     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24606    pemilihan_restoran    DATABASE     �   CREATE DATABASE pemilihan_restoran WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Indonesian_Indonesia.1252';
 "   DROP DATABASE pemilihan_restoran;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1259    24614    restoran    TABLE       CREATE TABLE public.restoran (
    id_restoran character varying NOT NULL,
    rating_makanan character varying NOT NULL,
    harga integer NOT NULL,
    kualitas_pelayanan character varying NOT NULL,
    suasana character varying NOT NULL,
    lokasi character varying NOT NULL
);
    DROP TABLE public.restoran;
       public         heap    postgres    false    4            �          0    24614    restoran 
   TABLE DATA           k   COPY public.restoran (id_restoran, rating_makanan, harga, kualitas_pelayanan, suasana, lokasi) FROM stdin;
    public          postgres    false    215   �       �   f   x�=���0�K-Q�m����_G��5�YǀmsU�aaILh��)Ao��h��~Y9�}��mGedb��'#��0�sn�ʍ�+��Qn7F��E�q     