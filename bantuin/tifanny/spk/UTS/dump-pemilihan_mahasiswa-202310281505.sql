PGDMP  	                	    {            pemilihan_mahasiswa    16.0    16.0 	    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24669    pemilihan_mahasiswa    DATABASE     �   CREATE DATABASE pemilihan_mahasiswa WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Indonesian_Indonesia.1252';
 #   DROP DATABASE pemilihan_mahasiswa;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1259    24670 	   mahasiswa    TABLE       CREATE TABLE public.mahasiswa (
    id_mahasiswa character varying NOT NULL,
    prestasi integer NOT NULL,
    ekstrakurikuler integer NOT NULL,
    rekomendasi_dosen integer NOT NULL,
    rencana_studi integer NOT NULL,
    tes_kualifikasi integer NOT NULL
);
    DROP TABLE public.mahasiswa;
       public         heap    postgres    false    4            �          0    24670 	   mahasiswa 
   TABLE DATA              COPY public.mahasiswa (id_mahasiswa, prestasi, ekstrakurikuler, rekomendasi_dosen, rencana_studi, tes_kualifikasi) FROM stdin;
    public          postgres    false    215   �                  2606    24676    mahasiswa mahasiswa_pk 
   CONSTRAINT     ^   ALTER TABLE ONLY public.mahasiswa
    ADD CONSTRAINT mahasiswa_pk PRIMARY KEY (id_mahasiswa);
 @   ALTER TABLE ONLY public.mahasiswa DROP CONSTRAINT mahasiswa_pk;
       public            postgres    false    215            �   X   x�E��	�0��u����yC����6���_V��1����B[�Ù��f@�e���4�D=ˉ(�Cqh�{�NP�������7T�/����     