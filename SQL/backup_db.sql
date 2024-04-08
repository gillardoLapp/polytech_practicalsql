--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5
-- Dumped by pg_dump version 16.2

-- Started on 2024-04-08 16:08:01

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS cta4;
--
-- TOC entry 3990 (class 1262 OID 19735)
-- Name: cta4; Type: DATABASE; Schema: -; Owner: cloudsqlsuperuser
--

CREATE DATABASE cta4 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF8';


ALTER DATABASE cta4 OWNER TO cloudsqlsuperuser;

\connect cta4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 20198)
-- Name: activitymetadata; Type: TABLE; Schema: public; Owner: cta4user
--

CREATE TABLE public.activitymetadata (
    name text,
    id integer NOT NULL,
    type character varying(255),
    start_date timestamp(6) without time zone,
    end_date timestamp(6) without time zone,
    software_name text,
    software_version text,
    id_process_metadata text
);


ALTER TABLE public.activitymetadata OWNER TO cta4user;

--
-- TOC entry 220 (class 1259 OID 20197)
-- Name: activitymetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: cta4user
--

CREATE SEQUENCE public.activitymetadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activitymetadata_id_seq OWNER TO cta4user;

--
-- TOC entry 4004 (class 0 OID 0)
-- Dependencies: 220
-- Name: activitymetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cta4user
--

ALTER SEQUENCE public.activitymetadata_id_seq OWNED BY public.activitymetadata.id;


--
-- TOC entry 219 (class 1259 OID 20188)
-- Name: contactmetadata; Type: TABLE; Schema: public; Owner: cta4user
--

CREATE TABLE public.contactmetadata (
    id integer NOT NULL,
    organization text,
    name text
);


ALTER TABLE public.contactmetadata OWNER TO cta4user;

--
-- TOC entry 218 (class 1259 OID 20187)
-- Name: contactmetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: cta4user
--

CREATE SEQUENCE public.contactmetadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contactmetadata_id_seq OWNER TO cta4user;

--
-- TOC entry 4005 (class 0 OID 0)
-- Dependencies: 218
-- Name: contactmetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cta4user
--

ALTER SEQUENCE public.contactmetadata_id_seq OWNED BY public.contactmetadata.id;


--
-- TOC entry 225 (class 1259 OID 20293)
-- Name: in_context_of; Type: TABLE; Schema: public; Owner: cta4user
--

CREATE TABLE public.in_context_of (
    id integer NOT NULL,
    type text,
    id_instrument_metadata text,
    id_process_metadata text
);


ALTER TABLE public.in_context_of OWNER TO cta4user;

--
-- TOC entry 224 (class 1259 OID 20292)
-- Name: in_context_of_id_seq; Type: SEQUENCE; Schema: public; Owner: cta4user
--

CREATE SEQUENCE public.in_context_of_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.in_context_of_id_seq OWNER TO cta4user;

--
-- TOC entry 4006 (class 0 OID 0)
-- Dependencies: 224
-- Name: in_context_of_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cta4user
--

ALTER SEQUENCE public.in_context_of_id_seq OWNED BY public.in_context_of.id;


--
-- TOC entry 223 (class 1259 OID 20221)
-- Name: instrumentmetadata; Type: TABLE; Schema: public; Owner: cta4user
--

CREATE TABLE public.instrumentmetadata (
    id integer NOT NULL,
    type text,
    subtype text,
    class text
);


ALTER TABLE public.instrumentmetadata OWNER TO cta4user;

--
-- TOC entry 222 (class 1259 OID 20220)
-- Name: instrumentmetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: cta4user
--

CREATE SEQUENCE public.instrumentmetadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.instrumentmetadata_id_seq OWNER TO cta4user;

--
-- TOC entry 4007 (class 0 OID 0)
-- Dependencies: 222
-- Name: instrumentmetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cta4user
--

ALTER SEQUENCE public.instrumentmetadata_id_seq OWNED BY public.instrumentmetadata.id;


--
-- TOC entry 217 (class 1259 OID 20179)
-- Name: processmetadata; Type: TABLE; Schema: public; Owner: cta4user
--

CREATE TABLE public.processmetadata (
    id integer NOT NULL,
    type text
);


ALTER TABLE public.processmetadata OWNER TO cta4user;

--
-- TOC entry 216 (class 1259 OID 20178)
-- Name: processmetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: cta4user
--

CREATE SEQUENCE public.processmetadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.processmetadata_id_seq OWNER TO cta4user;

--
-- TOC entry 4008 (class 0 OID 0)
-- Dependencies: 216
-- Name: processmetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cta4user
--

ALTER SEQUENCE public.processmetadata_id_seq OWNED BY public.processmetadata.id;


--
-- TOC entry 215 (class 1259 OID 20029)
-- Name: productmetadata; Type: TABLE; Schema: public; Owner: cta4user
--

CREATE TABLE public.productmetadata (
    description text,
    creation_type timestamp(6) without time zone,
    id integer NOT NULL,
    data_category text,
    data_levels text,
    data_sublevels text,
    data_association text,
    data_type text,
    data_model text,
    data_model_version text,
    data_model_url text,
    id_activity_metadata text,
    id_contact_metadata text
);


ALTER TABLE public.productmetadata OWNER TO cta4user;

--
-- TOC entry 214 (class 1259 OID 20028)
-- Name: productmetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: cta4user
--

CREATE SEQUENCE public.productmetadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productmetadata_id_seq OWNER TO cta4user;

--
-- TOC entry 4009 (class 0 OID 0)
-- Dependencies: 214
-- Name: productmetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cta4user
--

ALTER SEQUENCE public.productmetadata_id_seq OWNED BY public.productmetadata.id;


--
-- TOC entry 3816 (class 2604 OID 20201)
-- Name: activitymetadata id; Type: DEFAULT; Schema: public; Owner: cta4user
--

ALTER TABLE ONLY public.activitymetadata ALTER COLUMN id SET DEFAULT nextval('public.activitymetadata_id_seq'::regclass);


--
-- TOC entry 3815 (class 2604 OID 20191)
-- Name: contactmetadata id; Type: DEFAULT; Schema: public; Owner: cta4user
--

ALTER TABLE ONLY public.contactmetadata ALTER COLUMN id SET DEFAULT nextval('public.contactmetadata_id_seq'::regclass);


--
-- TOC entry 3818 (class 2604 OID 20296)
-- Name: in_context_of id; Type: DEFAULT; Schema: public; Owner: cta4user
--

ALTER TABLE ONLY public.in_context_of ALTER COLUMN id SET DEFAULT nextval('public.in_context_of_id_seq'::regclass);


--
-- TOC entry 3817 (class 2604 OID 20224)
-- Name: instrumentmetadata id; Type: DEFAULT; Schema: public; Owner: cta4user
--

ALTER TABLE ONLY public.instrumentmetadata ALTER COLUMN id SET DEFAULT nextval('public.instrumentmetadata_id_seq'::regclass);


--
-- TOC entry 3814 (class 2604 OID 20182)
-- Name: processmetadata id; Type: DEFAULT; Schema: public; Owner: cta4user
--

ALTER TABLE ONLY public.processmetadata ALTER COLUMN id SET DEFAULT nextval('public.processmetadata_id_seq'::regclass);


--
-- TOC entry 3813 (class 2604 OID 20032)
-- Name: productmetadata id; Type: DEFAULT; Schema: public; Owner: cta4user
--

ALTER TABLE ONLY public.productmetadata ALTER COLUMN id SET DEFAULT nextval('public.productmetadata_id_seq'::regclass);


--
-- TOC entry 3980 (class 0 OID 20198)
-- Dependencies: 221
-- Data for Name: activitymetadata; Type: TABLE DATA; Schema: public; Owner: cta4user
--



--
-- TOC entry 3978 (class 0 OID 20188)
-- Dependencies: 219
-- Data for Name: contactmetadata; Type: TABLE DATA; Schema: public; Owner: cta4user
--



--
-- TOC entry 3984 (class 0 OID 20293)
-- Dependencies: 225
-- Data for Name: in_context_of; Type: TABLE DATA; Schema: public; Owner: cta4user
--



--
-- TOC entry 3982 (class 0 OID 20221)
-- Dependencies: 223
-- Data for Name: instrumentmetadata; Type: TABLE DATA; Schema: public; Owner: cta4user
--



--
-- TOC entry 3976 (class 0 OID 20179)
-- Dependencies: 217
-- Data for Name: processmetadata; Type: TABLE DATA; Schema: public; Owner: cta4user
--



--
-- TOC entry 3974 (class 0 OID 20029)
-- Dependencies: 215
-- Data for Name: productmetadata; Type: TABLE DATA; Schema: public; Owner: cta4user
--



--
-- TOC entry 4010 (class 0 OID 0)
-- Dependencies: 220
-- Name: activitymetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cta4user
--

SELECT pg_catalog.setval('public.activitymetadata_id_seq', 1, false);


--
-- TOC entry 4011 (class 0 OID 0)
-- Dependencies: 218
-- Name: contactmetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cta4user
--

SELECT pg_catalog.setval('public.contactmetadata_id_seq', 1, false);


--
-- TOC entry 4012 (class 0 OID 0)
-- Dependencies: 224
-- Name: in_context_of_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cta4user
--

SELECT pg_catalog.setval('public.in_context_of_id_seq', 1, false);


--
-- TOC entry 4013 (class 0 OID 0)
-- Dependencies: 222
-- Name: instrumentmetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cta4user
--

SELECT pg_catalog.setval('public.instrumentmetadata_id_seq', 1, false);


--
-- TOC entry 4014 (class 0 OID 0)
-- Dependencies: 216
-- Name: processmetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cta4user
--

SELECT pg_catalog.setval('public.processmetadata_id_seq', 1, false);


--
-- TOC entry 4015 (class 0 OID 0)
-- Dependencies: 214
-- Name: productmetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cta4user
--

SELECT pg_catalog.setval('public.productmetadata_id_seq', 1, false);


--
-- TOC entry 3826 (class 2606 OID 20205)
-- Name: activitymetadata activitymetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: cta4user
--

ALTER TABLE ONLY public.activitymetadata
    ADD CONSTRAINT activitymetadata_pkey PRIMARY KEY (id);


--
-- TOC entry 3824 (class 2606 OID 20195)
-- Name: contactmetadata contactmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: cta4user
--

ALTER TABLE ONLY public.contactmetadata
    ADD CONSTRAINT contactmetadata_pkey PRIMARY KEY (id);


--
-- TOC entry 3830 (class 2606 OID 20300)
-- Name: in_context_of in_context_of_pkey; Type: CONSTRAINT; Schema: public; Owner: cta4user
--

ALTER TABLE ONLY public.in_context_of
    ADD CONSTRAINT in_context_of_pkey PRIMARY KEY (id);


--
-- TOC entry 3828 (class 2606 OID 20228)
-- Name: instrumentmetadata instrumentmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: cta4user
--

ALTER TABLE ONLY public.instrumentmetadata
    ADD CONSTRAINT instrumentmetadata_pkey PRIMARY KEY (id);


--
-- TOC entry 3822 (class 2606 OID 20186)
-- Name: processmetadata processmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: cta4user
--

ALTER TABLE ONLY public.processmetadata
    ADD CONSTRAINT processmetadata_pkey PRIMARY KEY (id);


--
-- TOC entry 3820 (class 2606 OID 20036)
-- Name: productmetadata productmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: cta4user
--

ALTER TABLE ONLY public.productmetadata
    ADD CONSTRAINT productmetadata_pkey PRIMARY KEY (id);


--
-- TOC entry 3991 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO cloudsqlsuperuser;


--
-- TOC entry 3992 (class 0 OID 0)
-- Dependencies: 232
-- Name: FUNCTION pg_replication_origin_advance(text, pg_lsn); Type: ACL; Schema: pg_catalog; Owner: cloudsqladmin
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_advance(text, pg_lsn) TO cloudsqlsuperuser;


--
-- TOC entry 3993 (class 0 OID 0)
-- Dependencies: 236
-- Name: FUNCTION pg_replication_origin_create(text); Type: ACL; Schema: pg_catalog; Owner: cloudsqladmin
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_create(text) TO cloudsqlsuperuser;


--
-- TOC entry 3994 (class 0 OID 0)
-- Dependencies: 227
-- Name: FUNCTION pg_replication_origin_drop(text); Type: ACL; Schema: pg_catalog; Owner: cloudsqladmin
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_drop(text) TO cloudsqlsuperuser;


--
-- TOC entry 3995 (class 0 OID 0)
-- Dependencies: 237
-- Name: FUNCTION pg_replication_origin_oid(text); Type: ACL; Schema: pg_catalog; Owner: cloudsqladmin
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_oid(text) TO cloudsqlsuperuser;


--
-- TOC entry 3996 (class 0 OID 0)
-- Dependencies: 233
-- Name: FUNCTION pg_replication_origin_progress(text, boolean); Type: ACL; Schema: pg_catalog; Owner: cloudsqladmin
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_progress(text, boolean) TO cloudsqlsuperuser;


--
-- TOC entry 3997 (class 0 OID 0)
-- Dependencies: 228
-- Name: FUNCTION pg_replication_origin_session_is_setup(); Type: ACL; Schema: pg_catalog; Owner: cloudsqladmin
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_is_setup() TO cloudsqlsuperuser;


--
-- TOC entry 3998 (class 0 OID 0)
-- Dependencies: 229
-- Name: FUNCTION pg_replication_origin_session_progress(boolean); Type: ACL; Schema: pg_catalog; Owner: cloudsqladmin
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_progress(boolean) TO cloudsqlsuperuser;


--
-- TOC entry 3999 (class 0 OID 0)
-- Dependencies: 230
-- Name: FUNCTION pg_replication_origin_session_reset(); Type: ACL; Schema: pg_catalog; Owner: cloudsqladmin
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_reset() TO cloudsqlsuperuser;


--
-- TOC entry 4000 (class 0 OID 0)
-- Dependencies: 231
-- Name: FUNCTION pg_replication_origin_session_setup(text); Type: ACL; Schema: pg_catalog; Owner: cloudsqladmin
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_setup(text) TO cloudsqlsuperuser;


--
-- TOC entry 4001 (class 0 OID 0)
-- Dependencies: 234
-- Name: FUNCTION pg_replication_origin_xact_reset(); Type: ACL; Schema: pg_catalog; Owner: cloudsqladmin
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_xact_reset() TO cloudsqlsuperuser;


--
-- TOC entry 4002 (class 0 OID 0)
-- Dependencies: 226
-- Name: FUNCTION pg_replication_origin_xact_setup(pg_lsn, timestamp with time zone); Type: ACL; Schema: pg_catalog; Owner: cloudsqladmin
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_xact_setup(pg_lsn, timestamp with time zone) TO cloudsqlsuperuser;


--
-- TOC entry 4003 (class 0 OID 0)
-- Dependencies: 235
-- Name: FUNCTION pg_show_replication_origin_status(OUT local_id oid, OUT external_id text, OUT remote_lsn pg_lsn, OUT local_lsn pg_lsn); Type: ACL; Schema: pg_catalog; Owner: cloudsqladmin
--

GRANT ALL ON FUNCTION pg_catalog.pg_show_replication_origin_status(OUT local_id oid, OUT external_id text, OUT remote_lsn pg_lsn, OUT local_lsn pg_lsn) TO cloudsqlsuperuser;


-- Completed on 2024-04-08 16:08:24

--
-- PostgreSQL database dump complete
--

