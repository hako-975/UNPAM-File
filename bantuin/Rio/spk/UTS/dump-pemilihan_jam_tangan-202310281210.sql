PGDMP      
            	    {            pemilihan_jam_tangan    16.0    16.0 	    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24653    pemilihan_jam_tangan    DATABASE     �   CREATE DATABASE pemilihan_jam_tangan WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Indonesian_Indonesia.1252';
 $   DROP DATABASE pemilihan_jam_tangan;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1259    24654 
   jam_tangan    TABLE     �   CREATE TABLE public.jam_tangan (
    id_jam_tangan character varying NOT NULL,
    harga integer NOT NULL,
    rating numeric NOT NULL,
    baterai integer NOT NULL,
    kedalaman_tahan_air integer NOT NULL,
    berat integer NOT NULL
);
    DROP TABLE public.jam_tangan;
       public         heap    postgres    false    4            �          0    24654 
   jam_tangan 
   TABLE DATA           g   COPY public.jam_tangan (id_jam_tangan, harga, rating, baterai, kedalaman_tahan_air, berat) FROM stdin;
    public          postgres    false    215   �                  2606    24660    jam_tangan jam_tangan_pk 
   CONSTRAINT     a   ALTER TABLE ONLY public.jam_tangan
    ADD CONSTRAINT jam_tangan_pk PRIMARY KEY (id_jam_tangan);
 B   ALTER TABLE ONLY public.jam_tangan DROP CONSTRAINT jam_tangan_pk;
       public            postgres    false    215            �   �   x�M�;!��0� ��&�p���wԷFJ�ޏ"�~|�
���1�l��-�0*T���o��y���1�Y�q�vD���zj�&#���
��%�e}P�um�9j�j���*�#&�Q>W)�i�*J     