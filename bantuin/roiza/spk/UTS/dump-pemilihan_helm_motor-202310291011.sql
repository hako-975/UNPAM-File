PGDMP  %        
        	    {            pemilihan_helm_motor    16.0    16.0 	    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24720    pemilihan_helm_motor    DATABASE     �   CREATE DATABASE pemilihan_helm_motor WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Indonesian_Indonesia.1252';
 $   DROP DATABASE pemilihan_helm_motor;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1259    24721 
   helm_motor    TABLE     �   CREATE TABLE public.helm_motor (
    id_helm_motor character varying NOT NULL,
    harga integer NOT NULL,
    rating integer NOT NULL,
    berat integer NOT NULL,
    tingkat_keamanan integer NOT NULL,
    ventilasi integer NOT NULL
);
    DROP TABLE public.helm_motor;
       public         heap    postgres    false    4            �          0    24721 
   helm_motor 
   TABLE DATA           f   COPY public.helm_motor (id_helm_motor, harga, rating, berat, tingkat_keamanan, ventilasi) FROM stdin;
    public          postgres    false    215   �                  2606    24727    helm_motor helm_motor_pk 
   CONSTRAINT     a   ALTER TABLE ONLY public.helm_motor
    ADD CONSTRAINT helm_motor_pk PRIMARY KEY (id_helm_motor);
 B   ALTER TABLE ONLY public.helm_motor DROP CONSTRAINT helm_motor_pk;
       public            postgres    false    215            �   `   x�]��� ߛb�`~����eD�<�v6��z"PqۏH�ȉRC��Y�c9�Z��XB�Zj(�Vo�UI3����ɺ[��u�����]�\�     