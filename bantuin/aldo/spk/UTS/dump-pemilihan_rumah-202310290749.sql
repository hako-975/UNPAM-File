PGDMP  "    1            	    {            pemilihan_rumah    16.0    16.0 	    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24701    pemilihan_rumah    DATABASE     �   CREATE DATABASE pemilihan_rumah WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Indonesian_Indonesia.1252';
    DROP DATABASE pemilihan_rumah;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1259    24707    rumah    TABLE     �   CREATE TABLE public.rumah (
    id_rumah character varying NOT NULL,
    harga bigint NOT NULL,
    lokasi integer NOT NULL,
    luas_tanah integer NOT NULL,
    luas_bangunan integer NOT NULL,
    fasilitas integer NOT NULL
);
    DROP TABLE public.rumah;
       public         heap    postgres    false    4            �          0    24707    rumah 
   TABLE DATA           ^   COPY public.rumah (id_rumah, harga, lokasi, luas_tanah, luas_bangunan, fasilitas) FROM stdin;
    public          postgres    false    215   X                  2606    24713    rumah rumah_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.rumah
    ADD CONSTRAINT rumah_pk PRIMARY KEY (id_rumah);
 8   ALTER TABLE ONLY public.rumah DROP CONSTRAINT rumah_pk;
       public            postgres    false    215            �   �   x�E��!C�N1+`fh���_�:d�P$?;�I���@}���M�}��.����"����f�a$�B/@�=9J�^�嬈pG��0%��Tmk�d����_�ս�v�c丈�s��cf?�q-;     