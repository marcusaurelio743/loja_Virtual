--
-- PostgreSQL database dump
--

-- Dumped from database version 16.10 (Debian 16.10-1.pgdg13+1)
-- Dumped by pg_dump version 17.0

-- Started on 2026-05-28 16:13:10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3627 (class 1262 OID 114689)
-- Name: LojaVirtual; Type: DATABASE; Schema: -; Owner: admin
--

CREATE DATABASE "LojaVirtual" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE "LojaVirtual" OWNER TO admin;

\connect "LojaVirtual"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 255 (class 1255 OID 237571)
-- Name: validachavepessoa(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.validachavepessoa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare existe integer;
begin
	existe := (select count(1) from pessoa_fisica where id = NEW.pessoa_id);
	
		if(existe <= 0) then
			existe := (select count(1) from pessoa_juridica where id = NEW.pessoa_id);
			
			if(existe <= 0) then
		
				RAISE EXCEPTION 'não foi encontrado id e pk da pessoa para realizar a associação de cadastrado';
 			end if;
		end if;
return NEW;
end
$$;


ALTER FUNCTION public.validachavepessoa() OWNER TO admin;

--
-- TOC entry 256 (class 1255 OID 237573)
-- Name: validachavepessoa2(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.validachavepessoa2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare existe integer;
begin
	existe := (select count(1) from pessoa_fisica where id = NEW.pessoa_forn_id);
	
		if(existe <= 0) then
			existe := (select count(1) from pessoa_juridica where id = NEW.pessoa_forn_id);
			
			if(existe <= 0) then
		
				RAISE EXCEPTION 'não foi encontrado id e pk da pessoa para realizar a associação de cadastrado';
 			end if;
		end if;
return NEW;
end
$$;


ALTER FUNCTION public.validachavepessoa2() OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 122887)
-- Name: acesso; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.acesso (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.acesso OWNER TO admin;

--
-- TOC entry 243 (class 1259 OID 221201)
-- Name: avaliacao_produto; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.avaliacao_produto (
    id bigint NOT NULL,
    pessoa_id bigint NOT NULL,
    produto_id bigint NOT NULL,
    nota integer NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.avaliacao_produto OWNER TO admin;

--
-- TOC entry 215 (class 1259 OID 114690)
-- Name: categoria_produto; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.categoria_produto (
    id bigint NOT NULL,
    nome_desc character varying(255)
);


ALTER TABLE public.categoria_produto OWNER TO admin;

--
-- TOC entry 229 (class 1259 OID 172039)
-- Name: conta_pagar; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.conta_pagar (
    id bigint NOT NULL,
    descricao character varying(255),
    dt_pagamento date,
    valor_desconto numeric(19,2),
    pessoa_id bigint NOT NULL,
    pessoa_forn_id bigint NOT NULL,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valor_total numeric(19,2) NOT NULL
);


ALTER TABLE public.conta_pagar OWNER TO admin;

--
-- TOC entry 225 (class 1259 OID 163841)
-- Name: conta_receber; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.conta_receber (
    id bigint NOT NULL,
    dt_pagamento date,
    valor_desconto numeric(19,2),
    pessoa_id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valor_total numeric(19,2) NOT NULL
);


ALTER TABLE public.conta_receber OWNER TO admin;

--
-- TOC entry 231 (class 1259 OID 180225)
-- Name: cup_desc; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.cup_desc (
    id bigint NOT NULL,
    data_validade date,
    valor_porcent_desc numeric(19,2),
    valor_real_desc numeric(19,2),
    cod_desc character varying(255) NOT NULL
);


ALTER TABLE public.cup_desc OWNER TO admin;

--
-- TOC entry 245 (class 1259 OID 229377)
-- Name: endereco; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.endereco (
    id bigint NOT NULL,
    bairro character varying(255) NOT NULL,
    cep character varying(255) NOT NULL,
    cidade character varying(255) NOT NULL,
    complemento character varying(255),
    numero character varying(255) NOT NULL,
    rua_logradoro character varying(255) NOT NULL,
    tipo_endereco character varying(255) NOT NULL,
    uf character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.endereco OWNER TO admin;

--
-- TOC entry 227 (class 1259 OID 172033)
-- Name: forma_pagamento; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.forma_pagamento (
    id bigint NOT NULL,
    descricao character varying(255)
);


ALTER TABLE public.forma_pagamento OWNER TO admin;

--
-- TOC entry 246 (class 1259 OID 229394)
-- Name: imagem_produto; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.imagem_produto (
    id bigint NOT NULL,
    imagem_miniatura text NOT NULL,
    imagem_original text NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.imagem_produto OWNER TO admin;

--
-- TOC entry 247 (class 1259 OID 229406)
-- Name: item_venda_loja; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.item_venda_loja (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    produto_id bigint NOT NULL,
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.item_venda_loja OWNER TO admin;

--
-- TOC entry 216 (class 1259 OID 114695)
-- Name: marca_produto; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.marca_produto (
    id bigint NOT NULL,
    nome_desc character varying(150)
);


ALTER TABLE public.marca_produto OWNER TO admin;

--
-- TOC entry 248 (class 1259 OID 229421)
-- Name: nota_fiscal_compra; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.nota_fiscal_compra (
    id bigint NOT NULL,
    data_compra date NOT NULL,
    descricao_obs text,
    numero_nota character varying(255) NOT NULL,
    serie_nota character varying(255) NOT NULL,
    valor_desconto numeric(19,2),
    valor_icms numeric(19,2) NOT NULL,
    valor_total numeric(19,2) NOT NULL,
    conta_pagar_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_compra OWNER TO admin;

--
-- TOC entry 249 (class 1259 OID 229438)
-- Name: nota_fiscal_venda; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.nota_fiscal_venda (
    id bigint NOT NULL,
    numero character varying(255) NOT NULL,
    pdf text NOT NULL,
    serie character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    xml text NOT NULL,
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_venda OWNER TO admin;

--
-- TOC entry 236 (class 1259 OID 196629)
-- Name: nota_item_pedido; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.nota_item_pedido (
    id bigint NOT NULL,
    quantidade double precision,
    produto_id bigint NOT NULL,
    nota_fiscal_compra_id bigint NOT NULL
);


ALTER TABLE public.nota_item_pedido OWNER TO admin;

--
-- TOC entry 250 (class 1259 OID 229469)
-- Name: pessoa_fisica; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.pessoa_fisica (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    cpf character varying(255) NOT NULL,
    data_nascimento date
);


ALTER TABLE public.pessoa_fisica OWNER TO admin;

--
-- TOC entry 251 (class 1259 OID 229476)
-- Name: pessoa_juridica; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.pessoa_juridica (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    categoria character varying(255) NOT NULL,
    cnpj character varying(255) NOT NULL,
    insc_estadual character varying(255) NOT NULL,
    insc_municipal character varying(255),
    nome_fantasia character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL
);


ALTER TABLE public.pessoa_juridica OWNER TO admin;

--
-- TOC entry 252 (class 1259 OID 229484)
-- Name: produto; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.produto (
    id bigint NOT NULL,
    alertaqtd_estoque boolean,
    altura double precision NOT NULL,
    ativo boolean NOT NULL,
    descricao text NOT NULL,
    largura double precision NOT NULL,
    link_video character varying(255),
    nome character varying(255) NOT NULL,
    peso double precision NOT NULL,
    profundidade double precision NOT NULL,
    qtd_alerta_estoque integer,
    qtd_clique integer,
    qtd_estoque integer,
    tipo_unidade character varying(255) NOT NULL,
    valor_venda numeric(19,2) NOT NULL
);


ALTER TABLE public.produto OWNER TO admin;

--
-- TOC entry 220 (class 1259 OID 122892)
-- Name: seq_acesso; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_acesso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_acesso OWNER TO admin;

--
-- TOC entry 244 (class 1259 OID 221206)
-- Name: seq_avaliacao_produto; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_avaliacao_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_avaliacao_produto OWNER TO admin;

--
-- TOC entry 217 (class 1259 OID 114700)
-- Name: seq_categoria_produto; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_categoria_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_categoria_produto OWNER TO admin;

--
-- TOC entry 230 (class 1259 OID 172046)
-- Name: seq_conta_pagar; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_conta_pagar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_conta_pagar OWNER TO admin;

--
-- TOC entry 226 (class 1259 OID 163850)
-- Name: seq_conta_receber; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_conta_receber
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_conta_receber OWNER TO admin;

--
-- TOC entry 232 (class 1259 OID 180230)
-- Name: seq_cup_desc; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_cup_desc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_cup_desc OWNER TO admin;

--
-- TOC entry 222 (class 1259 OID 139272)
-- Name: seq_endereco; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_endereco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_endereco OWNER TO admin;

--
-- TOC entry 228 (class 1259 OID 172038)
-- Name: seq_forma_pagamento; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_forma_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_forma_pagamento OWNER TO admin;

--
-- TOC entry 234 (class 1259 OID 188424)
-- Name: seq_imagem_produto; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_imagem_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_imagem_produto OWNER TO admin;

--
-- TOC entry 242 (class 1259 OID 221190)
-- Name: seq_item_venda_loja; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_item_venda_loja
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_item_venda_loja OWNER TO admin;

--
-- TOC entry 218 (class 1259 OID 114701)
-- Name: seq_marca_produto; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_marca_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_marca_produto OWNER TO admin;

--
-- TOC entry 235 (class 1259 OID 196616)
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_nota_fiscal_compra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_nota_fiscal_compra OWNER TO admin;

--
-- TOC entry 240 (class 1259 OID 204816)
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_nota_fiscal_venda
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_nota_fiscal_venda OWNER TO admin;

--
-- TOC entry 237 (class 1259 OID 196634)
-- Name: seq_nota_item_pedido; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_nota_item_pedido
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_nota_item_pedido OWNER TO admin;

--
-- TOC entry 221 (class 1259 OID 131087)
-- Name: seq_pessoa; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_pessoa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_pessoa OWNER TO admin;

--
-- TOC entry 233 (class 1259 OID 180238)
-- Name: seq_produto; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_produto OWNER TO admin;

--
-- TOC entry 239 (class 1259 OID 204808)
-- Name: seq_status_rastreio; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_status_rastreio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_status_rastreio OWNER TO admin;

--
-- TOC entry 224 (class 1259 OID 147471)
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_usuario OWNER TO admin;

--
-- TOC entry 241 (class 1259 OID 212998)
-- Name: seq_venda_compra_loja_virt; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_venda_compra_loja_virt
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_venda_compra_loja_virt OWNER TO admin;

--
-- TOC entry 238 (class 1259 OID 204801)
-- Name: status_rastreio; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.status_rastreio (
    id bigint NOT NULL,
    centro_distribuicao character varying(255),
    cidade character varying(255),
    estado character varying(255),
    status character varying(255),
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.status_rastreio OWNER TO admin;

--
-- TOC entry 253 (class 1259 OID 229511)
-- Name: usuario; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.usuario (
    id bigint NOT NULL,
    data_atual_senha date NOT NULL,
    login character varying(255) NOT NULL,
    senha character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.usuario OWNER TO admin;

--
-- TOC entry 223 (class 1259 OID 147464)
-- Name: usuario_acesso; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.usuario_acesso (
    usuario_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


ALTER TABLE public.usuario_acesso OWNER TO admin;

--
-- TOC entry 254 (class 1259 OID 229518)
-- Name: venda_compra_loja_virt; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.venda_compra_loja_virt (
    id bigint NOT NULL,
    data_entrega date NOT NULL,
    data_venda date NOT NULL,
    dia_entrega integer NOT NULL,
    valor_desconto numeric(19,2),
    valor_frente numeric(19,2) NOT NULL,
    valor_total numeric(19,2) NOT NULL,
    cup_desc_id bigint,
    endereco_cobranca_id bigint NOT NULL,
    endereco_entrega_id bigint NOT NULL,
    forma_pagamento_id bigint NOT NULL,
    nota_fical_venda_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.venda_compra_loja_virt OWNER TO admin;

--
-- TOC entry 3586 (class 0 OID 122887)
-- Dependencies: 219
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3610 (class 0 OID 221201)
-- Dependencies: 243
-- Data for Name: avaliacao_produto; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3582 (class 0 OID 114690)
-- Dependencies: 215
-- Data for Name: categoria_produto; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3596 (class 0 OID 172039)
-- Dependencies: 229
-- Data for Name: conta_pagar; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3592 (class 0 OID 163841)
-- Dependencies: 225
-- Data for Name: conta_receber; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3598 (class 0 OID 180225)
-- Dependencies: 231
-- Data for Name: cup_desc; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3612 (class 0 OID 229377)
-- Dependencies: 245
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3594 (class 0 OID 172033)
-- Dependencies: 227
-- Data for Name: forma_pagamento; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3613 (class 0 OID 229394)
-- Dependencies: 246
-- Data for Name: imagem_produto; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3614 (class 0 OID 229406)
-- Dependencies: 247
-- Data for Name: item_venda_loja; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3583 (class 0 OID 114695)
-- Dependencies: 216
-- Data for Name: marca_produto; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3615 (class 0 OID 229421)
-- Dependencies: 248
-- Data for Name: nota_fiscal_compra; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3616 (class 0 OID 229438)
-- Dependencies: 249
-- Data for Name: nota_fiscal_venda; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3603 (class 0 OID 196629)
-- Dependencies: 236
-- Data for Name: nota_item_pedido; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3617 (class 0 OID 229469)
-- Dependencies: 250
-- Data for Name: pessoa_fisica; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3618 (class 0 OID 229476)
-- Dependencies: 251
-- Data for Name: pessoa_juridica; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3619 (class 0 OID 229484)
-- Dependencies: 252
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3605 (class 0 OID 204801)
-- Dependencies: 238
-- Data for Name: status_rastreio; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3620 (class 0 OID 229511)
-- Dependencies: 253
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3590 (class 0 OID 147464)
-- Dependencies: 223
-- Data for Name: usuario_acesso; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3621 (class 0 OID 229518)
-- Dependencies: 254
-- Data for Name: venda_compra_loja_virt; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3628 (class 0 OID 0)
-- Dependencies: 220
-- Name: seq_acesso; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_acesso', 1, false);


--
-- TOC entry 3629 (class 0 OID 0)
-- Dependencies: 244
-- Name: seq_avaliacao_produto; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_avaliacao_produto', 1, false);


--
-- TOC entry 3630 (class 0 OID 0)
-- Dependencies: 217
-- Name: seq_categoria_produto; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_categoria_produto', 1, false);


--
-- TOC entry 3631 (class 0 OID 0)
-- Dependencies: 230
-- Name: seq_conta_pagar; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_conta_pagar', 1, false);


--
-- TOC entry 3632 (class 0 OID 0)
-- Dependencies: 226
-- Name: seq_conta_receber; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_conta_receber', 1, false);


--
-- TOC entry 3633 (class 0 OID 0)
-- Dependencies: 232
-- Name: seq_cup_desc; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_cup_desc', 1, false);


--
-- TOC entry 3634 (class 0 OID 0)
-- Dependencies: 222
-- Name: seq_endereco; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_endereco', 1, false);


--
-- TOC entry 3635 (class 0 OID 0)
-- Dependencies: 228
-- Name: seq_forma_pagamento; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_forma_pagamento', 1, false);


--
-- TOC entry 3636 (class 0 OID 0)
-- Dependencies: 234
-- Name: seq_imagem_produto; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_imagem_produto', 1, false);


--
-- TOC entry 3637 (class 0 OID 0)
-- Dependencies: 242
-- Name: seq_item_venda_loja; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_item_venda_loja', 1, false);


--
-- TOC entry 3638 (class 0 OID 0)
-- Dependencies: 218
-- Name: seq_marca_produto; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_marca_produto', 1, false);


--
-- TOC entry 3639 (class 0 OID 0)
-- Dependencies: 235
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_nota_fiscal_compra', 1, false);


--
-- TOC entry 3640 (class 0 OID 0)
-- Dependencies: 240
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_nota_fiscal_venda', 1, false);


--
-- TOC entry 3641 (class 0 OID 0)
-- Dependencies: 237
-- Name: seq_nota_item_pedido; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_nota_item_pedido', 1, false);


--
-- TOC entry 3642 (class 0 OID 0)
-- Dependencies: 221
-- Name: seq_pessoa; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_pessoa', 1, false);


--
-- TOC entry 3643 (class 0 OID 0)
-- Dependencies: 233
-- Name: seq_produto; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_produto', 1, false);


--
-- TOC entry 3644 (class 0 OID 0)
-- Dependencies: 239
-- Name: seq_status_rastreio; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_status_rastreio', 1, false);


--
-- TOC entry 3645 (class 0 OID 0)
-- Dependencies: 224
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_usuario', 1, false);


--
-- TOC entry 3646 (class 0 OID 0)
-- Dependencies: 241
-- Name: seq_venda_compra_loja_virt; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_venda_compra_loja_virt', 1, false);


--
-- TOC entry 3372 (class 2606 OID 122891)
-- Name: acesso acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 3390 (class 2606 OID 221205)
-- Name: avaliacao_produto avaliacao_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT avaliacao_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3368 (class 2606 OID 114694)
-- Name: categoria_produto categoria_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.categoria_produto
    ADD CONSTRAINT categoria_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3382 (class 2606 OID 172045)
-- Name: conta_pagar conta_pagar_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conta_pagar
    ADD CONSTRAINT conta_pagar_pkey PRIMARY KEY (id);


--
-- TOC entry 3378 (class 2606 OID 163847)
-- Name: conta_receber conta_receber_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conta_receber
    ADD CONSTRAINT conta_receber_pkey PRIMARY KEY (id);


--
-- TOC entry 3384 (class 2606 OID 180229)
-- Name: cup_desc cup_desc_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cup_desc
    ADD CONSTRAINT cup_desc_pkey PRIMARY KEY (id);


--
-- TOC entry 3392 (class 2606 OID 229383)
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 3380 (class 2606 OID 172037)
-- Name: forma_pagamento forma_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.forma_pagamento
    ADD CONSTRAINT forma_pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 3394 (class 2606 OID 229400)
-- Name: imagem_produto imagem_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT imagem_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3396 (class 2606 OID 229410)
-- Name: item_venda_loja item_venda_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT item_venda_loja_pkey PRIMARY KEY (id);


--
-- TOC entry 3370 (class 2606 OID 114699)
-- Name: marca_produto marca_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.marca_produto
    ADD CONSTRAINT marca_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3398 (class 2606 OID 229427)
-- Name: nota_fiscal_compra nota_fiscal_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT nota_fiscal_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 3400 (class 2606 OID 229444)
-- Name: nota_fiscal_venda nota_fiscal_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT nota_fiscal_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 3386 (class 2606 OID 196633)
-- Name: nota_item_pedido nota_item_pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.nota_item_pedido
    ADD CONSTRAINT nota_item_pedido_pkey PRIMARY KEY (id);


--
-- TOC entry 3402 (class 2606 OID 229475)
-- Name: pessoa_fisica pessoa_fisica_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_pkey PRIMARY KEY (id);


--
-- TOC entry 3404 (class 2606 OID 229482)
-- Name: pessoa_juridica pessoa_juridica_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.pessoa_juridica
    ADD CONSTRAINT pessoa_juridica_pkey PRIMARY KEY (id);


--
-- TOC entry 3406 (class 2606 OID 229490)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3388 (class 2606 OID 204807)
-- Name: status_rastreio status_rastreio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT status_rastreio_pkey PRIMARY KEY (id);


--
-- TOC entry 3374 (class 2606 OID 163849)
-- Name: usuario_acesso uk_fhwpg5wu1u5p306q8gycxn9ky; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT uk_fhwpg5wu1u5p306q8gycxn9ky UNIQUE (acesso_id);


--
-- TOC entry 3376 (class 2606 OID 147470)
-- Name: usuario_acesso unique_acesso_user; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT unique_acesso_user UNIQUE (usuario_id, acesso_id);


--
-- TOC entry 3408 (class 2606 OID 229517)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 3410 (class 2606 OID 229522)
-- Name: venda_compra_loja_virt venda_compra_loja_virt_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.venda_compra_loja_virt
    ADD CONSTRAINT venda_compra_loja_virt_pkey PRIMARY KEY (id);


--
-- TOC entry 3429 (class 2620 OID 237572)
-- Name: avaliacao_produto validachavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoaavaliacaoproduto BEFORE UPDATE ON public.avaliacao_produto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3431 (class 2620 OID 237577)
-- Name: endereco validachavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoaavaliacaoproduto BEFORE UPDATE ON public.endereco FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3433 (class 2620 OID 237579)
-- Name: nota_fiscal_compra validachavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoaavaliacaoproduto BEFORE UPDATE ON public.nota_fiscal_compra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3435 (class 2620 OID 237581)
-- Name: usuario validachavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoaavaliacaoproduto BEFORE UPDATE ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3437 (class 2620 OID 237583)
-- Name: venda_compra_loja_virt validachavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoaavaliacaoproduto BEFORE UPDATE ON public.venda_compra_loja_virt FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3430 (class 2620 OID 237576)
-- Name: avaliacao_produto validachavepessoaavaliacaoproduto2; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoaavaliacaoproduto2 BEFORE INSERT ON public.avaliacao_produto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3432 (class 2620 OID 237578)
-- Name: endereco validachavepessoaavaliacaoproduto2; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoaavaliacaoproduto2 BEFORE INSERT ON public.endereco FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3434 (class 2620 OID 237580)
-- Name: nota_fiscal_compra validachavepessoaavaliacaoproduto2; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoaavaliacaoproduto2 BEFORE INSERT ON public.nota_fiscal_compra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3436 (class 2620 OID 237582)
-- Name: usuario validachavepessoaavaliacaoproduto2; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoaavaliacaoproduto2 BEFORE INSERT ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3438 (class 2620 OID 237584)
-- Name: venda_compra_loja_virt validachavepessoaavaliacaoproduto2; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoaavaliacaoproduto2 BEFORE INSERT ON public.venda_compra_loja_virt FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3427 (class 2620 OID 237574)
-- Name: conta_pagar validachavepessoacontapagar; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoacontapagar BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa2();


--
-- TOC entry 3428 (class 2620 OID 237575)
-- Name: conta_pagar validachavepessoacontapagar2; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoacontapagar2 BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa2();


--
-- TOC entry 3411 (class 2606 OID 147472)
-- Name: usuario_acesso acesso_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT acesso_fk FOREIGN KEY (acesso_id) REFERENCES public.acesso(id);


--
-- TOC entry 3420 (class 2606 OID 229428)
-- Name: nota_fiscal_compra conta_pagar_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT conta_pagar_fk FOREIGN KEY (conta_pagar_id) REFERENCES public.conta_pagar(id);


--
-- TOC entry 3422 (class 2606 OID 229543)
-- Name: venda_compra_loja_virt cup_desc_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.venda_compra_loja_virt
    ADD CONSTRAINT cup_desc_fk FOREIGN KEY (cup_desc_id) REFERENCES public.cup_desc(id);


--
-- TOC entry 3423 (class 2606 OID 229548)
-- Name: venda_compra_loja_virt endereco_cobranca_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.venda_compra_loja_virt
    ADD CONSTRAINT endereco_cobranca_fk FOREIGN KEY (endereco_cobranca_id) REFERENCES public.endereco(id);


--
-- TOC entry 3424 (class 2606 OID 229553)
-- Name: venda_compra_loja_virt endereco_entrega_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.venda_compra_loja_virt
    ADD CONSTRAINT endereco_entrega_fk FOREIGN KEY (endereco_entrega_id) REFERENCES public.endereco(id);


--
-- TOC entry 3425 (class 2606 OID 229558)
-- Name: venda_compra_loja_virt forma_pagamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.venda_compra_loja_virt
    ADD CONSTRAINT forma_pagamento_fk FOREIGN KEY (forma_pagamento_id) REFERENCES public.forma_pagamento(id);


--
-- TOC entry 3426 (class 2606 OID 229563)
-- Name: venda_compra_loja_virt nota_fical_venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.venda_compra_loja_virt
    ADD CONSTRAINT nota_fical_venda_fk FOREIGN KEY (nota_fical_venda_id) REFERENCES public.nota_fiscal_venda(id);


--
-- TOC entry 3413 (class 2606 OID 229433)
-- Name: nota_item_pedido nota_fiscal_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.nota_item_pedido
    ADD CONSTRAINT nota_fiscal_compra_fk FOREIGN KEY (nota_fiscal_compra_id) REFERENCES public.nota_fiscal_compra(id);


--
-- TOC entry 3416 (class 2606 OID 229491)
-- Name: avaliacao_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3417 (class 2606 OID 229496)
-- Name: imagem_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3418 (class 2606 OID 229501)
-- Name: item_venda_loja produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3414 (class 2606 OID 229506)
-- Name: nota_item_pedido produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.nota_item_pedido
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3412 (class 2606 OID 229538)
-- Name: usuario_acesso usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);


--
-- TOC entry 3419 (class 2606 OID 229523)
-- Name: item_venda_loja venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.venda_compra_loja_virt(id);


--
-- TOC entry 3421 (class 2606 OID 229528)
-- Name: nota_fiscal_venda venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.venda_compra_loja_virt(id);


--
-- TOC entry 3415 (class 2606 OID 229533)
-- Name: status_rastreio venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.venda_compra_loja_virt(id);


-- Completed on 2026-05-28 16:13:10

--
-- PostgreSQL database dump complete
--

