--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.14
-- Dumped by pg_dump version 10.5 (Ubuntu 10.5-1.pgdg16.04+1)

-- Started on 2018-11-01 14:21:22 MSK

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE infomat;
--
-- TOC entry 2786 (class 1262 OID 16659149)
-- Name: infomat; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE infomat WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'ru_RU.UTF-8' LC_CTYPE = 'ru_RU.UTF-8';


ALTER DATABASE infomat OWNER TO postgres;

\connect infomat
=======
DROP DATABASE infomat_qt;
--
-- TOC entry 2528 (class 1262 OID 16407660)
-- Name: infomat_qt; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE infomat_qt WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'ru_RU.UTF-8' LC_CTYPE = 'ru_RU.UTF-8';


ALTER DATABASE infomat_qt OWNER TO postgres;

\connect infomat_qt

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12397)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2789 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 649 (class 1247 OID 16659151)
-- Name: activity_periodicity; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.activity_periodicity AS ENUM (
    'once',
    'daily',
    'weekly',
    'monthly',
    'yearly'
);


ALTER TYPE public.activity_periodicity OWNER TO postgres;

--
-- TOC entry 2790 (class 0 OID 0)
-- Dependencies: 649
-- Name: TYPE activity_periodicity; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE public.activity_periodicity IS 'once (однажды), daily (ежедневно), weekly(еженедельно), monthly (ежемесячно), yearly (ежегодно)';


--
-- TOC entry 652 (class 1247 OID 16659162)
-- Name: entity_state; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.entity_state AS ENUM (
    'enabled',
    'disabled',
    'deleted'
);


ALTER TYPE public.entity_state OWNER TO postgres;

--
-- TOC entry 655 (class 1247 OID 16659170)
-- Name: execution_state; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.execution_state AS ENUM (
    'not_done',
    'done'
);


ALTER TYPE public.execution_state OWNER TO postgres;

--
-- TOC entry 2791 (class 0 OID 0)
-- Dependencies: 655
-- Name: TYPE execution_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE public.execution_state IS 'not done (не проведено), done (проведено)';


--
-- TOC entry 658 (class 1247 OID 16659175)
-- Name: file_path; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.file_path AS character varying(256)
	CONSTRAINT file_path_check CHECK ((length(btrim((VALUE)::text)) > 3));


ALTER DOMAIN public.file_path OWNER TO postgres;

--
-- TOC entry 2792 (class 0 OID 0)
-- Dependencies: 658
-- Name: DOMAIN file_path; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON DOMAIN public.file_path IS 'путь файловой системы';


--
-- TOC entry 660 (class 1247 OID 16659177)
-- Name: kladr; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.kladr AS character varying(32)
	CONSTRAINT kladr_check CHECK (((VALUE)::text ~ '^[0-9]{12,}$'::text));


ALTER DOMAIN public.kladr OWNER TO postgres;

--
-- TOC entry 2793 (class 0 OID 0)
-- Dependencies: 660
-- Name: DOMAIN kladr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON DOMAIN public.kladr IS 'коды КЛАДР';


--
-- TOC entry 662 (class 1247 OID 16659179)
-- Name: postcode; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.postcode AS character(6)
	CONSTRAINT postcode_check CHECK (((VALUE)::text ~ '^[0-9]{6}$'::text));


ALTER DOMAIN public.postcode OWNER TO postgres;

--
-- TOC entry 2794 (class 0 OID 0)
-- Dependencies: 662
-- Name: DOMAIN postcode; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON DOMAIN public.postcode IS 'почтовый индекс';


--
-- TOC entry 664 (class 1247 OID 16659182)
-- Name: reg_state; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.reg_state AS ENUM (
    'registred',
    'not_registred'
);


ALTER TYPE public.reg_state OWNER TO postgres;

--
-- TOC entry 667 (class 1247 OID 16659188)
-- Name: scores_operations; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.scores_operations AS ENUM (
    'adding',
    'subtracting'
);


ALTER TYPE public.scores_operations OWNER TO postgres;

--
-- TOC entry 2795 (class 0 OID 0)
-- Dependencies: 667
-- Name: TYPE scores_operations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE public.scores_operations IS 'adding(начисление баллов), subtracting(списание баллов)';


--
-- TOC entry 670 (class 1247 OID 16659194)
-- Name: scores_reason_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.scores_reason_type AS ENUM (
    'automatic',
    'manual'
);


ALTER TYPE public.scores_reason_type OWNER TO postgres;

--
-- TOC entry 2796 (class 0 OID 0)
-- Dependencies: 670
-- Name: TYPE scores_reason_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE public.scores_reason_type IS 'automatic (автоматическое изменение бального счёта), manual (ручное изменение бального счёта)';


--
-- TOC entry 673 (class 1247 OID 16659200)
-- Name: state; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.state AS ENUM (
    'enabled',
    'deleted',
    'disabled'
);


ALTER TYPE public.state OWNER TO postgres;

--
-- TOC entry 2797 (class 0 OID 0)
-- Dependencies: 673
-- Name: TYPE state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE public.state IS 'enabled (активно), deleted (удалено), disabled(неактивно)';


--
-- TOC entry 676 (class 1247 OID 16659208)
-- Name: vis_state; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.vis_state AS ENUM (
    'visited',
    'not_visited'
);


ALTER TYPE public.vis_state OWNER TO postgres;

--
-- TOC entry 275 (class 1255 OID 16659213)
-- Name: __adding_leaders_scores(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.__adding_leaders_scores() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE register RECORD;
DECLARE not_conducted_ INTEGER ARRAY;

BEGIN
    -- Временный список
    CREATE TEMPORARY TABLE IF NOT EXISTS conducted_leaders_table( id serial primary key, visitor integer, event integer) ON COMMIT DROP;

    -- Выборка ведущих, к-е зарегистрированы в качестве посетителей
    INSERT INTO conducted_leaders_table (visitor,event)
    SELECT
        v.id AS visitor,
        NEW.id
    FROM 
        visitor v 
    WHERE 
        v.person = ANY
    (
        (
            SELECT 
                array_intersect(ae.conducted_leaders,ae.leaders)
            FROM 
                activities_events ae
            WHERE 
                ae.id=NEW.id
        )::int[]
    );

    -- Удалить начисления, если отмечено, что ведущий не проводил мероприятия
    SELECT
        array_agg(v.id)
    FROM
        visitor v
    WHERE 
        v.person = ANY
    (
        (
            SELECT ARRAY(
              SELECT unnest(OLD.conducted_leaders)
              except
              SELECT unnest(NEW.conducted_leaders)
            ) 
            FROM 
                activities_events ae
            WHERE 
                ae.id=NEW.id
        )::int[]
    )
    INTO not_conducted_;             
    DELETE FROM public.visitors_scores WHERE event = NEW.id AND visitor=ANY(not_conducted_);


    -- Если есть ведущие, зарегистрированные посетителями
    IF EXISTS( SELECT 1 FROM conducted_leaders_table ) THEN
        CASE
            WHEN NEW.state='enabled' AND NEW.execution_state = 'done' THEN
            --всем кто присутствовал
                INSERT INTO public.visitors_scores (
                    date,
                    event,
                    operation,
                    reason_id,
                    scores,
                    visitor
                ) 
                SELECT
                    now(),
                    NEW.id,
                    'adding',
                    2,
                    asr.scores,
                    cl.visitor
                FROM 
                    conducted_leaders_table cl

                INNER JOIN activities_events aev
                ON aev.id = NEW.id

                INNER JOIN activities a
                ON a.id = aev.activity

                INNER JOIN activities_in_action aia
                ON a.id = aia.activity AND aev.date BETWEEN aia.date_start AND aia.date_end

                INNER JOIN activities_scoring_rules asr
                ON asr.activity = a.id AND asr.role = 2 --Если указано правило начисления для ведущего(волонтёра)

                WHERE 
                NOT EXISTS(
                    SELECT * FROM public.visitors_scores WHERE visitor=cl.visitor AND event=NEW.id
                )
                AND 
                    cl.event=NEW.id
                ;

                RETURN NEW;

            WHEN NEW.state!='enabled' OR NEW.execution_state = 'not_done' THEN
                DELETE FROM public.visitors_scores WHERE event = NEW.id;
                RETURN NEW;
        ELSE
            RETURN NEW;     
        END CASE;

    ELSE

        -- Ничего не делать, т.к. нет ведущих, зарегистрированных в качестве посетителей
        RETURN NEW;
    END IF;

END; 
                                                                                                                                                                        
$$;


ALTER FUNCTION public.__adding_leaders_scores() OWNER TO postgres;

--
-- TOC entry 288 (class 1255 OID 16659214)
-- Name: __adding_visitor_scores(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.__adding_visitor_scores() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE register RECORD;

BEGIN
    

    CASE
        WHEN NEW.state='enabled' AND NEW.execution_state = 'done' THEN
        --всем кто присутствовал
            INSERT INTO public.visitors_scores (
                date,
                event,
                operation,
                reason_id,
                scores,
                visitor
            ) 
            SELECT
                now(),
                NEW.id,
                'adding',
                2,
                asr.scores,
                apr.participant
            FROM 
                activities_participants_register apr

            INNER JOIN activities_events aev
            ON aev.id = apr.event

            INNER JOIN activities a
            ON a.id = aev.activity

            INNER JOIN activities_in_action aia
                        ON a.id = aia.activity AND aev.date BETWEEN aia.date_start AND aia.date_end


            INNER JOIN activities_scoring_rules asr
            ON asr.activity = a.id AND asr.role = apr.role

            WHERE 
                event = NEW.id 
                AND vis_state='visited'
                AND NOT EXISTS(
                    SELECT * FROM public.visitors_scores WHERE visitor=apr.participant AND event=NEW.id
                );
            RETURN NEW;

        WHEN NEW.state!='enabled' OR NEW.execution_state = 'not_done' THEN
            DELETE FROM public.visitors_scores WHERE event = NEW.id;
            RETURN NEW;
    ELSE
        RETURN NEW;     
    END CASE;
END; 
                                                                                                                                                                        
$$;


ALTER FUNCTION public.__adding_visitor_scores() OWNER TO postgres;

--
-- TOC entry 289 (class 1255 OID 16659215)
-- Name: __adding_visitor_scores_with_register(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.__adding_visitor_scores_with_register() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE register RECORD;

BEGIN
    

    CASE
        WHEN NEW.vis_state='visited' AND NOT EXISTS( SELECT * FROM public.visitors_scores WHERE visitor = NEW.participant AND event=NEW.event ) THEN
        --всем кто присутствовал
            INSERT INTO public.visitors_scores (
                date,
                event,
                operation,
                reason_id,
                scores,
                visitor
            ) 
            SELECT
                now(),
                NEW.event,
                'adding',
                1,
                asr.scores,
                NEW.participant
            FROM 
                activities_participants_register apr

            INNER JOIN activities_events aev
            ON aev.id = apr.event

            INNER JOIN activities a
            ON a.id = aev.activity

            INNER JOIN activities_in_action aia
                        ON a.id = aia.activity AND aev.date BETWEEN aia.date_start AND aia.date_end


            INNER JOIN activities_scoring_rules asr
            ON asr.activity = a.id AND asr.role = apr.role

            WHERE 
                apr.event = NEW.event
                AND aev.state='enabled'
                AND aev.execution_state='done'
                AND apr.participant = NEW.participant;
            RETURN NEW;

        WHEN NEW.vis_state='not_visited' THEN
            DELETE FROM public.visitors_scores WHERE event = NEW.event AND visitor=NEW.participant;
            RETURN NEW;
    ELSE
        RETURN NEW; 
    END CASE;
END; 
                                                                                                                                                                        
$$;


ALTER FUNCTION public.__adding_visitor_scores_with_register() OWNER TO postgres;

--
-- TOC entry 290 (class 1255 OID 16659216)
-- Name: __check_sum_visitor_scores(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.__check_sum_visitor_scores() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE __scores integer;

BEGIN
	SELECT SUM(scores) FROM visitors_scores WHERE visitor=NEW.visitor INTO __scores;
	IF ( __scores >= 0 ) THEN
    	RETURN NEW;
    ELSE
    	RAISE EXCEPTION 'Сумма баллов посетителя не может быть отрицательной';
    END IF;
END; 
                                                                                                                                                                        
$$;


ALTER FUNCTION public.__check_sum_visitor_scores() OWNER TO postgres;

--
-- TOC entry 291 (class 1255 OID 16659217)
-- Name: __delete_visitor_scores(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.__delete_visitor_scores() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE register RECORD;

BEGIN
    DELETE FROM visitors_scores WHERE event = OLD.event AND visitor=OLD.participant;
    RETURN OLD;
END; 
                                                                                                                                                                        
$$;


ALTER FUNCTION public.__delete_visitor_scores() OWNER TO postgres;

--
-- TOC entry 292 (class 1255 OID 16659218)
-- Name: __update_srv_to_ag_when_ag_created(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.__update_srv_to_ag_when_ag_created() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN
    CASE
    WHEN TG_OP = 'INSERT' THEN
        DELETE FROM srv_to_ag WHERE ag_id = NEW.id;

        IF NEW.type = 1 THEN
            INSERT INTO srv_to_ag (state,srv_id,ag_id) SELECT 'granted',srv.id,NEW.id FROM srv INNER JOIN srv_data ON srv_data.srv_id = srv.id AND srv_data.state = 'enabled' WHERE srv_data.srv_type_id=1;
        END IF;

        RETURN NEW;
    ELSE
        RETURN NEW;
    END CASE;
END; 
                                                                                                                                                                        
$$;


ALTER FUNCTION public.__update_srv_to_ag_when_ag_created() OWNER TO postgres;

--
-- TOC entry 293 (class 1255 OID 16659219)
-- Name: __update_srv_to_ag_when_ag_type_changed(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.__update_srv_to_ag_when_ag_type_changed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$



BEGIN

    CASE

    WHEN TG_OP = 'UPDATE' THEN

        DELETE FROM public.srv_to_ag WHERE ag_id = NEW.id;



        IF NEW.type = 1 THEN

            INSERT INTO public.srv_to_ag (state,srv_id,ag_id) 

            SELECT 'granted', srv.id,NEW.id 

            FROM public.srv 

            INNER JOIN public.srv_data ON srv_data.srv_id = srv.id AND srv_data.state='enabled' 

            WHERE srv_data.srv_type_id=1;

        END IF;



        RETURN NEW;

    ELSE

        RETURN NEW;

    END CASE;

END; 

                                                                                                                                                                        

$$;


ALTER FUNCTION public.__update_srv_to_ag_when_ag_type_changed() OWNER TO postgres;

--
-- TOC entry 294 (class 1255 OID 16659220)
-- Name: __update_srv_to_ag_when_srv_changed(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.__update_srv_to_ag_when_srv_changed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE r_ RECORD;

BEGIN
    CASE
    WHEN TG_OP = 'INSERT' AND NEW.srv_type_id = 1 THEN

        FOR r_ IN 
            SELECT id FROM agency_agency ag 
            WHERE 
                ag.type = 1
            AND
is_deleted = false
        LOOP
        IF EXISTS ( SELECT * FROM srv_to_ag WHERE srv_id = NEW.srv_id AND ag_id = r_.id ) THEN
        UPDATE srv_to_ag SET state = 'granted' WHERE srv_id = NEW.srv_id AND ag_id = r_.id;
        ELSE
INSERT INTO srv_to_ag (state,srv_id,ag_id) VALUES('granted',NEW.srv_id,r_.id);
        END IF;
        END LOOP;
        RETURN NEW;
        
    WHEN TG_OP = 'INSERT' AND NEW.srv_type_id <> 1 THEN
        UPDATE srv_to_ag SET state = 'cancelled' WHERE srv_id = NEW.srv_id;
        RETURN NEW;
        
    WHEN TG_OP = 'UPDATE' THEN
IF NOT EXISTS( SELECT * FROM srv_data WHERE srv_id = OLD.srv_id AND state = 'enabled' ) THEN
UPDATE srv_to_ag SET state = 'cancelled' WHERE srv_id = OLD.srv_id;
END IF;
RETURN NEW;
        
    ELSE
        RETURN NEW;
    END CASE;
END; 
$$;


ALTER FUNCTION public.__update_srv_to_ag_when_srv_changed() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 181 (class 1259 OID 16659221)
-- Name: activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities (
    id integer NOT NULL,
    agency integer,
    type integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    address integer,
    periodicity public.activity_periodicity NOT NULL,
    name character varying(256) NOT NULL,
    description character varying(4096),
    report character varying(4096),
    email character varying(256),
    phone character varying(27),
    schedule json,
    category integer,
    place integer,
    max_visitor integer,
    state public.entity_state DEFAULT 'enabled'::public.entity_state NOT NULL,
    responsibles integer NOT NULL,
    leaders integer[],
    duration integer,
    quality_index character varying[],
    provided character varying[],
    CONSTRAINT activities_email_check CHECK ((length((email)::text) > 5)),
    CONSTRAINT activities_name_check CHECK ((length(btrim((email)::text)) > 5))
);


ALTER TABLE public.activities OWNER TO postgres;

--
-- TOC entry 2798 (class 0 OID 0)
-- Dependencies: 181
-- Name: TABLE activities; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.activities IS 'мероприятия';


--
-- TOC entry 2799 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.agency; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.agency IS 'учреждение';


--
-- TOC entry 2800 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.type IS 'тип мероприятия';


--
-- TOC entry 2801 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.start_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.start_date IS 'дата начала';


--
-- TOC entry 2802 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.end_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.end_date IS 'дата окончания';


--
-- TOC entry 2803 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.address; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.address IS 'адрес';


--
-- TOC entry 2804 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.periodicity; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.periodicity IS 'периодичность';


--
-- TOC entry 2805 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.name IS 'тема мероприятия';


--
-- TOC entry 2806 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.description IS 'описание';


--
-- TOC entry 2807 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.report; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.report IS 'отчёт';


--
-- TOC entry 2808 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.email IS 'эл.почта';


--
-- TOC entry 2809 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.phone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.phone IS 'телефон';


--
-- TOC entry 2810 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.schedule; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.schedule IS 'расписание';


--
-- TOC entry 2811 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.category; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.category IS 'категория';


--
-- TOC entry 2812 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.place; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.place IS 'Место проведения мероприятия';


--
-- TOC entry 2813 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.max_visitor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.max_visitor IS 'Максимальное количество посетителей';


--
-- TOC entry 2814 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.duration; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.duration IS 'Продолжительность мероприятия';


--
-- TOC entry 2815 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.quality_index; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.quality_index IS 'Показатель качества';


--
-- TOC entry 2816 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN activities.provided; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities.provided IS 'Условия предоставления';


--
-- TOC entry 182 (class 1259 OID 16659230)
-- Name: activities_addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities_addresses (
    id integer NOT NULL,
    latitude double precision,
    longitude double precision,
    postcode public.postcode,
    city character varying(64) NOT NULL,
    street character varying(64),
    building character varying(64),
    city_kladr public.kladr,
    street_kladr public.kladr,
    building_kladr public.kladr,
    location_description character varying(2048)
);


ALTER TABLE public.activities_addresses OWNER TO postgres;

--
-- TOC entry 2817 (class 0 OID 0)
-- Dependencies: 182
-- Name: TABLE activities_addresses; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.activities_addresses IS 'адрес мероприятия';


--
-- TOC entry 2818 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN activities_addresses.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_addresses.id IS 'мероприятие';


--
-- TOC entry 2819 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN activities_addresses.latitude; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_addresses.latitude IS 'широта';


--
-- TOC entry 2820 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN activities_addresses.longitude; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_addresses.longitude IS 'долгота';


--
-- TOC entry 2821 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN activities_addresses.postcode; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_addresses.postcode IS 'почтовый индекс';


--
-- TOC entry 2822 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN activities_addresses.city; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_addresses.city IS 'город';


--
-- TOC entry 2823 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN activities_addresses.street; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_addresses.street IS 'улица';


--
-- TOC entry 2824 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN activities_addresses.building; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_addresses.building IS 'строение';


--
-- TOC entry 2825 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN activities_addresses.city_kladr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_addresses.city_kladr IS 'КЛАДР город';


--
-- TOC entry 2826 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN activities_addresses.street_kladr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_addresses.street_kladr IS 'КЛАДР улица, может быть NULL';


--
-- TOC entry 2827 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN activities_addresses.building_kladr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_addresses.building_kladr IS 'КЛАДР строение';


--
-- TOC entry 2828 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN activities_addresses.location_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_addresses.location_description IS 'описание проезда';


--
-- TOC entry 183 (class 1259 OID 16659236)
-- Name: activities_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activities_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_addresses_id_seq OWNER TO postgres;

--
-- TOC entry 2829 (class 0 OID 0)
-- Dependencies: 183
-- Name: activities_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activities_addresses_id_seq OWNED BY public.activities_addresses.id;


--
-- TOC entry 184 (class 1259 OID 16659238)
-- Name: activities_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities_events (
    id integer NOT NULL,
    activity integer NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    date date NOT NULL,
    address integer,
    report character varying(4096),
    leaders integer[],
    place integer,
    max_visitor integer,
    state public.entity_state DEFAULT 'enabled'::public.entity_state NOT NULL,
    execution_state public.execution_state,
    duration integer,
    quality_index character varying[],
    provided character varying[],
    conducted_leaders integer[]
);


ALTER TABLE public.activities_events OWNER TO postgres;

--
-- TOC entry 2830 (class 0 OID 0)
-- Dependencies: 184
-- Name: TABLE activities_events; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.activities_events IS 'события мероприятий';


--
-- TOC entry 2831 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN activities_events.activity; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_events.activity IS 'мероприятие';


--
-- TOC entry 2832 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN activities_events.start_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_events.start_time IS 'время начала';


--
-- TOC entry 2833 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN activities_events.end_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_events.end_time IS 'время окончания';


--
-- TOC entry 2834 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN activities_events.date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_events.date IS 'дата';


--
-- TOC entry 2835 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN activities_events.address; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_events.address IS 'адрес';


--
-- TOC entry 2836 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN activities_events.report; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_events.report IS 'отчёт';


--
-- TOC entry 2837 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN activities_events.leaders; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_events.leaders IS 'ответственные физлица за событие мероприятия';


--
-- TOC entry 2838 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN activities_events.place; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_events.place IS 'Место проведения мероприятия';


--
-- TOC entry 2839 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN activities_events.max_visitor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_events.max_visitor IS 'Максимальное количество посетителей';


--
-- TOC entry 2840 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN activities_events.duration; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_events.duration IS 'Продолжительность мероприятия';


--
-- TOC entry 2841 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN activities_events.quality_index; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_events.quality_index IS 'Показатель качества';


--
-- TOC entry 2842 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN activities_events.provided; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_events.provided IS 'Условия предоставления';


--
-- TOC entry 2843 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN activities_events.conducted_leaders; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_events.conducted_leaders IS 'Ведущие, которые провели событие';


--
-- TOC entry 185 (class 1259 OID 16659245)
-- Name: activities_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activities_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_events_id_seq OWNER TO postgres;

--
-- TOC entry 2844 (class 0 OID 0)
-- Dependencies: 185
-- Name: activities_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activities_events_id_seq OWNED BY public.activities_events.id;


--
-- TOC entry 186 (class 1259 OID 16659247)
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_id_seq OWNER TO postgres;

--
-- TOC entry 2845 (class 0 OID 0)
-- Dependencies: 186
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activities_id_seq OWNED BY public.activities.id;


--
-- TOC entry 187 (class 1259 OID 16659249)
-- Name: activities_in_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities_in_action (
    activity integer NOT NULL,
    date_end date,
    date_start date NOT NULL,
    action integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.activities_in_action OWNER TO postgres;

--
-- TOC entry 2846 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN activities_in_action.activity; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_in_action.activity IS 'Мероприятие';


--
-- TOC entry 2847 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN activities_in_action.date_end; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_in_action.date_end IS 'Дата окончания участия мероприятия в акции';


--
-- TOC entry 2848 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN activities_in_action.date_start; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_in_action.date_start IS 'Дата начала участия мероприятия в акции';


--
-- TOC entry 2849 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN activities_in_action.action; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_in_action.action IS 'Акция';


--
-- TOC entry 188 (class 1259 OID 16659252)
-- Name: activities_in_action_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activities_in_action_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_in_action_id_seq OWNER TO postgres;

--
-- TOC entry 2850 (class 0 OID 0)
-- Dependencies: 188
-- Name: activities_in_action_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activities_in_action_id_seq OWNED BY public.activities_in_action.id;


--
-- TOC entry 189 (class 1259 OID 16659254)
-- Name: activities_participants_register; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities_participants_register (
    event integer NOT NULL,
    participant integer NOT NULL,
    role integer NOT NULL,
    reg_state public.reg_state DEFAULT 'not_registred'::public.reg_state NOT NULL,
    vis_state public.vis_state DEFAULT 'not_visited'::public.vis_state NOT NULL,
    rating smallint
);


ALTER TABLE public.activities_participants_register OWNER TO postgres;

--
-- TOC entry 2851 (class 0 OID 0)
-- Dependencies: 189
-- Name: TABLE activities_participants_register; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.activities_participants_register IS 'журнал';


--
-- TOC entry 2852 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN activities_participants_register.event; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_participants_register.event IS 'событие';


--
-- TOC entry 2853 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN activities_participants_register.participant; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_participants_register.participant IS 'участник, сотрудник учреждения';


--
-- TOC entry 2854 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN activities_participants_register.role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_participants_register.role IS 'роль участника';


--
-- TOC entry 2855 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN activities_participants_register.reg_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_participants_register.reg_state IS 'Регистрации на событие';


--
-- TOC entry 2856 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN activities_participants_register.vis_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_participants_register.vis_state IS 'Посещение события';


--
-- TOC entry 2857 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN activities_participants_register.rating; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_participants_register.rating IS 'рейтинг';


--
-- TOC entry 190 (class 1259 OID 16659259)
-- Name: activities_photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities_photos (
    id integer NOT NULL,
    activity integer NOT NULL,
    event integer,
    original_size public.file_path,
    small_size public.file_path,
    preview_size public.file_path,
    full_size public.file_path,
    infomat_size public.file_path
);


ALTER TABLE public.activities_photos OWNER TO postgres;

--
-- TOC entry 2858 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN activities_photos.activity; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_photos.activity IS 'мероприятие';


--
-- TOC entry 2859 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN activities_photos.event; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_photos.event IS 'событие';


--
-- TOC entry 2860 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN activities_photos.original_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_photos.original_size IS 'оригинальный размер';


--
-- TOC entry 2861 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN activities_photos.small_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_photos.small_size IS 'малый размер';


--
-- TOC entry 2862 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN activities_photos.preview_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_photos.preview_size IS 'предосмотр';


--
-- TOC entry 2863 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN activities_photos.full_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_photos.full_size IS 'полный размер';


--
-- TOC entry 2864 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN activities_photos.infomat_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_photos.infomat_size IS 'для инфомата';


--
-- TOC entry 191 (class 1259 OID 16659265)
-- Name: activities_photos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activities_photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_photos_id_seq OWNER TO postgres;

--
-- TOC entry 2865 (class 0 OID 0)
-- Dependencies: 191
-- Name: activities_photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activities_photos_id_seq OWNED BY public.activities_photos.id;


--
-- TOC entry 192 (class 1259 OID 16659267)
-- Name: activities_places; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities_places (
    id integer NOT NULL,
    activity integer NOT NULL,
    max_visitor integer NOT NULL,
    registr_place integer
);


ALTER TABLE public.activities_places OWNER TO postgres;

--
-- TOC entry 2866 (class 0 OID 0)
-- Dependencies: 192
-- Name: TABLE activities_places; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.activities_places IS 'Места проведения мероприятий';


--
-- TOC entry 2867 (class 0 OID 0)
-- Dependencies: 192
-- Name: COLUMN activities_places.activity; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_places.activity IS 'Мероприятие';


--
-- TOC entry 2868 (class 0 OID 0)
-- Dependencies: 192
-- Name: COLUMN activities_places.max_visitor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_places.max_visitor IS 'Максимальное количество посетителей';


--
-- TOC entry 193 (class 1259 OID 16659270)
-- Name: activities_places_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activities_places_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_places_id_seq OWNER TO postgres;

--
-- TOC entry 2869 (class 0 OID 0)
-- Dependencies: 193
-- Name: activities_places_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activities_places_id_seq OWNED BY public.activities_places.id;


--
-- TOC entry 194 (class 1259 OID 16659272)
-- Name: activities_places_registr; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities_places_registr (
    id integer NOT NULL,
    name character varying(256),
    state public.entity_state DEFAULT 'enabled'::public.entity_state
);


ALTER TABLE public.activities_places_registr OWNER TO postgres;

--
-- TOC entry 2870 (class 0 OID 0)
-- Dependencies: 194
-- Name: TABLE activities_places_registr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.activities_places_registr IS 'Перечень мест проведения мероприятий';


--
-- TOC entry 2871 (class 0 OID 0)
-- Dependencies: 194
-- Name: COLUMN activities_places_registr.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_places_registr.name IS 'Место проведения мероприятия';


--
-- TOC entry 2872 (class 0 OID 0)
-- Dependencies: 194
-- Name: COLUMN activities_places_registr.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_places_registr.state IS 'Состояние записи';


--
-- TOC entry 195 (class 1259 OID 16659276)
-- Name: activities_places_registr_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activities_places_registr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_places_registr_id_seq OWNER TO postgres;

--
-- TOC entry 2873 (class 0 OID 0)
-- Dependencies: 195
-- Name: activities_places_registr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activities_places_registr_id_seq OWNED BY public.activities_places_registr.id;


--
-- TOC entry 196 (class 1259 OID 16659278)
-- Name: activities_rewards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities_rewards (
    id integer NOT NULL,
    action integer NOT NULL,
    sponsor integer NOT NULL,
    scores integer NOT NULL,
    total_rewards integer NOT NULL,
    remain_rewards integer NOT NULL,
    name character varying(128) NOT NULL,
    region character varying[],
    district character varying[],
    state public.entity_state DEFAULT 'enabled'::public.entity_state NOT NULL,
    category integer,
    CONSTRAINT activities_rewards_remain_rewards_check CHECK ((remain_rewards >= 0))
);


ALTER TABLE public.activities_rewards OWNER TO postgres;

--
-- TOC entry 2874 (class 0 OID 0)
-- Dependencies: 196
-- Name: TABLE activities_rewards; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.activities_rewards IS 'Фотографии/логотип вознаграждения на акциях мероприятий';


--
-- TOC entry 2875 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN activities_rewards.action; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_rewards.action IS 'акция';


--
-- TOC entry 2876 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN activities_rewards.sponsor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_rewards.sponsor IS 'спонсор';


--
-- TOC entry 2877 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN activities_rewards.scores; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_rewards.scores IS 'количество баллов для получения наград';


--
-- TOC entry 2878 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN activities_rewards.total_rewards; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_rewards.total_rewards IS 'всего наград от спонсора';


--
-- TOC entry 2879 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN activities_rewards.remain_rewards; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_rewards.remain_rewards IS 'остаток наград от спонсора';


--
-- TOC entry 2880 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN activities_rewards.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_rewards.name IS 'наименование награды';


--
-- TOC entry 2881 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN activities_rewards.region; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_rewards.region IS 'Код округа города Москвы для к-го проводится акция';


--
-- TOC entry 197 (class 1259 OID 16659286)
-- Name: activities_rewards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activities_rewards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_rewards_id_seq OWNER TO postgres;

--
-- TOC entry 2882 (class 0 OID 0)
-- Dependencies: 197
-- Name: activities_rewards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activities_rewards_id_seq OWNED BY public.activities_rewards.id;


--
-- TOC entry 198 (class 1259 OID 16659288)
-- Name: activities_rewards_photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities_rewards_photos (
    id integer NOT NULL,
    reward integer NOT NULL,
    original_size public.file_path,
    small_size public.file_path,
    preview_size public.file_path,
    full_size public.file_path,
    infomat_size public.file_path
);


ALTER TABLE public.activities_rewards_photos OWNER TO postgres;

--
-- TOC entry 2883 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN activities_rewards_photos.reward; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_rewards_photos.reward IS 'вознаграждение';


--
-- TOC entry 2884 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN activities_rewards_photos.original_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_rewards_photos.original_size IS 'оригинальный размер';


--
-- TOC entry 2885 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN activities_rewards_photos.small_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_rewards_photos.small_size IS 'малый размер';


--
-- TOC entry 2886 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN activities_rewards_photos.preview_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_rewards_photos.preview_size IS 'предосмотр';


--
-- TOC entry 2887 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN activities_rewards_photos.full_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_rewards_photos.full_size IS 'полный размер';


--
-- TOC entry 2888 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN activities_rewards_photos.infomat_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_rewards_photos.infomat_size IS 'для инфомата';


--
-- TOC entry 199 (class 1259 OID 16659294)
-- Name: activities_rewards_photos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activities_rewards_photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_rewards_photos_id_seq OWNER TO postgres;

--
-- TOC entry 2889 (class 0 OID 0)
-- Dependencies: 199
-- Name: activities_rewards_photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activities_rewards_photos_id_seq OWNED BY public.activities_rewards_photos.id;


--
-- TOC entry 200 (class 1259 OID 16659296)
-- Name: activities_scoring_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities_scoring_rules (
    activity integer NOT NULL,
    role integer NOT NULL,
    scores integer NOT NULL
);


ALTER TABLE public.activities_scoring_rules OWNER TO postgres;

--
-- TOC entry 2890 (class 0 OID 0)
-- Dependencies: 200
-- Name: TABLE activities_scoring_rules; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.activities_scoring_rules IS 'правила начисления баллов на акции мероприятия';


--
-- TOC entry 2891 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN activities_scoring_rules.activity; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_scoring_rules.activity IS 'мероприятие';


--
-- TOC entry 2892 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN activities_scoring_rules.role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_scoring_rules.role IS 'роль участника на мероприятии';


--
-- TOC entry 2893 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN activities_scoring_rules.scores; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.activities_scoring_rules.scores IS 'балы за участие в мероприятии';


--
-- TOC entry 201 (class 1259 OID 16659299)
-- Name: agency_agency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_agency (
    id integer NOT NULL,
    region_id integer DEFAULT 1 NOT NULL,
    headagency_id integer,
    aorg_id integer DEFAULT 1 NOT NULL,
    atype_id integer DEFAULT 0 NOT NULL,
    astrt character varying(256) DEFAULT 0 NOT NULL,
    fullname character varying(256),
    shortname character varying(256),
    phone character varying(256),
    address character varying(3000),
    email character varying(75),
    www character varying(200),
    skype character varying(256),
    ride_description text,
    ride_scheme character varying(100),
    photo character varying(100),
    description text,
    mtime timestamp without time zone,
    atime timestamp without time zone,
    inn character varying(50),
    origin_name character varying(256),
    timetable json DEFAULT '{"mon":"f","monstart":"09:00","monend":"18:00","tue":"f","tuestart":"09:00","tueend":"18:00","wen":"f","wenstart":"09:00","wenend":"18:00","thu":"f","thustart":"09:00","thuend":"18:00","fri":"f","fristart":"09:00","friend":"18:00","sat":"f","satstart":"09:00","satend":"18:00","sun":"f","sunstart":"09:00","sunend":"18:00"}'::json,
    number character varying,
    dtype_id integer,
    last_agency_id integer,
    last_dep_id integer,
    is_deleted boolean DEFAULT false,
    mon boolean DEFAULT false,
    monstart time without time zone DEFAULT '09:00:00'::time without time zone,
    monend time without time zone DEFAULT '18:00:00'::time without time zone,
    tue boolean DEFAULT false,
    tuestart time without time zone DEFAULT '09:00:00'::time without time zone,
    tueend time without time zone DEFAULT '18:00:00'::time without time zone,
    wen boolean DEFAULT false,
    wenstart time without time zone DEFAULT '09:00:00'::time without time zone,
    wenend time without time zone DEFAULT '18:00:00'::time without time zone,
    thu boolean DEFAULT false,
    thustart time without time zone DEFAULT '09:00:00'::time without time zone,
    thuend time without time zone DEFAULT '18:00:00'::time without time zone,
    fri boolean DEFAULT false,
    fristart time without time zone DEFAULT '09:00:00'::time without time zone,
    friend time without time zone DEFAULT '18:00:00'::time without time zone,
    sat boolean DEFAULT false,
    satstart time without time zone DEFAULT '09:00:00'::time without time zone,
    satend time without time zone DEFAULT '18:00:00'::time without time zone,
    sun boolean DEFAULT false,
    sunstart time without time zone DEFAULT '09:00:00'::time without time zone,
    sunend time without time zone DEFAULT '18:00:00'::time without time zone,
    city character varying,
    street character varying,
    housing character varying,
    apartment character varying,
    address_comment character varying,
    coords character varying,
    cparent_id bigint,
    sparent_id bigint,
    okato bigint,
    zip integer,
    created_by character varying,
    edited_by character varying,
    settl_acc character varying,
    pers_acc character varying,
    bank_name character varying,
    bik character varying,
    kpp character varying,
    type integer DEFAULT 0
);


ALTER TABLE public.agency_agency OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16659333)
-- Name: agency_agency_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agency_agency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_agency_id_seq OWNER TO postgres;

--
-- TOC entry 2894 (class 0 OID 0)
-- Dependencies: 202
-- Name: agency_agency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agency_agency_id_seq OWNED BY public.agency_agency.id;


--
-- TOC entry 203 (class 1259 OID 16659335)
-- Name: agency_agencycategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_agencycategory (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    atype character varying(64) NOT NULL,
    herb character varying(100)
);


ALTER TABLE public.agency_agencycategory OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16659338)
-- Name: agency_agencycategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agency_agencycategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_agencycategory_id_seq OWNER TO postgres;

--
-- TOC entry 2895 (class 0 OID 0)
-- Dependencies: 204
-- Name: agency_agencycategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agency_agencycategory_id_seq OWNED BY public.agency_agencycategory.id;


--
-- TOC entry 205 (class 1259 OID 16659340)
-- Name: agency_agencyhead; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_agencyhead (
    id integer NOT NULL,
    surname character varying(256) NOT NULL,
    firstname character varying(256) NOT NULL,
    fathername character varying(256) NOT NULL,
    agency_id integer NOT NULL,
    post character varying(256) NOT NULL
);


ALTER TABLE public.agency_agencyhead OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16659346)
-- Name: agency_agencyhead_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agency_agencyhead_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_agencyhead_id_seq OWNER TO postgres;

--
-- TOC entry 2896 (class 0 OID 0)
-- Dependencies: 206
-- Name: agency_agencyhead_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agency_agencyhead_id_seq OWNED BY public.agency_agencyhead.id;


--
-- TOC entry 207 (class 1259 OID 16659348)
-- Name: agency_cl_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_cl_option (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    public_name character varying(256) NOT NULL,
    option_type character varying(256) NOT NULL
);


ALTER TABLE public.agency_cl_option OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16659354)
-- Name: agency_cl_option_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agency_cl_option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_cl_option_id_seq OWNER TO postgres;

--
-- TOC entry 2897 (class 0 OID 0)
-- Dependencies: 208
-- Name: agency_cl_option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agency_cl_option_id_seq OWNED BY public.agency_cl_option.id;


--
-- TOC entry 209 (class 1259 OID 16659356)
-- Name: agency_departmenttype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_departmenttype (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    dtype character varying(64) NOT NULL,
    herb character varying(100)
);


ALTER TABLE public.agency_departmenttype OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16659359)
-- Name: agency_departmenttype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agency_departmenttype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_departmenttype_id_seq OWNER TO postgres;

--
-- TOC entry 2898 (class 0 OID 0)
-- Dependencies: 210
-- Name: agency_departmenttype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agency_departmenttype_id_seq OWNED BY public.agency_departmenttype.id;


--
-- TOC entry 211 (class 1259 OID 16659361)
-- Name: agency_district; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_district (
    id integer NOT NULL,
    fullname character varying(256) NOT NULL,
    shortname character varying(256) NOT NULL,
    description text,
    herb character varying(100) NOT NULL,
    free_rgb character varying(11),
    select_rgb character varying(11),
    mapreg character varying(100)
);


ALTER TABLE public.agency_district OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16659367)
-- Name: agency_district_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agency_district_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_district_id_seq OWNER TO postgres;

--
-- TOC entry 2899 (class 0 OID 0)
-- Dependencies: 212
-- Name: agency_district_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agency_district_id_seq OWNED BY public.agency_district.id;


--
-- TOC entry 213 (class 1259 OID 16659369)
-- Name: agency_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_event (
    id integer NOT NULL,
    agency_id integer,
    type_id integer,
    country_id integer,
    region character varying(256),
    city character varying(256),
    street character varying(256),
    hous character varying(256),
    building character varying(256),
    apartment character varying(256),
    rparent_id bigint,
    cparent_id bigint,
    sparent_id bigint,
    hparent_id bigint,
    email character varying(256),
    ride_description character varying,
    log character varying,
    name character varying,
    description character varying,
    atime timestamp without time zone,
    mtime timestamp without time zone,
    created_by character varying,
    edited_by character varying,
    tmp_prev_id integer
);


ALTER TABLE public.agency_event OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16659375)
-- Name: agency_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agency_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_event_id_seq OWNER TO postgres;

--
-- TOC entry 2900 (class 0 OID 0)
-- Dependencies: 214
-- Name: agency_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agency_event_id_seq OWNED BY public.agency_event.id;


--
-- TOC entry 215 (class 1259 OID 16659377)
-- Name: agency_infomat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_infomat (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    agency_id integer NOT NULL
);


ALTER TABLE public.agency_infomat OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16659380)
-- Name: agency_infomat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agency_infomat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_infomat_id_seq OWNER TO postgres;

--
-- TOC entry 2901 (class 0 OID 0)
-- Dependencies: 216
-- Name: agency_infomat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agency_infomat_id_seq OWNED BY public.agency_infomat.id;


--
-- TOC entry 217 (class 1259 OID 16659382)
-- Name: agency_photo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_photo (
    id integer NOT NULL,
    agency_id integer,
    description character varying(256),
    path_o character varying,
    path_s character varying,
    path_p character varying,
    path_f character varying,
    path_t character varying,
    seq integer
);


ALTER TABLE public.agency_photo OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16659388)
-- Name: agency_photo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agency_photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_photo_id_seq OWNER TO postgres;

--
-- TOC entry 2902 (class 0 OID 0)
-- Dependencies: 218
-- Name: agency_photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agency_photo_id_seq OWNED BY public.agency_photo.id;


--
-- TOC entry 219 (class 1259 OID 16659390)
-- Name: agency_region; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_region (
    id integer NOT NULL,
    district_id integer NOT NULL,
    fullname character varying(256) NOT NULL,
    shortname character varying(256) NOT NULL,
    description text,
    herb character varying(100) NOT NULL,
    free_rgb character varying(11),
    select_rgb character varying(11)
);


ALTER TABLE public.agency_region OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16659396)
-- Name: agency_region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agency_region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_region_id_seq OWNER TO postgres;

--
-- TOC entry 2903 (class 0 OID 0)
-- Dependencies: 220
-- Name: agency_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agency_region_id_seq OWNED BY public.agency_region.id;


--
-- TOC entry 221 (class 1259 OID 16659398)
-- Name: agency_screenfiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_screenfiles (
    id integer NOT NULL,
    screensaver_id integer NOT NULL,
    link_file character varying(256) NOT NULL,
    number_in_query integer NOT NULL,
    file_type character varying(256)
);


ALTER TABLE public.agency_screenfiles OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16659404)
-- Name: agency_screenfiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agency_screenfiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_screenfiles_id_seq OWNER TO postgres;

--
-- TOC entry 2904 (class 0 OID 0)
-- Dependencies: 222
-- Name: agency_screenfiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agency_screenfiles_id_seq OWNED BY public.agency_screenfiles.id;


--
-- TOC entry 223 (class 1259 OID 16659406)
-- Name: agency_screensaver_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_screensaver_option (
    id integer NOT NULL,
    screensaver_id integer NOT NULL,
    option_id integer NOT NULL,
    value integer NOT NULL
);


ALTER TABLE public.agency_screensaver_option OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16659409)
-- Name: agency_screensaver_option_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agency_screensaver_option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_screensaver_option_id_seq OWNER TO postgres;

--
-- TOC entry 2905 (class 0 OID 0)
-- Dependencies: 224
-- Name: agency_screensaver_option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agency_screensaver_option_id_seq OWNED BY public.agency_screensaver_option.id;


--
-- TOC entry 225 (class 1259 OID 16659411)
-- Name: agency_screensavers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_screensavers (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    description text,
    active boolean NOT NULL,
    id_agency integer
);


ALTER TABLE public.agency_screensavers OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16659417)
-- Name: agency_screensavers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agency_screensavers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_screensavers_id_seq OWNER TO postgres;

--
-- TOC entry 2906 (class 0 OID 0)
-- Dependencies: 226
-- Name: agency_screensavers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agency_screensavers_id_seq OWNED BY public.agency_screensavers.id;


--
-- TOC entry 227 (class 1259 OID 16659419)
-- Name: agency_servicewhom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_servicewhom (
    id integer NOT NULL,
    name character varying(256) NOT NULL
);


ALTER TABLE public.agency_servicewhom OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16659422)
-- Name: agency_servicewhom_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agency_servicewhom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agency_servicewhom_id_seq OWNER TO postgres;

--
-- TOC entry 2907 (class 0 OID 0)
-- Dependencies: 228
-- Name: agency_servicewhom_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agency_servicewhom_id_seq OWNED BY public.agency_servicewhom.id;


--
-- TOC entry 229 (class 1259 OID 16659424)
-- Name: agency_tree; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agency_tree (
    ancestor integer NOT NULL,
    descendant integer NOT NULL,
    length integer
);


ALTER TABLE public.agency_tree OWNER TO postgres;

--
-- TOC entry 2908 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE agency_tree; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.agency_tree IS 'дерево групп';


--
-- TOC entry 2909 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN agency_tree.ancestor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.agency_tree.ancestor IS 'предок';


--
-- TOC entry 2910 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN agency_tree.descendant; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.agency_tree.descendant IS 'потомок';


--
-- TOC entry 2911 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN agency_tree.length; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.agency_tree.length IS 'Значение path_length ссылки узла на самого себя равно 0, 
значение path_length прямого дочернего объекта этого узла равно 1, значение path_length внучатого объекта узла равно 2 и  так далее.';


--
-- TOC entry 230 (class 1259 OID 16659427)
-- Name: event_photo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_photo (
    id integer NOT NULL,
    event_id integer,
    description character varying,
    seq integer,
    path_o character varying,
    path_s character varying,
    path_p character varying,
    path_f character varying,
    path_t character varying
);


ALTER TABLE public.event_photo OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16659433)
-- Name: event_photo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_photo_id_seq OWNER TO postgres;

--
-- TOC entry 2912 (class 0 OID 0)
-- Dependencies: 231
-- Name: event_photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_photo_id_seq OWNED BY public.event_photo.id;


--
-- TOC entry 232 (class 1259 OID 16659435)
-- Name: event_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_schedule (
    id integer NOT NULL,
    event_id integer,
    sd date,
    ed date,
    st time without time zone,
    et time without time zone,
    sun boolean,
    mon boolean,
    tue boolean,
    wed boolean,
    thu boolean,
    fri boolean,
    sat boolean,
    suns time without time zone,
    sune time without time zone,
    mons time without time zone,
    mone time without time zone,
    tues time without time zone,
    tuee time without time zone,
    weds time without time zone,
    wede time without time zone,
    thus time without time zone,
    thue time without time zone,
    fris time without time zone,
    frie time without time zone,
    sats time without time zone,
    sate time without time zone,
    schedule_type_id integer,
    cycle_type_id integer,
    seq integer,
    custom_type_id boolean
);


ALTER TABLE public.event_schedule OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16659438)
-- Name: event_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_schedule_id_seq OWNER TO postgres;

--
-- TOC entry 2913 (class 0 OID 0)
-- Dependencies: 233
-- Name: event_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_schedule_id_seq OWNED BY public.event_schedule.id;


--
-- TOC entry 234 (class 1259 OID 16659440)
-- Name: event_schedule_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_schedule_type (
    id integer NOT NULL,
    text character varying
);


ALTER TABLE public.event_schedule_type OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16659446)
-- Name: event_schedule_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_schedule_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_schedule_type_id_seq OWNER TO postgres;

--
-- TOC entry 2914 (class 0 OID 0)
-- Dependencies: 235
-- Name: event_schedule_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_schedule_type_id_seq OWNED BY public.event_schedule_type.id;


--
-- TOC entry 236 (class 1259 OID 16659448)
-- Name: event_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_type (
    id integer NOT NULL,
    text character varying
);


ALTER TABLE public.event_type OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16659454)
-- Name: event_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_type_id_seq OWNER TO postgres;

--
-- TOC entry 2915 (class 0 OID 0)
-- Dependencies: 237
-- Name: event_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_type_id_seq OWNED BY public.event_type.id;


--
-- TOC entry 238 (class 1259 OID 16659456)
-- Name: rewards_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rewards_categories (
    id integer NOT NULL,
    category_name character varying,
    state public.entity_state DEFAULT 'enabled'::public.entity_state
);


ALTER TABLE public.rewards_categories OWNER TO postgres;

--
-- TOC entry 2916 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE rewards_categories; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.rewards_categories IS 'Категории поощрений';


--
-- TOC entry 2917 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN rewards_categories.category_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rewards_categories.category_name IS 'Наименование категории';


--
-- TOC entry 2918 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN rewards_categories.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rewards_categories.state IS 'Состояние категории';


--
-- TOC entry 239 (class 1259 OID 16659463)
-- Name: rewards_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rewards_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rewards_categories_id_seq OWNER TO postgres;

--
-- TOC entry 2919 (class 0 OID 0)
-- Dependencies: 239
-- Name: rewards_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rewards_categories_id_seq OWNED BY public.rewards_categories.id;


--
-- TOC entry 240 (class 1259 OID 16659465)
-- Name: rewards_receipt_register; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rewards_receipt_register (
    id integer NOT NULL,
    reward integer,
    addend integer,
    user_id integer,
    date timestamp without time zone DEFAULT now(),
    cause character varying(1024)
);


ALTER TABLE public.rewards_receipt_register OWNER TO postgres;

--
-- TOC entry 2920 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE rewards_receipt_register; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.rewards_receipt_register IS 'Учёт поступления/списания поощрений';


--
-- TOC entry 2921 (class 0 OID 0)
-- Dependencies: 240
-- Name: COLUMN rewards_receipt_register.reward; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rewards_receipt_register.reward IS 'Поощрение';


--
-- TOC entry 2922 (class 0 OID 0)
-- Dependencies: 240
-- Name: COLUMN rewards_receipt_register.addend; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rewards_receipt_register.addend IS 'Добавленное/списанное(если отрицательное) кол-во поощрений.';


--
-- TOC entry 2923 (class 0 OID 0)
-- Dependencies: 240
-- Name: COLUMN rewards_receipt_register.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rewards_receipt_register.user_id IS 'ID пользователя СА, совершившего операцию';


--
-- TOC entry 2924 (class 0 OID 0)
-- Dependencies: 240
-- Name: COLUMN rewards_receipt_register.date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rewards_receipt_register.date IS 'Дата операции';


--
-- TOC entry 241 (class 1259 OID 16659472)
-- Name: rewards_receipt_register_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rewards_receipt_register_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rewards_receipt_register_id_seq OWNER TO postgres;

--
-- TOC entry 2925 (class 0 OID 0)
-- Dependencies: 241
-- Name: rewards_receipt_register_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rewards_receipt_register_id_seq OWNED BY public.rewards_receipt_register.id;


--
-- TOC entry 242 (class 1259 OID 16659474)
-- Name: rf_actions_sponsors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rf_actions_sponsors (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    state public.entity_state DEFAULT 'enabled'::public.entity_state NOT NULL,
    description character varying,
    original_size public.file_path,
    small_size public.file_path,
    preview_size public.file_path,
    full_size public.file_path,
    infomat_size public.file_path,
    contact_fio character varying(128),
    contact_phone character varying(27),
    contact_email character varying(256),
    director_fio character varying(128),
    director_phone character varying(27),
    director_email character varying(256),
    region character varying[],
    district character varying[],
    agency integer,
    CONSTRAINT rf_actions_sponsors_contact_email_check CHECK ((length((contact_email)::text) > 5)),
    CONSTRAINT rf_actions_sponsors_director_email_check CHECK ((length((director_email)::text) > 5)),
    CONSTRAINT rf_actions_sponsors_name_check CHECK ((length(regexp_replace(btrim((name)::text), '\s+'::text, ' '::text, 'g'::text)) > 3))
);


ALTER TABLE public.rf_actions_sponsors OWNER TO postgres;

--
-- TOC entry 2926 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE rf_actions_sponsors; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.rf_actions_sponsors IS 'спонсоры акций';


--
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rf_actions_sponsors.original_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_actions_sponsors.original_size IS 'Оригинальный размер';


--
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rf_actions_sponsors.small_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_actions_sponsors.small_size IS 'Малый размер';


--
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rf_actions_sponsors.preview_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_actions_sponsors.preview_size IS 'Предпросмотр';


--
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rf_actions_sponsors.full_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_actions_sponsors.full_size IS 'Полный размер';


--
-- TOC entry 2931 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rf_actions_sponsors.infomat_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_actions_sponsors.infomat_size IS 'Для инфомата';


--
-- TOC entry 2932 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rf_actions_sponsors.contact_fio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_actions_sponsors.contact_fio IS 'ФИО контактного лица';


--
-- TOC entry 2933 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rf_actions_sponsors.contact_phone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_actions_sponsors.contact_phone IS 'Номер телефона контактного лица';


--
-- TOC entry 2934 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rf_actions_sponsors.contact_email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_actions_sponsors.contact_email IS 'Электронный адрес контактного лица';


--
-- TOC entry 2935 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rf_actions_sponsors.director_fio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_actions_sponsors.director_fio IS 'ФИО директора';


--
-- TOC entry 2936 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rf_actions_sponsors.director_phone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_actions_sponsors.director_phone IS 'Номер телефона директора';


--
-- TOC entry 2937 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rf_actions_sponsors.director_email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_actions_sponsors.director_email IS 'Электронный адрес директора';


--
-- TOC entry 2938 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rf_actions_sponsors.region; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_actions_sponsors.region IS 'Код округа города Москвы для к-го проводится акция';


--
-- TOC entry 2939 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rf_actions_sponsors.agency; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_actions_sponsors.agency IS 'Головное учреждение, к-му принадлежит социальный партнёр';


--
-- TOC entry 243 (class 1259 OID 16659484)
-- Name: rf_actions_sponsors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rf_actions_sponsors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rf_actions_sponsors_id_seq OWNER TO postgres;

--
-- TOC entry 2940 (class 0 OID 0)
-- Dependencies: 243
-- Name: rf_actions_sponsors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rf_actions_sponsors_id_seq OWNED BY public.rf_actions_sponsors.id;


--
-- TOC entry 244 (class 1259 OID 16659486)
-- Name: rf_activities_actions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rf_activities_actions (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    state public.entity_state DEFAULT 'enabled'::public.entity_state NOT NULL,
    CONSTRAINT rf_activities_actions_name_check CHECK ((length(regexp_replace(btrim((name)::text), '\s+'::text, ' '::text, 'g'::text)) > 3))
);


ALTER TABLE public.rf_activities_actions OWNER TO postgres;

--
-- TOC entry 2941 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE rf_activities_actions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.rf_activities_actions IS 'акции мероприятий';


--
-- TOC entry 2942 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN rf_activities_actions.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_activities_actions.name IS 'наименование';


--
-- TOC entry 2943 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN rf_activities_actions.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_activities_actions.state IS 'состояние : активен, не активен, удалён';


--
-- TOC entry 245 (class 1259 OID 16659491)
-- Name: rf_activities_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rf_activities_actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rf_activities_actions_id_seq OWNER TO postgres;

--
-- TOC entry 2944 (class 0 OID 0)
-- Dependencies: 245
-- Name: rf_activities_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rf_activities_actions_id_seq OWNED BY public.rf_activities_actions.id;


--
-- TOC entry 246 (class 1259 OID 16659493)
-- Name: rf_activities_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rf_activities_categories (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    state public.entity_state DEFAULT 'enabled'::public.entity_state NOT NULL,
    original_size public.file_path,
    small_size public.file_path,
    preview_size public.file_path,
    full_size public.file_path,
    infomat_size public.file_path,
    CONSTRAINT rf_activities_categories_check CHECK ((length(regexp_replace(btrim((name)::text), '\s+'::text, ' '::text, 'g'::text)) > 3))
);


ALTER TABLE public.rf_activities_categories OWNER TO postgres;

--
-- TOC entry 2945 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE rf_activities_categories; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.rf_activities_categories IS 'категории мероприятий';


--
-- TOC entry 2946 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN rf_activities_categories.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_activities_categories.name IS 'наименование';


--
-- TOC entry 2947 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN rf_activities_categories.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_activities_categories.state IS 'состояние : активен, не активен, удалён';


--
-- TOC entry 2948 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN rf_activities_categories.original_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_activities_categories.original_size IS 'оригинальный размер';


--
-- TOC entry 2949 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN rf_activities_categories.small_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_activities_categories.small_size IS 'малый размер';


--
-- TOC entry 2950 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN rf_activities_categories.preview_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_activities_categories.preview_size IS 'предосмотр';


--
-- TOC entry 2951 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN rf_activities_categories.full_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_activities_categories.full_size IS 'полный размер';


--
-- TOC entry 2952 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN rf_activities_categories.infomat_size; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_activities_categories.infomat_size IS 'для инфомата';


--
-- TOC entry 247 (class 1259 OID 16659501)
-- Name: rf_activities_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rf_activities_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rf_activities_categories_id_seq OWNER TO postgres;

--
-- TOC entry 2953 (class 0 OID 0)
-- Dependencies: 247
-- Name: rf_activities_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rf_activities_categories_id_seq OWNED BY public.rf_activities_categories.id;


--
-- TOC entry 248 (class 1259 OID 16659503)
-- Name: rf_activities_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rf_activities_roles (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    state public.entity_state DEFAULT 'enabled'::public.entity_state NOT NULL,
    "default" boolean DEFAULT false,
    CONSTRAINT rf_activities_roles_name_check CHECK ((length(regexp_replace(btrim((name)::text), '\s+'::text, ' '::text, 'g'::text)) > 3))
);


ALTER TABLE public.rf_activities_roles OWNER TO postgres;

--
-- TOC entry 2954 (class 0 OID 0)
-- Dependencies: 248
-- Name: TABLE rf_activities_roles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.rf_activities_roles IS 'роли мероприятий';


--
-- TOC entry 2955 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN rf_activities_roles.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_activities_roles.name IS 'наименование';


--
-- TOC entry 2956 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN rf_activities_roles.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_activities_roles.state IS 'состояние : активен, не активен, удалён';


--
-- TOC entry 2957 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN rf_activities_roles."default"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_activities_roles."default" IS 'Роль по умолчанию для вывода кол-ва баллов за участие в мероприятии. Роль по умолчанию назначаемая всем посетителям во время регистрации';


--
-- TOC entry 249 (class 1259 OID 16659509)
-- Name: rf_activities_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rf_activities_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rf_activities_roles_id_seq OWNER TO postgres;

--
-- TOC entry 2958 (class 0 OID 0)
-- Dependencies: 249
-- Name: rf_activities_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rf_activities_roles_id_seq OWNED BY public.rf_activities_roles.id;


--
-- TOC entry 250 (class 1259 OID 16659511)
-- Name: rf_activities_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rf_activities_types (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    state public.entity_state DEFAULT 'enabled'::public.entity_state NOT NULL,
    CONSTRAINT activities_types_name_check CHECK ((length(regexp_replace(btrim((name)::text), '\s+'::text, ' '::text, 'g'::text)) > 3))
);


ALTER TABLE public.rf_activities_types OWNER TO postgres;

--
-- TOC entry 2959 (class 0 OID 0)
-- Dependencies: 250
-- Name: TABLE rf_activities_types; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.rf_activities_types IS 'типы мероприятий';


--
-- TOC entry 2960 (class 0 OID 0)
-- Dependencies: 250
-- Name: COLUMN rf_activities_types.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_activities_types.name IS 'наименование';


--
-- TOC entry 2961 (class 0 OID 0)
-- Dependencies: 250
-- Name: COLUMN rf_activities_types.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.rf_activities_types.state IS 'состояние : активен, не активен, удалён';


--
-- TOC entry 251 (class 1259 OID 16659516)
-- Name: rf_activities_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rf_activities_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rf_activities_types_id_seq OWNER TO postgres;

--
-- TOC entry 2962 (class 0 OID 0)
-- Dependencies: 251
-- Name: rf_activities_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rf_activities_types_id_seq OWNED BY public.rf_activities_types.id;


--
-- TOC entry 252 (class 1259 OID 16659518)
-- Name: srv; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.srv (
    id integer NOT NULL,
    name_ character varying,
    act_ character varying,
    a_res_fin_ numeric(10,2) DEFAULT 0,
    a_res_mat_ character varying,
    a_res_pers_id_ integer DEFAULT 1,
    p_res_fin_ numeric(10,2) DEFAULT 0,
    p_res_mat_ character varying,
    descr_ character varying,
    aim_ character varying,
    time_ integer,
    comment_ character varying,
    price_ numeric(10,2) DEFAULT 0,
    price_h_ numeric(10,2) DEFAULT 0,
    srv_cat_id_ integer,
    lab_ integer,
    code_ character varying,
    srv_type_id_ integer,
    type_id_ integer,
    is_deleted boolean DEFAULT false,
    path_o_ character varying,
    path_b_ character varying,
    path_s_ character varying,
    path_p_ character varying,
    path_ps_ character varying,
    path_t_ character varying,
    srv_st_type_ integer,
    test boolean DEFAULT false,
    plc_ character varying,
    plc_start_ character varying,
    plc_end_ character varying,
    level_ integer,
    urgent_ boolean DEFAULT false,
    shortname character varying,
    periodicity_ integer,
    frequence_ integer
);


ALTER TABLE public.srv OWNER TO postgres;

--
-- TOC entry 2963 (class 0 OID 0)
-- Dependencies: 252
-- Name: COLUMN srv.periodicity_; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.srv.periodicity_ IS 'Периодичность оказания услуги согласно нормативам';


--
-- TOC entry 2964 (class 0 OID 0)
-- Dependencies: 252
-- Name: COLUMN srv.frequence_; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.srv.frequence_ IS 'Частота оказания услуги согласно нормативам';


--
-- TOC entry 253 (class 1259 OID 16659532)
-- Name: srv_cat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.srv_cat (
    id integer NOT NULL,
    text character varying,
    img character varying,
    path_o character varying,
    path_b character varying,
    path_s character varying,
    path_p character varying,
    path_ps character varying,
    path_t character varying
);


ALTER TABLE public.srv_cat OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 16659538)
-- Name: srv_cat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.srv_cat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.srv_cat_id_seq OWNER TO postgres;

--
-- TOC entry 2965 (class 0 OID 0)
-- Dependencies: 254
-- Name: srv_cat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.srv_cat_id_seq OWNED BY public.srv_cat.id;


--
-- TOC entry 255 (class 1259 OID 16659540)
-- Name: srv_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.srv_data (
    id integer NOT NULL,
    srv_id integer NOT NULL,
    name character varying,
    act character varying,
    a_res_fin numeric(10,2),
    a_res_mat character varying,
    a_res_pers_id integer,
    p_res_fin numeric(10,2),
    p_res_mat character varying,
    descr character varying,
    aim character varying,
    "time" integer,
    comment character varying,
    price numeric(10,2),
    price_h numeric(10,2),
    srv_cat_id integer,
    lab integer,
    code character varying,
    srv_type_id integer,
    type_id integer,
    path_o character varying,
    path_b character varying,
    path_s character varying,
    path_p character varying,
    path_ps character varying,
    path_t character varying,
    srv_st_type integer,
    plc character varying,
    plc_start character varying,
    plc_end character varying,
    level integer,
    urgent boolean,
    periodicity integer,
    frequence integer,
    date_on date,
    date_off date,
    state public.state,
    CONSTRAINT srv_data_date_off_more_than_date_on CHECK ((date_off >= date_on))
);


ALTER TABLE public.srv_data OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 16659547)
-- Name: srv_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.srv_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.srv_data_id_seq OWNER TO postgres;

--
-- TOC entry 2966 (class 0 OID 0)
-- Dependencies: 256
-- Name: srv_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.srv_data_id_seq OWNED BY public.srv_data.id;


--
-- TOC entry 257 (class 1259 OID 16659549)
-- Name: srv_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.srv_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.srv_id_seq OWNER TO postgres;

--
-- TOC entry 2967 (class 0 OID 0)
-- Dependencies: 257
-- Name: srv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.srv_id_seq OWNED BY public.srv.id;


--
-- TOC entry 258 (class 1259 OID 16659551)
-- Name: srv_ifs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.srv_ifs (
    id integer NOT NULL,
    text character varying
);


ALTER TABLE public.srv_ifs OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 16659557)
-- Name: srv_ifs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.srv_ifs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.srv_ifs_id_seq OWNER TO postgres;

--
-- TOC entry 2968 (class 0 OID 0)
-- Dependencies: 259
-- Name: srv_ifs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.srv_ifs_id_seq OWNED BY public.srv_ifs.id;


--
-- TOC entry 260 (class 1259 OID 16659559)
-- Name: srv_ifs_to_srv; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.srv_ifs_to_srv (
    id integer NOT NULL,
    srv_id integer,
    srv_ifs_id integer,
    p_cats character varying,
    srv_docs character varying,
    factor numeric(10,2) DEFAULT 0
);


ALTER TABLE public.srv_ifs_to_srv OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 16659566)
-- Name: srv_ifs_to_srv_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.srv_ifs_to_srv_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.srv_ifs_to_srv_id_seq OWNER TO postgres;

--
-- TOC entry 2969 (class 0 OID 0)
-- Dependencies: 261
-- Name: srv_ifs_to_srv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.srv_ifs_to_srv_id_seq OWNED BY public.srv_ifs_to_srv.id;


--
-- TOC entry 262 (class 1259 OID 16659568)
-- Name: srv_st_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.srv_st_type (
    id integer NOT NULL,
    text character varying
);


ALTER TABLE public.srv_st_type OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 16659574)
-- Name: srv_st_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.srv_st_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.srv_st_type_id_seq OWNER TO postgres;

--
-- TOC entry 2970 (class 0 OID 0)
-- Dependencies: 263
-- Name: srv_st_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.srv_st_type_id_seq OWNED BY public.srv_st_type.id;


--
-- TOC entry 264 (class 1259 OID 16659576)
-- Name: srv_to_ag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.srv_to_ag (
    id integer NOT NULL,
    srv_id integer,
    ag_id integer,
    state character varying DEFAULT 'new'::character varying
);


ALTER TABLE public.srv_to_ag OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 16659583)
-- Name: srv_to_ag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.srv_to_ag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.srv_to_ag_id_seq OWNER TO postgres;

--
-- TOC entry 2971 (class 0 OID 0)
-- Dependencies: 265
-- Name: srv_to_ag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.srv_to_ag_id_seq OWNED BY public.srv_to_ag.id;


--
-- TOC entry 266 (class 1259 OID 16659585)
-- Name: srv_tree; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.srv_tree (
    ancestor integer NOT NULL,
    descendant integer NOT NULL,
    length integer
);


ALTER TABLE public.srv_tree OWNER TO postgres;

--
-- TOC entry 2972 (class 0 OID 0)
-- Dependencies: 266
-- Name: TABLE srv_tree; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.srv_tree IS 'дерево групп';


--
-- TOC entry 2973 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN srv_tree.ancestor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.srv_tree.ancestor IS 'предок';


--
-- TOC entry 2974 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN srv_tree.descendant; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.srv_tree.descendant IS 'потомок';


--
-- TOC entry 2975 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN srv_tree.length; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.srv_tree.length IS 'Значение path_length ссылки узла на самого себя равно 0, 
значение path_length прямого дочернего объекта этого узла равно 1, значение path_length внучатого объекта узла равно 2 и  так далее.';


--
-- TOC entry 267 (class 1259 OID 16659588)
-- Name: srv_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.srv_type (
    id integer NOT NULL,
    text character varying
);


ALTER TABLE public.srv_type OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 16659594)
-- Name: srv_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.srv_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.srv_type_id_seq OWNER TO postgres;

--
-- TOC entry 2976 (class 0 OID 0)
-- Dependencies: 268
-- Name: srv_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.srv_type_id_seq OWNED BY public.srv_type.id;


--
-- TOC entry 269 (class 1259 OID 16659596)
-- Name: visitor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visitor (
    id integer NOT NULL,
    person integer,
    role integer[],
    state public.entity_state DEFAULT 'enabled'::public.entity_state NOT NULL,
    identifier character varying(512),
    agency integer[],
    region character varying
);


ALTER TABLE public.visitor OWNER TO postgres;

--
-- TOC entry 2977 (class 0 OID 0)
-- Dependencies: 269
-- Name: TABLE visitor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.visitor IS 'Список посетителей мероприятий';


--
-- TOC entry 2978 (class 0 OID 0)
-- Dependencies: 269
-- Name: COLUMN visitor.person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor.person IS 'Физ лицо';


--
-- TOC entry 2979 (class 0 OID 0)
-- Dependencies: 269
-- Name: COLUMN visitor.role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor.role IS 'Роль из справочника';


--
-- TOC entry 2980 (class 0 OID 0)
-- Dependencies: 269
-- Name: COLUMN visitor.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor.state IS 'Состояние записи о посетителе';


--
-- TOC entry 2981 (class 0 OID 0)
-- Dependencies: 269
-- Name: COLUMN visitor.identifier; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor.identifier IS 'Идентификатор посетителя';


--
-- TOC entry 2982 (class 0 OID 0)
-- Dependencies: 269
-- Name: COLUMN visitor.agency; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor.agency IS 'Учреждения, к-м принадлежит посетитель';


--
-- TOC entry 270 (class 1259 OID 16659603)
-- Name: visitor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.visitor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.visitor_id_seq OWNER TO postgres;

--
-- TOC entry 2983 (class 0 OID 0)
-- Dependencies: 270
-- Name: visitor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.visitor_id_seq OWNED BY public.visitor.id;


--
-- TOC entry 271 (class 1259 OID 16659605)
-- Name: visitors_scores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visitors_scores (
    id integer NOT NULL,
    visitor integer,
    scores integer,
    date timestamp without time zone DEFAULT now(),
    event integer,
    operation public.scores_operations NOT NULL,
    reward integer,
    reason_id integer,
    CONSTRAINT visitors_scores_check CHECK ((((scores > 0) AND (operation = 'adding'::public.scores_operations)) OR ((scores < 0) AND (operation = 'subtracting'::public.scores_operations))))
);


ALTER TABLE public.visitors_scores OWNER TO postgres;

--
-- TOC entry 2984 (class 0 OID 0)
-- Dependencies: 271
-- Name: TABLE visitors_scores; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.visitors_scores IS 'Начисления баллов посетителям';


--
-- TOC entry 2985 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN visitors_scores.visitor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitors_scores.visitor IS 'Посетитель';


--
-- TOC entry 2986 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN visitors_scores.scores; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitors_scores.scores IS 'Начисленное количество баллов';


--
-- TOC entry 2987 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN visitors_scores.date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitors_scores.date IS 'Время действия по начислению баллов';


--
-- TOC entry 2988 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN visitors_scores.operation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitors_scores.operation IS 'Тип операции';


--
-- TOC entry 2989 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN visitors_scores.reward; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitors_scores.reward IS 'Поощрение, за которое осуществлено списание';


--
-- TOC entry 2990 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN visitors_scores.reason_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitors_scores.reason_id IS 'Причина изменения счета посетителя по справочнику';


--
-- TOC entry 272 (class 1259 OID 16659610)
-- Name: visitors_scores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.visitors_scores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.visitors_scores_id_seq OWNER TO postgres;

--
-- TOC entry 2991 (class 0 OID 0)
-- Dependencies: 272
-- Name: visitors_scores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.visitors_scores_id_seq OWNED BY public.visitors_scores.id;


--
-- TOC entry 273 (class 1259 OID 16659612)
-- Name: visitors_scores_reason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visitors_scores_reason (
    id integer NOT NULL,
    name character varying(512),
    state public.entity_state DEFAULT 'enabled'::public.entity_state,
    operation_type public.scores_reason_type NOT NULL
);


ALTER TABLE public.visitors_scores_reason OWNER TO postgres;

--
-- TOC entry 2992 (class 0 OID 0)
-- Dependencies: 273
-- Name: TABLE visitors_scores_reason; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.visitors_scores_reason IS 'Справочник причин начисления';


--
-- TOC entry 2993 (class 0 OID 0)
-- Dependencies: 273
-- Name: COLUMN visitors_scores_reason.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitors_scores_reason.name IS 'Наименование причины начисления/списания баллов';


--
-- TOC entry 274 (class 1259 OID 16659619)
-- Name: visitors_scores_reason_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.visitors_scores_reason_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.visitors_scores_reason_id_seq OWNER TO postgres;

--
-- TOC entry 2994 (class 0 OID 0)
-- Dependencies: 274
-- Name: visitors_scores_reason_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.visitors_scores_reason_id_seq OWNED BY public.visitors_scores_reason.id;


--
-- TOC entry 2372 (class 2604 OID 16659621)
-- Name: activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities ALTER COLUMN id SET DEFAULT nextval('public.activities_id_seq'::regclass);


--
-- TOC entry 2375 (class 2604 OID 16659622)
-- Name: activities_addresses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_addresses ALTER COLUMN id SET DEFAULT nextval('public.activities_addresses_id_seq'::regclass);


--
-- TOC entry 2377 (class 2604 OID 16659623)
-- Name: activities_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_events ALTER COLUMN id SET DEFAULT nextval('public.activities_events_id_seq'::regclass);


--
-- TOC entry 2378 (class 2604 OID 16659624)
-- Name: activities_in_action id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_in_action ALTER COLUMN id SET DEFAULT nextval('public.activities_in_action_id_seq'::regclass);


--
-- TOC entry 2381 (class 2604 OID 16659625)
-- Name: activities_photos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_photos ALTER COLUMN id SET DEFAULT nextval('public.activities_photos_id_seq'::regclass);


--
-- TOC entry 2382 (class 2604 OID 16659626)
-- Name: activities_places id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_places ALTER COLUMN id SET DEFAULT nextval('public.activities_places_id_seq'::regclass);


--
-- TOC entry 2384 (class 2604 OID 16659627)
-- Name: activities_places_registr id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_places_registr ALTER COLUMN id SET DEFAULT nextval('public.activities_places_registr_id_seq'::regclass);


--
-- TOC entry 2386 (class 2604 OID 16659628)
-- Name: activities_rewards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_rewards ALTER COLUMN id SET DEFAULT nextval('public.activities_rewards_id_seq'::regclass);


--
-- TOC entry 2388 (class 2604 OID 16659629)
-- Name: activities_rewards_photos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_rewards_photos ALTER COLUMN id SET DEFAULT nextval('public.activities_rewards_photos_id_seq'::regclass);


--
-- TOC entry 2417 (class 2604 OID 16659630)
-- Name: agency_agency id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_agency ALTER COLUMN id SET DEFAULT nextval('public.agency_agency_id_seq'::regclass);


--
-- TOC entry 2418 (class 2604 OID 16659631)
-- Name: agency_agencycategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_agencycategory ALTER COLUMN id SET DEFAULT nextval('public.agency_agencycategory_id_seq'::regclass);


--
-- TOC entry 2419 (class 2604 OID 16659632)
-- Name: agency_agencyhead id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_agencyhead ALTER COLUMN id SET DEFAULT nextval('public.agency_agencyhead_id_seq'::regclass);


--
-- TOC entry 2420 (class 2604 OID 16659633)
-- Name: agency_cl_option id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_cl_option ALTER COLUMN id SET DEFAULT nextval('public.agency_cl_option_id_seq'::regclass);


--
-- TOC entry 2421 (class 2604 OID 16659634)
-- Name: agency_departmenttype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_departmenttype ALTER COLUMN id SET DEFAULT nextval('public.agency_departmenttype_id_seq'::regclass);


--
-- TOC entry 2422 (class 2604 OID 16659635)
-- Name: agency_district id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_district ALTER COLUMN id SET DEFAULT nextval('public.agency_district_id_seq'::regclass);


--
-- TOC entry 2423 (class 2604 OID 16659636)
-- Name: agency_event id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_event ALTER COLUMN id SET DEFAULT nextval('public.agency_event_id_seq'::regclass);


--
-- TOC entry 2424 (class 2604 OID 16659637)
-- Name: agency_infomat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_infomat ALTER COLUMN id SET DEFAULT nextval('public.agency_infomat_id_seq'::regclass);


--
-- TOC entry 2425 (class 2604 OID 16659638)
-- Name: agency_photo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_photo ALTER COLUMN id SET DEFAULT nextval('public.agency_photo_id_seq'::regclass);


--
-- TOC entry 2426 (class 2604 OID 16659639)
-- Name: agency_region id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_region ALTER COLUMN id SET DEFAULT nextval('public.agency_region_id_seq'::regclass);


--
-- TOC entry 2427 (class 2604 OID 16659640)
-- Name: agency_screenfiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_screenfiles ALTER COLUMN id SET DEFAULT nextval('public.agency_screenfiles_id_seq'::regclass);


--
-- TOC entry 2428 (class 2604 OID 16659641)
-- Name: agency_screensaver_option id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_screensaver_option ALTER COLUMN id SET DEFAULT nextval('public.agency_screensaver_option_id_seq'::regclass);


--
-- TOC entry 2429 (class 2604 OID 16659642)
-- Name: agency_screensavers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_screensavers ALTER COLUMN id SET DEFAULT nextval('public.agency_screensavers_id_seq'::regclass);


--
-- TOC entry 2430 (class 2604 OID 16659643)
-- Name: agency_servicewhom id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_servicewhom ALTER COLUMN id SET DEFAULT nextval('public.agency_servicewhom_id_seq'::regclass);


--
-- TOC entry 2431 (class 2604 OID 16659644)
-- Name: event_photo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_photo ALTER COLUMN id SET DEFAULT nextval('public.event_photo_id_seq'::regclass);


--
-- TOC entry 2432 (class 2604 OID 16659645)
-- Name: event_schedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_schedule ALTER COLUMN id SET DEFAULT nextval('public.event_schedule_id_seq'::regclass);


--
-- TOC entry 2433 (class 2604 OID 16659646)
-- Name: event_schedule_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_schedule_type ALTER COLUMN id SET DEFAULT nextval('public.event_schedule_type_id_seq'::regclass);


--
-- TOC entry 2434 (class 2604 OID 16659647)
-- Name: event_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_type ALTER COLUMN id SET DEFAULT nextval('public.event_type_id_seq'::regclass);


--
-- TOC entry 2436 (class 2604 OID 16659648)
-- Name: rewards_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rewards_categories ALTER COLUMN id SET DEFAULT nextval('public.rewards_categories_id_seq'::regclass);


--
-- TOC entry 2438 (class 2604 OID 16659649)
-- Name: rewards_receipt_register id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rewards_receipt_register ALTER COLUMN id SET DEFAULT nextval('public.rewards_receipt_register_id_seq'::regclass);


--
-- TOC entry 2440 (class 2604 OID 16659650)
-- Name: rf_actions_sponsors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_actions_sponsors ALTER COLUMN id SET DEFAULT nextval('public.rf_actions_sponsors_id_seq'::regclass);


--
-- TOC entry 2445 (class 2604 OID 16659651)
-- Name: rf_activities_actions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_activities_actions ALTER COLUMN id SET DEFAULT nextval('public.rf_activities_actions_id_seq'::regclass);


--
-- TOC entry 2448 (class 2604 OID 16659652)
-- Name: rf_activities_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_activities_categories ALTER COLUMN id SET DEFAULT nextval('public.rf_activities_categories_id_seq'::regclass);


--
-- TOC entry 2452 (class 2604 OID 16659653)
-- Name: rf_activities_roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_activities_roles ALTER COLUMN id SET DEFAULT nextval('public.rf_activities_roles_id_seq'::regclass);


--
-- TOC entry 2455 (class 2604 OID 16659654)
-- Name: rf_activities_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_activities_types ALTER COLUMN id SET DEFAULT nextval('public.rf_activities_types_id_seq'::regclass);


--
-- TOC entry 2465 (class 2604 OID 16659655)
-- Name: srv id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv ALTER COLUMN id SET DEFAULT nextval('public.srv_id_seq'::regclass);


--
-- TOC entry 2466 (class 2604 OID 16659656)
-- Name: srv_cat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_cat ALTER COLUMN id SET DEFAULT nextval('public.srv_cat_id_seq'::regclass);


--
-- TOC entry 2467 (class 2604 OID 16659657)
-- Name: srv_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_data ALTER COLUMN id SET DEFAULT nextval('public.srv_data_id_seq'::regclass);


--
-- TOC entry 2469 (class 2604 OID 16659658)
-- Name: srv_ifs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_ifs ALTER COLUMN id SET DEFAULT nextval('public.srv_ifs_id_seq'::regclass);


--
-- TOC entry 2471 (class 2604 OID 16659659)
-- Name: srv_ifs_to_srv id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_ifs_to_srv ALTER COLUMN id SET DEFAULT nextval('public.srv_ifs_to_srv_id_seq'::regclass);


--
-- TOC entry 2472 (class 2604 OID 16659660)
-- Name: srv_st_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_st_type ALTER COLUMN id SET DEFAULT nextval('public.srv_st_type_id_seq'::regclass);


--
-- TOC entry 2474 (class 2604 OID 16659661)
-- Name: srv_to_ag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_to_ag ALTER COLUMN id SET DEFAULT nextval('public.srv_to_ag_id_seq'::regclass);


--
-- TOC entry 2475 (class 2604 OID 16659662)
-- Name: srv_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_type ALTER COLUMN id SET DEFAULT nextval('public.srv_type_id_seq'::regclass);


--
-- TOC entry 2477 (class 2604 OID 16659663)
-- Name: visitor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitor ALTER COLUMN id SET DEFAULT nextval('public.visitor_id_seq'::regclass);


--
-- TOC entry 2479 (class 2604 OID 16659664)
-- Name: visitors_scores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitors_scores ALTER COLUMN id SET DEFAULT nextval('public.visitors_scores_id_seq'::regclass);


--
-- TOC entry 2482 (class 2604 OID 16659665)
-- Name: visitors_scores_reason id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitors_scores_reason ALTER COLUMN id SET DEFAULT nextval('public.visitors_scores_reason_id_seq'::regclass);


--
-- TOC entry 2489 (class 2606 OID 16660713)
-- Name: activities_addresses activities_addresses_city_kladr_street_kladr_building_kladr_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_addresses
    ADD CONSTRAINT activities_addresses_city_kladr_street_kladr_building_kladr_key UNIQUE (city_kladr, street_kladr, building_kladr);


--
-- TOC entry 2491 (class 2606 OID 16660715)
-- Name: activities_addresses activities_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_addresses
    ADD CONSTRAINT activities_addresses_pkey PRIMARY KEY (id);


--
-- TOC entry 2493 (class 2606 OID 16660718)
-- Name: activities_events activities_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_events
    ADD CONSTRAINT activities_events_pkey PRIMARY KEY (id);


--
-- TOC entry 2496 (class 2606 OID 16660720)
-- Name: activities_in_action activities_in_action_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_in_action
    ADD CONSTRAINT activities_in_action_pkey PRIMARY KEY (id);


--
-- TOC entry 2500 (class 2606 OID 16660722)
-- Name: activities_participants_register activities_participants_register_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_participants_register
    ADD CONSTRAINT activities_participants_register_pkey PRIMARY KEY (event, participant);


--
-- TOC entry 2503 (class 2606 OID 16660724)
-- Name: activities_photos activities_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_photos
    ADD CONSTRAINT activities_photos_pkey PRIMARY KEY (id);


--
-- TOC entry 2484 (class 2606 OID 16660726)
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- TOC entry 2507 (class 2606 OID 16660729)
-- Name: activities_places activities_places_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_places
    ADD CONSTRAINT activities_places_pkey PRIMARY KEY (id);


--
-- TOC entry 2509 (class 2606 OID 16660731)
-- Name: activities_places_registr activities_places_registr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_places_registr
    ADD CONSTRAINT activities_places_registr_pkey PRIMARY KEY (id);


--
-- TOC entry 2514 (class 2606 OID 16660733)
-- Name: activities_rewards_photos activities_rewards_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_rewards_photos
    ADD CONSTRAINT activities_rewards_photos_pkey PRIMARY KEY (id);


--
-- TOC entry 2511 (class 2606 OID 16660735)
-- Name: activities_rewards activities_rewards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_rewards
    ADD CONSTRAINT activities_rewards_pkey PRIMARY KEY (id);


--
-- TOC entry 2516 (class 2606 OID 16660737)
-- Name: activities_scoring_rules activities_scoring_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_scoring_rules
    ADD CONSTRAINT activities_scoring_rules_pkey PRIMARY KEY (activity, role);


--
-- TOC entry 2588 (class 2606 OID 16660739)
-- Name: rf_activities_types activities_types_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_activities_types
    ADD CONSTRAINT activities_types_name_key UNIQUE (name);


--
-- TOC entry 2590 (class 2606 OID 16660741)
-- Name: rf_activities_types activities_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_activities_types
    ADD CONSTRAINT activities_types_pkey PRIMARY KEY (id);


--
-- TOC entry 2521 (class 2606 OID 16660748)
-- Name: agency_agency agency_agency_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_agency
    ADD CONSTRAINT agency_agency_id_pkey PRIMARY KEY (id);


--
-- TOC entry 2524 (class 2606 OID 16660750)
-- Name: agency_agencycategory agency_agencycategory_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_agencycategory
    ADD CONSTRAINT agency_agencycategory_id_pkey PRIMARY KEY (id);


--
-- TOC entry 2526 (class 2606 OID 16660752)
-- Name: agency_agencyhead agency_agencyhead_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_agencyhead
    ADD CONSTRAINT agency_agencyhead_pkey PRIMARY KEY (id);


--
-- TOC entry 2528 (class 2606 OID 16660754)
-- Name: agency_cl_option agency_cl_option_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_cl_option
    ADD CONSTRAINT agency_cl_option_pkey PRIMARY KEY (id);


--
-- TOC entry 2530 (class 2606 OID 16660756)
-- Name: agency_departmenttype agency_departmenttype_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_departmenttype
    ADD CONSTRAINT agency_departmenttype_id_pkey PRIMARY KEY (id);


--
-- TOC entry 2532 (class 2606 OID 16660758)
-- Name: agency_district agency_district_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_district
    ADD CONSTRAINT agency_district_id_pkey PRIMARY KEY (id);


--
-- TOC entry 2534 (class 2606 OID 16660760)
-- Name: agency_event agency_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_event
    ADD CONSTRAINT agency_event_pkey PRIMARY KEY (id);


--
-- TOC entry 2537 (class 2606 OID 16660762)
-- Name: agency_infomat agency_infomat_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_infomat
    ADD CONSTRAINT agency_infomat_id_pkey PRIMARY KEY (id);


--
-- TOC entry 2540 (class 2606 OID 16660764)
-- Name: agency_region agency_region_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_region
    ADD CONSTRAINT agency_region_id_pkey PRIMARY KEY (id);


--
-- TOC entry 2542 (class 2606 OID 16660767)
-- Name: agency_screenfiles agency_screenfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_screenfiles
    ADD CONSTRAINT agency_screenfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2546 (class 2606 OID 16660769)
-- Name: agency_screensaver_option agency_screensaver_option_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_screensaver_option
    ADD CONSTRAINT agency_screensaver_option_pkey PRIMARY KEY (id);


--
-- TOC entry 2549 (class 2606 OID 16660771)
-- Name: agency_screensaver_option agency_screensaver_option_screensaver_id_option_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_screensaver_option
    ADD CONSTRAINT agency_screensaver_option_screensaver_id_option_id_key UNIQUE (screensaver_id, option_id);


--
-- TOC entry 2551 (class 2606 OID 16660773)
-- Name: agency_screensavers agency_screensavers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_screensavers
    ADD CONSTRAINT agency_screensavers_pkey PRIMARY KEY (id);


--
-- TOC entry 2553 (class 2606 OID 16660775)
-- Name: agency_servicewhom agency_servicewhom_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_servicewhom
    ADD CONSTRAINT agency_servicewhom_id_pkey PRIMARY KEY (id);


--
-- TOC entry 2556 (class 2606 OID 16660777)
-- Name: agency_tree agency_tree_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_tree
    ADD CONSTRAINT agency_tree_pkey PRIMARY KEY (ancestor, descendant);


--
-- TOC entry 2560 (class 2606 OID 16660779)
-- Name: event_photo event_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_photo
    ADD CONSTRAINT event_photo_pkey PRIMARY KEY (id);


--
-- TOC entry 2562 (class 2606 OID 16660781)
-- Name: event_schedule event_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_schedule
    ADD CONSTRAINT event_schedule_pkey PRIMARY KEY (id);


--
-- TOC entry 2564 (class 2606 OID 16660783)
-- Name: event_schedule_type event_schedule_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_schedule_type
    ADD CONSTRAINT event_schedule_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2566 (class 2606 OID 16660785)
-- Name: event_type event_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_type
    ADD CONSTRAINT event_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2568 (class 2606 OID 16660787)
-- Name: rewards_categories rewards_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rewards_categories
    ADD CONSTRAINT rewards_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 2570 (class 2606 OID 16660789)
-- Name: rewards_receipt_register rewards_receipt_register_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rewards_receipt_register
    ADD CONSTRAINT rewards_receipt_register_pkey PRIMARY KEY (id);


--
-- TOC entry 2572 (class 2606 OID 16660791)
-- Name: rf_actions_sponsors rf_actions_sponsors_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_actions_sponsors
    ADD CONSTRAINT rf_actions_sponsors_name_key UNIQUE (name);


--
-- TOC entry 2574 (class 2606 OID 16660793)
-- Name: rf_actions_sponsors rf_actions_sponsors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_actions_sponsors
    ADD CONSTRAINT rf_actions_sponsors_pkey PRIMARY KEY (id);


--
-- TOC entry 2576 (class 2606 OID 16660795)
-- Name: rf_activities_actions rf_activities_actions_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_activities_actions
    ADD CONSTRAINT rf_activities_actions_name_key UNIQUE (name);


--
-- TOC entry 2578 (class 2606 OID 16660797)
-- Name: rf_activities_actions rf_activities_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_activities_actions
    ADD CONSTRAINT rf_activities_actions_pkey PRIMARY KEY (id);


--
-- TOC entry 2580 (class 2606 OID 16660799)
-- Name: rf_activities_categories rf_activities_categories_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_activities_categories
    ADD CONSTRAINT rf_activities_categories_key UNIQUE (name);


--
-- TOC entry 2582 (class 2606 OID 16660801)
-- Name: rf_activities_categories rf_activities_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_activities_categories
    ADD CONSTRAINT rf_activities_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 2584 (class 2606 OID 16660803)
-- Name: rf_activities_roles rf_activities_roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_activities_roles
    ADD CONSTRAINT rf_activities_roles_name_key UNIQUE (name);


--
-- TOC entry 2586 (class 2606 OID 16660805)
-- Name: rf_activities_roles rf_activities_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_activities_roles
    ADD CONSTRAINT rf_activities_roles_pkey PRIMARY KEY (id);


--
-- TOC entry 2594 (class 2606 OID 16660807)
-- Name: srv_cat srv_cat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_cat
    ADD CONSTRAINT srv_cat_pkey PRIMARY KEY (id);


--
-- TOC entry 2596 (class 2606 OID 16660809)
-- Name: srv_data srv_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_data
    ADD CONSTRAINT srv_data_pkey PRIMARY KEY (id);


--
-- TOC entry 2600 (class 2606 OID 16660811)
-- Name: srv_ifs srv_ifs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_ifs
    ADD CONSTRAINT srv_ifs_pkey PRIMARY KEY (id);


--
-- TOC entry 2603 (class 2606 OID 16660813)
-- Name: srv_ifs_to_srv srv_ifs_to_srv_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_ifs_to_srv
    ADD CONSTRAINT srv_ifs_to_srv_pkey PRIMARY KEY (id);


--
-- TOC entry 2592 (class 2606 OID 16660815)
-- Name: srv srv_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv
    ADD CONSTRAINT srv_pkey PRIMARY KEY (id);


--
-- TOC entry 2605 (class 2606 OID 16660817)
-- Name: srv_st_type srv_st_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_st_type
    ADD CONSTRAINT srv_st_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2607 (class 2606 OID 16660819)
-- Name: srv_to_ag srv_to_ag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_to_ag
    ADD CONSTRAINT srv_to_ag_pkey PRIMARY KEY (id);


--
-- TOC entry 2613 (class 2606 OID 16660821)
-- Name: srv_tree srv_tree_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_tree
    ADD CONSTRAINT srv_tree_pkey PRIMARY KEY (ancestor, descendant);


--
-- TOC entry 2615 (class 2606 OID 16660823)
-- Name: srv_type srv_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_type
    ADD CONSTRAINT srv_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2620 (class 2606 OID 16660825)
-- Name: visitor visitor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitor
    ADD CONSTRAINT visitor_pkey PRIMARY KEY (id);


--
-- TOC entry 2622 (class 2606 OID 16660827)
-- Name: visitors_scores visitors_scores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitors_scores
    ADD CONSTRAINT visitors_scores_pkey PRIMARY KEY (id);


--
-- TOC entry 2625 (class 2606 OID 16660829)
-- Name: visitors_scores_reason visitors_scores_reason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitors_scores_reason
    ADD CONSTRAINT visitors_scores_reason_pkey PRIMARY KEY (id);


--
-- TOC entry 2517 (class 1259 OID 16660830)
-- Name: agency_agency_aorg_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX agency_agency_aorg_id ON public.agency_agency USING btree (aorg_id);


--
-- TOC entry 2518 (class 1259 OID 16660831)
-- Name: agency_agency_atype_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX agency_agency_atype_id ON public.agency_agency USING btree (atype_id);


--
-- TOC entry 2519 (class 1259 OID 16660832)
-- Name: agency_agency_headagency_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX agency_agency_headagency_id ON public.agency_agency USING btree (headagency_id);


--
-- TOC entry 2522 (class 1259 OID 16660833)
-- Name: agency_agency_region_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX agency_agency_region_id ON public.agency_agency USING btree (region_id);


--
-- TOC entry 2535 (class 1259 OID 16660834)
-- Name: agency_infomat_agency_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX agency_infomat_agency_id ON public.agency_infomat USING btree (agency_id);


--
-- TOC entry 2538 (class 1259 OID 16660835)
-- Name: agency_region_district_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX agency_region_district_id ON public.agency_region USING btree (district_id);


--
-- TOC entry 2543 (class 1259 OID 16660836)
-- Name: agency_screenfiles_screensaver_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX agency_screenfiles_screensaver_id ON public.agency_screenfiles USING btree (screensaver_id);


--
-- TOC entry 2544 (class 1259 OID 16660837)
-- Name: agency_screensaver_option_option_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX agency_screensaver_option_option_id ON public.agency_screensaver_option USING btree (option_id);


--
-- TOC entry 2547 (class 1259 OID 16660838)
-- Name: agency_screensaver_option_screensaver_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX agency_screensaver_option_screensaver_id ON public.agency_screensaver_option USING btree (screensaver_id);


--
-- TOC entry 2554 (class 1259 OID 16660839)
-- Name: agency_tree_path_length_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX agency_tree_path_length_idx ON public.agency_tree USING btree (length);


--
-- TOC entry 2485 (class 1259 OID 16660840)
-- Name: fki_activities_address_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_activities_address_fkey ON public.activities USING btree (address);


--
-- TOC entry 2486 (class 1259 OID 16660841)
-- Name: fki_activities_agency_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_activities_agency_fkey ON public.activities USING btree (agency);


--
-- TOC entry 2494 (class 1259 OID 16660842)
-- Name: fki_activities_events_activity_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_activities_events_activity_fkey ON public.activities_events USING btree (activity);


--
-- TOC entry 2497 (class 1259 OID 16660843)
-- Name: fki_activities_in_action_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_activities_in_action_fkey ON public.activities_in_action USING btree (action);


--
-- TOC entry 2498 (class 1259 OID 16660844)
-- Name: fki_activities_in_activity_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_activities_in_activity_fkey ON public.activities_in_action USING btree (activity);


--
-- TOC entry 2501 (class 1259 OID 16660845)
-- Name: fki_activities_participants_register_role_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_activities_participants_register_role_fkey ON public.activities_participants_register USING btree (role);


--
-- TOC entry 2504 (class 1259 OID 16660846)
-- Name: fki_activities_photos_activity_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_activities_photos_activity_fkey ON public.activities_photos USING btree (activity);


--
-- TOC entry 2505 (class 1259 OID 16660847)
-- Name: fki_activities_photos_event_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_activities_photos_event_fkey ON public.activities_photos USING btree (event);


--
-- TOC entry 2512 (class 1259 OID 16660848)
-- Name: fki_activities_rewards_action_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_activities_rewards_action_fkey ON public.activities_rewards USING btree (action);


--
-- TOC entry 2487 (class 1259 OID 16660849)
-- Name: fki_activities_type_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_activities_type_fkey ON public.activities USING btree (type);


--
-- TOC entry 2557 (class 1259 OID 16660850)
-- Name: fki_agency_tree_ancestor_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_agency_tree_ancestor_fkey ON public.agency_tree USING btree (ancestor);


--
-- TOC entry 2558 (class 1259 OID 16660851)
-- Name: fki_agency_tree_descedant_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_agency_tree_descedant_fkey ON public.agency_tree USING btree (descendant);


--
-- TOC entry 2601 (class 1259 OID 16660852)
-- Name: fki_srv_ifs_to_srv_srv_ifs_id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_srv_ifs_to_srv_srv_ifs_id_fkey ON public.srv_ifs_to_srv USING btree (srv_ifs_id);


--
-- TOC entry 2609 (class 1259 OID 16660853)
-- Name: fki_srv_tree_ancestor_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_srv_tree_ancestor_fkey ON public.srv_tree USING btree (ancestor);


--
-- TOC entry 2610 (class 1259 OID 16660854)
-- Name: fki_srv_tree_descedant_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_srv_tree_descedant_fkey ON public.srv_tree USING btree (descendant);


--
-- TOC entry 2616 (class 1259 OID 16660855)
-- Name: fki_visitor_role_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_visitor_role_fkey ON public.visitor USING btree (role);


--
-- TOC entry 2597 (class 1259 OID 16660856)
-- Name: srv_data_srv_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX srv_data_srv_id ON public.srv_data USING btree (srv_id);


--
-- TOC entry 2598 (class 1259 OID 16660857)
-- Name: srv_data_srv_id_state_enabled_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX srv_data_srv_id_state_enabled_unique ON public.srv_data USING btree (srv_id, state) WHERE (state = 'enabled'::public.state);


--
-- TOC entry 2608 (class 1259 OID 16660858)
-- Name: srv_to_ag_srv_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX srv_to_ag_srv_id ON public.srv_to_ag USING btree (srv_id, ag_id);


--
-- TOC entry 2611 (class 1259 OID 16660859)
-- Name: srv_tree_path_length_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX srv_tree_path_length_idx ON public.srv_tree USING btree (length);


--
-- TOC entry 2617 (class 1259 OID 16660860)
-- Name: visitor_identifier_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX visitor_identifier_unique ON public.visitor USING btree (identifier) WHERE ((identifier IS NOT NULL) AND (state = 'enabled'::public.entity_state));


--
-- TOC entry 2618 (class 1259 OID 16660861)
-- Name: visitor_person_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX visitor_person_unique ON public.visitor USING btree (person);


--
-- TOC entry 2623 (class 1259 OID 16660862)
-- Name: visitors_scores_reason_name_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX visitors_scores_reason_name_unique ON public.visitors_scores_reason USING btree (name);


--
-- TOC entry 2661 (class 2620 OID 16660863)
-- Name: activities_events adding_leaders_scores; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER adding_leaders_scores AFTER UPDATE ON public.activities_events FOR EACH ROW EXECUTE PROCEDURE public.__adding_leaders_scores();


--
-- TOC entry 2662 (class 2620 OID 16660864)
-- Name: activities_events adding_visitor_scores; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER adding_visitor_scores AFTER UPDATE ON public.activities_events FOR EACH ROW EXECUTE PROCEDURE public.__adding_visitor_scores();


--
-- TOC entry 2663 (class 2620 OID 16660865)
-- Name: activities_participants_register adding_visitor_scores_with_register; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER adding_visitor_scores_with_register AFTER INSERT OR UPDATE ON public.activities_participants_register FOR EACH ROW EXECUTE PROCEDURE public.__adding_visitor_scores_with_register();


--
-- TOC entry 2666 (class 2620 OID 16660866)
-- Name: visitors_scores check_sum_visitor_scores; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER check_sum_visitor_scores AFTER INSERT OR UPDATE ON public.visitors_scores FOR EACH ROW EXECUTE PROCEDURE public.__check_sum_visitor_scores();


--
-- TOC entry 2664 (class 2620 OID 16660867)
-- Name: activities_participants_register delete_visitor_scores; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER delete_visitor_scores BEFORE DELETE ON public.activities_participants_register FOR EACH ROW EXECUTE PROCEDURE public.__delete_visitor_scores();


--
-- TOC entry 2665 (class 2620 OID 16660868)
-- Name: srv_data update_srv_to_ag_when_srv_changed; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_srv_to_ag_when_srv_changed AFTER INSERT OR UPDATE ON public.srv_data FOR EACH ROW EXECUTE PROCEDURE public.__update_srv_to_ag_when_srv_changed();


--
-- TOC entry 2632 (class 2606 OID 16660869)
-- Name: activities_in_action aactivities_in_action_action_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_in_action
    ADD CONSTRAINT aactivities_in_action_action_fkey FOREIGN KEY (action) REFERENCES public.rf_activities_actions(id);


--
-- TOC entry 2633 (class 2606 OID 16660874)
-- Name: activities_in_action aactivities_in_action_activity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_in_action
    ADD CONSTRAINT aactivities_in_action_activity_fkey FOREIGN KEY (activity) REFERENCES public.activities(id);


--
-- TOC entry 2644 (class 2606 OID 16660879)
-- Name: activities_rewards_photos aactivities_rewards_photos_reward_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_rewards_photos
    ADD CONSTRAINT aactivities_rewards_photos_reward_fkey FOREIGN KEY (reward) REFERENCES public.activities_rewards(id);


--
-- TOC entry 2626 (class 2606 OID 16660884)
-- Name: activities activities_address_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_address_fkey FOREIGN KEY (address) REFERENCES public.activities_addresses(id);


--
-- TOC entry 2627 (class 2606 OID 16660889)
-- Name: activities activities_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_category_fkey FOREIGN KEY (category) REFERENCES public.rf_activities_categories(id);


--
-- TOC entry 2629 (class 2606 OID 16660894)
-- Name: activities_events activities_events_activity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_events
    ADD CONSTRAINT activities_events_activity_fkey FOREIGN KEY (activity) REFERENCES public.activities(id);


--
-- TOC entry 2630 (class 2606 OID 16660899)
-- Name: activities_events activities_events_address_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_events
    ADD CONSTRAINT activities_events_address_fkey FOREIGN KEY (address) REFERENCES public.activities_addresses(id);


--
-- TOC entry 2631 (class 2606 OID 16660904)
-- Name: activities_events activities_events_place_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_events
    ADD CONSTRAINT activities_events_place_fkey FOREIGN KEY (place) REFERENCES public.activities_places(id);


--
-- TOC entry 2634 (class 2606 OID 16660909)
-- Name: activities_participants_register activities_participants_register_event_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_participants_register
    ADD CONSTRAINT activities_participants_register_event_fkey FOREIGN KEY (event) REFERENCES public.activities_events(id);


--
-- TOC entry 2635 (class 2606 OID 16660914)
-- Name: activities_participants_register activities_participants_register_participant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_participants_register
    ADD CONSTRAINT activities_participants_register_participant_fkey FOREIGN KEY (participant) REFERENCES public.visitor(id);


--
-- TOC entry 2636 (class 2606 OID 16660919)
-- Name: activities_participants_register activities_participants_register_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_participants_register
    ADD CONSTRAINT activities_participants_register_role_fkey FOREIGN KEY (role) REFERENCES public.rf_activities_roles(id);


--
-- TOC entry 2637 (class 2606 OID 16660924)
-- Name: activities_photos activities_photos_activity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_photos
    ADD CONSTRAINT activities_photos_activity_fkey FOREIGN KEY (activity) REFERENCES public.activities(id);


--
-- TOC entry 2638 (class 2606 OID 16660929)
-- Name: activities_photos activities_photos_event_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_photos
    ADD CONSTRAINT activities_photos_event_fkey FOREIGN KEY (event) REFERENCES public.activities_events(id);


--
-- TOC entry 2639 (class 2606 OID 16660934)
-- Name: activities_places activities_places_activity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_places
    ADD CONSTRAINT activities_places_activity_fkey FOREIGN KEY (activity) REFERENCES public.activities(id);


--
-- TOC entry 2640 (class 2606 OID 16660939)
-- Name: activities_places activities_places_registr_place_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_places
    ADD CONSTRAINT activities_places_registr_place_fkey FOREIGN KEY (registr_place) REFERENCES public.activities_places_registr(id);


--
-- TOC entry 2641 (class 2606 OID 16660944)
-- Name: activities_rewards activities_rewards_action_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_rewards
    ADD CONSTRAINT activities_rewards_action_fkey FOREIGN KEY (action) REFERENCES public.rf_activities_actions(id);


--
-- TOC entry 2642 (class 2606 OID 16660949)
-- Name: activities_rewards activities_rewards_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_rewards
    ADD CONSTRAINT activities_rewards_category_fkey FOREIGN KEY (category) REFERENCES public.rewards_categories(id);


--
-- TOC entry 2643 (class 2606 OID 16660954)
-- Name: activities_rewards activities_rewards_sponsor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_rewards
    ADD CONSTRAINT activities_rewards_sponsor_fkey FOREIGN KEY (sponsor) REFERENCES public.rf_actions_sponsors(id);


--
-- TOC entry 2645 (class 2606 OID 16660959)
-- Name: activities_scoring_rules activities_scoring_rules_activity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_scoring_rules
    ADD CONSTRAINT activities_scoring_rules_activity_fkey FOREIGN KEY (activity) REFERENCES public.activities(id);


--
-- TOC entry 2646 (class 2606 OID 16660964)
-- Name: activities_scoring_rules activities_scoring_rules_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities_scoring_rules
    ADD CONSTRAINT activities_scoring_rules_role_fkey FOREIGN KEY (role) REFERENCES public.rf_activities_roles(id);


--
-- TOC entry 2628 (class 2606 OID 16660969)
-- Name: activities activities_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_type_fkey FOREIGN KEY (type) REFERENCES public.rf_activities_types(id);


--
-- TOC entry 2647 (class 2606 OID 16660974)
-- Name: agency_screensaver_option agency_screensaver_option_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_screensaver_option
    ADD CONSTRAINT agency_screensaver_option_option_id_fkey FOREIGN KEY (option_id) REFERENCES public.agency_cl_option(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2648 (class 2606 OID 16660979)
-- Name: agency_screensaver_option agency_screensaver_option_screensaver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_screensaver_option
    ADD CONSTRAINT agency_screensaver_option_screensaver_id_fkey FOREIGN KEY (screensaver_id) REFERENCES public.agency_screensavers(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2649 (class 2606 OID 16660984)
-- Name: agency_tree agency_tree_ancestor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_tree
    ADD CONSTRAINT agency_tree_ancestor_fkey FOREIGN KEY (ancestor) REFERENCES public.agency_agency(id);


--
-- TOC entry 2650 (class 2606 OID 16660989)
-- Name: agency_tree agency_tree_descedant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agency_tree
    ADD CONSTRAINT agency_tree_descedant_fkey FOREIGN KEY (descendant) REFERENCES public.agency_agency(id);


--
-- TOC entry 2651 (class 2606 OID 16660994)
-- Name: rewards_receipt_register rewards_receipt_register_reward_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rewards_receipt_register
    ADD CONSTRAINT rewards_receipt_register_reward_fkey FOREIGN KEY (reward) REFERENCES public.activities_rewards(id);


--
-- TOC entry 2652 (class 2606 OID 16660999)
-- Name: rf_actions_sponsors rf_actions_sponsors_agency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rf_actions_sponsors
    ADD CONSTRAINT rf_actions_sponsors_agency_fkey FOREIGN KEY (agency) REFERENCES public.agency_agency(id);


--
-- TOC entry 2653 (class 2606 OID 16661004)
-- Name: srv_data srv_data_srv_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_data
    ADD CONSTRAINT srv_data_srv_id_fkey FOREIGN KEY (srv_id) REFERENCES public.srv(id);


--
-- TOC entry 2654 (class 2606 OID 16661009)
-- Name: srv_ifs_to_srv srv_ifs_to_srv_srv_ifs_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_ifs_to_srv
    ADD CONSTRAINT srv_ifs_to_srv_srv_ifs_id_fkey FOREIGN KEY (srv_ifs_id) REFERENCES public.srv_ifs(id);


--
-- TOC entry 2655 (class 2606 OID 16661014)
-- Name: srv_tree srv_tree_ancestor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_tree
    ADD CONSTRAINT srv_tree_ancestor_fkey FOREIGN KEY (ancestor) REFERENCES public.srv_cat(id);


--
-- TOC entry 2656 (class 2606 OID 16661019)
-- Name: srv_tree srv_tree_descedant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.srv_tree
    ADD CONSTRAINT srv_tree_descedant_fkey FOREIGN KEY (descendant) REFERENCES public.srv_cat(id);


--
-- TOC entry 2657 (class 2606 OID 16661024)
-- Name: visitors_scores visitors_scores_event_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitors_scores
    ADD CONSTRAINT visitors_scores_event_fkey FOREIGN KEY (event) REFERENCES public.activities_events(id);


--
-- TOC entry 2658 (class 2606 OID 16661029)
-- Name: visitors_scores visitors_scores_reason_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitors_scores
    ADD CONSTRAINT visitors_scores_reason_id_fkey FOREIGN KEY (reason_id) REFERENCES public.visitors_scores_reason(id);


--
-- TOC entry 2659 (class 2606 OID 16661034)
-- Name: visitors_scores visitors_scores_reward_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitors_scores
    ADD CONSTRAINT visitors_scores_reward_fkey FOREIGN KEY (reward) REFERENCES public.activities_rewards(id);


--
-- TOC entry 2660 (class 2606 OID 16661039)
-- Name: visitors_scores visitors_scores_visitor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitors_scores
    ADD CONSTRAINT visitors_scores_visitor_fkey FOREIGN KEY (visitor) REFERENCES public.visitor(id);


--
-- TOC entry 2788 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-11-01 14:21:23 MSK

--
-- PostgreSQL database dump complete
--

