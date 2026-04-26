--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: administration; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.administration (
    id bigint NOT NULL,
    poste_administration character varying(255),
    departement_administration character varying(255),
    telephone_administration character varying(255),
    utilisateur_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: administration_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.administration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: administration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.administration_id_seq OWNED BY public.administration.id;


--
-- Name: annonces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.annonces (
    id bigint NOT NULL,
    titre_annonce character varying(255),
    contenu_annonce text,
    date_publication_annonce timestamp(0) without time zone,
    utilisateur_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    type_annonce character varying(255) DEFAULT 'Pédagogique'::character varying,
    like_annonce integer DEFAULT 0 NOT NULL
);


--
-- Name: annonces_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.annonces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: annonces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.annonces_id_seq OWNED BY public.annonces.id;


--
-- Name: chapter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.chapter (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    date date,
    module_id bigint NOT NULL,
    professeur_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: chapter_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.chapter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: chapter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.chapter_id_seq OWNED BY public.chapter.id;


--
-- Name: commentaires; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commentaires (
    id bigint NOT NULL,
    contenu_commentaires text,
    interne_commentaires boolean DEFAULT false NOT NULL,
    ticket_id bigint,
    utilisateur_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: commentaires_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.commentaires_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: commentaires_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.commentaires_id_seq OWNED BY public.commentaires.id;


--
-- Name: enseigner; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enseigner (
    id bigint NOT NULL,
    annee_academique_enseigner character varying(255),
    semestre_enseigner character varying(255),
    date_debut_enseigner date,
    date_fin_enseigner date,
    professeur_id bigint NOT NULL,
    module_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: enseigner_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enseigner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enseigner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enseigner_id_seq OWNED BY public.enseigner.id;


--
-- Name: etudiants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.etudiants (
    id bigint NOT NULL,
    est_delegue_etudiant boolean DEFAULT false NOT NULL,
    date_naissance_etudiant date,
    telephone_etudiant character varying(255),
    groupe_id bigint,
    utilisateur_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: etudiants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.etudiants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: etudiants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.etudiants_id_seq OWNED BY public.etudiants.id;


--
-- Name: grades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.grades (
    id bigint NOT NULL,
    note_td_tp numeric(5,2) NOT NULL,
    note_examen numeric(5,2) NOT NULL,
    etudiant_id bigint NOT NULL,
    module_id bigint NOT NULL,
    professeur_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.grades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.grades_id_seq OWNED BY public.grades.id;


--
-- Name: groupes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.groupes (
    id bigint NOT NULL,
    code_groupes character varying(255),
    libele_groupes character varying(255),
    annee_academique_groupes character varying(255),
    filier_groupe character varying(255),
    niveau_groupe character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: groupes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.groupes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: groupes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.groupes_id_seq OWNED BY public.groupes.id;


--
-- Name: groupes_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.groupes_modules (
    groupe_id bigint NOT NULL,
    module_id bigint NOT NULL
);


--
-- Name: guardian_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.guardian_tokens (
    jti character varying(255) NOT NULL,
    aud character varying(255) NOT NULL,
    typ character varying(255),
    iss character varying(255),
    sub character varying(255),
    exp bigint,
    jwt text,
    claims jsonb,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: module; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.module (
    id bigint NOT NULL,
    code_cours character varying(255),
    intitule_cours character varying(255),
    semestre_module character varying(255),
    credits_module integer,
    description_module text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    avancement_pourcentage integer DEFAULT 0
);


--
-- Name: module_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.module_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: module_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.module_id_seq OWNED BY public.module.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    type_notifications character varying(255),
    message_notifications text,
    cree_le_notifications timestamp(0) without time zone,
    lien_notifications character varying(255),
    pour_tous boolean DEFAULT false NOT NULL,
    ticket_id bigint,
    utilisateur_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: professeurs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.professeurs (
    id bigint NOT NULL,
    grade_professeurs character varying(255),
    telephone_professeurs character varying(255),
    specialite_professeurs character varying(255),
    utilisateur_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: professeurs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.professeurs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: professeurs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.professeurs_id_seq OWNED BY public.professeurs.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    nom_roles character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: souggestions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.souggestions (
    id bigint NOT NULL,
    titre_souggestion character varying(255),
    contenu_souggestion text,
    like_souggestion integer,
    dislike_souggestion integer,
    etudiant_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    category character varying(255) DEFAULT 'Général'::character varying
);


--
-- Name: souggestions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.souggestions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: souggestions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.souggestions_id_seq OWNED BY public.souggestions.id;


--
-- Name: suggestion_votes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.suggestion_votes (
    id bigint NOT NULL,
    vote_type character varying(255) NOT NULL,
    utilisateur_id bigint NOT NULL,
    souggestion_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: suggestion_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.suggestion_votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: suggestion_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.suggestion_votes_id_seq OWNED BY public.suggestion_votes.id;


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tickets (
    id bigint NOT NULL,
    portee_ticket character varying(255),
    referance_ticket character varying(255),
    type_ticket character varying(255),
    categorie_ticket character varying(255),
    object_ticket character varying(255),
    description_ticket text,
    statut_ticket character varying(255),
    priorite_ticket character varying(255),
    note_satisfaction_ticket integer,
    cree_le_ticket timestamp(0) without time zone,
    utilisateur_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    module_id bigint
);


--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tickets_id_seq OWNED BY public.tickets.id;


--
-- Name: utilisateurs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.utilisateurs (
    id bigint NOT NULL,
    email_utilisateurs character varying(255),
    mot_de_pass_utilisateurs character varying(255),
    prenom_utilisateurs character varying(255),
    nom_utilisateurs character varying(255),
    cree_le_utilisateurs timestamp(0) without time zone,
    actif_utilisateurs boolean DEFAULT false NOT NULL,
    avatar_utilisateurs character varying(255),
    role_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: utilisateurs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.utilisateurs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: utilisateurs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.utilisateurs_id_seq OWNED BY public.utilisateurs.id;


--
-- Name: administration id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.administration ALTER COLUMN id SET DEFAULT nextval('public.administration_id_seq'::regclass);


--
-- Name: annonces id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.annonces ALTER COLUMN id SET DEFAULT nextval('public.annonces_id_seq'::regclass);


--
-- Name: chapter id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chapter ALTER COLUMN id SET DEFAULT nextval('public.chapter_id_seq'::regclass);


--
-- Name: commentaires id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commentaires ALTER COLUMN id SET DEFAULT nextval('public.commentaires_id_seq'::regclass);


--
-- Name: enseigner id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enseigner ALTER COLUMN id SET DEFAULT nextval('public.enseigner_id_seq'::regclass);


--
-- Name: etudiants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.etudiants ALTER COLUMN id SET DEFAULT nextval('public.etudiants_id_seq'::regclass);


--
-- Name: grades id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grades ALTER COLUMN id SET DEFAULT nextval('public.grades_id_seq'::regclass);


--
-- Name: groupes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groupes ALTER COLUMN id SET DEFAULT nextval('public.groupes_id_seq'::regclass);


--
-- Name: module id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.module ALTER COLUMN id SET DEFAULT nextval('public.module_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: professeurs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professeurs ALTER COLUMN id SET DEFAULT nextval('public.professeurs_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: souggestions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.souggestions ALTER COLUMN id SET DEFAULT nextval('public.souggestions_id_seq'::regclass);


--
-- Name: suggestion_votes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_votes ALTER COLUMN id SET DEFAULT nextval('public.suggestion_votes_id_seq'::regclass);


--
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id SET DEFAULT nextval('public.tickets_id_seq'::regclass);


--
-- Name: utilisateurs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilisateurs ALTER COLUMN id SET DEFAULT nextval('public.utilisateurs_id_seq'::regclass);


--
-- Name: administration administration_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.administration
    ADD CONSTRAINT administration_pkey PRIMARY KEY (id);


--
-- Name: annonces annonces_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.annonces
    ADD CONSTRAINT annonces_pkey PRIMARY KEY (id);


--
-- Name: chapter chapter_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chapter
    ADD CONSTRAINT chapter_pkey PRIMARY KEY (id);


--
-- Name: commentaires commentaires_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commentaires
    ADD CONSTRAINT commentaires_pkey PRIMARY KEY (id);


--
-- Name: enseigner enseigner_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enseigner
    ADD CONSTRAINT enseigner_pkey PRIMARY KEY (id);


--
-- Name: etudiants etudiants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.etudiants
    ADD CONSTRAINT etudiants_pkey PRIMARY KEY (id);


--
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- Name: groupes groupes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groupes
    ADD CONSTRAINT groupes_pkey PRIMARY KEY (id);


--
-- Name: guardian_tokens guardian_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guardian_tokens
    ADD CONSTRAINT guardian_tokens_pkey PRIMARY KEY (jti, aud);


--
-- Name: module module_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.module
    ADD CONSTRAINT module_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: professeurs professeurs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professeurs
    ADD CONSTRAINT professeurs_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: souggestions souggestions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.souggestions
    ADD CONSTRAINT souggestions_pkey PRIMARY KEY (id);


--
-- Name: suggestion_votes suggestion_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_votes
    ADD CONSTRAINT suggestion_votes_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: utilisateurs utilisateurs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (id);


--
-- Name: administration_utilisateur_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX administration_utilisateur_id_index ON public.administration USING btree (utilisateur_id);


--
-- Name: annonces_utilisateur_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX annonces_utilisateur_id_index ON public.annonces USING btree (utilisateur_id);


--
-- Name: chapter_module_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX chapter_module_id_index ON public.chapter USING btree (module_id);


--
-- Name: chapter_professeur_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX chapter_professeur_id_index ON public.chapter USING btree (professeur_id);


--
-- Name: commentaires_ticket_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX commentaires_ticket_id_index ON public.commentaires USING btree (ticket_id);


--
-- Name: commentaires_utilisateur_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX commentaires_utilisateur_id_index ON public.commentaires USING btree (utilisateur_id);


--
-- Name: enseigner_module_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX enseigner_module_id_index ON public.enseigner USING btree (module_id);


--
-- Name: enseigner_professeur_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX enseigner_professeur_id_index ON public.enseigner USING btree (professeur_id);


--
-- Name: enseigner_professeur_id_module_id_annee_academique_enseigner_se; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX enseigner_professeur_id_module_id_annee_academique_enseigner_se ON public.enseigner USING btree (professeur_id, module_id, annee_academique_enseigner, semestre_enseigner);


--
-- Name: etudiants_groupe_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX etudiants_groupe_id_index ON public.etudiants USING btree (groupe_id);


--
-- Name: etudiants_utilisateur_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX etudiants_utilisateur_id_index ON public.etudiants USING btree (utilisateur_id);


--
-- Name: grades_etudiant_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX grades_etudiant_id_index ON public.grades USING btree (etudiant_id);


--
-- Name: grades_etudiant_id_module_id_professeur_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX grades_etudiant_id_module_id_professeur_id_index ON public.grades USING btree (etudiant_id, module_id, professeur_id);


--
-- Name: grades_module_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX grades_module_id_index ON public.grades USING btree (module_id);


--
-- Name: grades_professeur_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX grades_professeur_id_index ON public.grades USING btree (professeur_id);


--
-- Name: groupes_code_groupes_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX groupes_code_groupes_index ON public.groupes USING btree (code_groupes);


--
-- Name: groupes_modules_groupe_id_module_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX groupes_modules_groupe_id_module_id_index ON public.groupes_modules USING btree (groupe_id, module_id);


--
-- Name: groupes_modules_module_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX groupes_modules_module_id_index ON public.groupes_modules USING btree (module_id);


--
-- Name: module_code_cours_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX module_code_cours_index ON public.module USING btree (code_cours);


--
-- Name: notifications_ticket_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_ticket_id_index ON public.notifications USING btree (ticket_id);


--
-- Name: notifications_utilisateur_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_utilisateur_id_index ON public.notifications USING btree (utilisateur_id);


--
-- Name: professeurs_utilisateur_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX professeurs_utilisateur_id_index ON public.professeurs USING btree (utilisateur_id);


--
-- Name: roles_nom_roles_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX roles_nom_roles_index ON public.roles USING btree (nom_roles);


--
-- Name: souggestions_etudiant_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX souggestions_etudiant_id_index ON public.souggestions USING btree (etudiant_id);


--
-- Name: suggestion_votes_souggestion_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX suggestion_votes_souggestion_id_index ON public.suggestion_votes USING btree (souggestion_id);


--
-- Name: suggestion_votes_utilisateur_id_souggestion_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX suggestion_votes_utilisateur_id_souggestion_id_index ON public.suggestion_votes USING btree (utilisateur_id, souggestion_id);


--
-- Name: tickets_module_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tickets_module_id_index ON public.tickets USING btree (module_id);


--
-- Name: tickets_referance_ticket_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX tickets_referance_ticket_index ON public.tickets USING btree (referance_ticket);


--
-- Name: tickets_utilisateur_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tickets_utilisateur_id_index ON public.tickets USING btree (utilisateur_id);


--
-- Name: utilisateurs_email_utilisateurs_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX utilisateurs_email_utilisateurs_index ON public.utilisateurs USING btree (email_utilisateurs);


--
-- Name: utilisateurs_role_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX utilisateurs_role_id_index ON public.utilisateurs USING btree (role_id);


--
-- Name: administration administration_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.administration
    ADD CONSTRAINT administration_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


--
-- Name: annonces annonces_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.annonces
    ADD CONSTRAINT annonces_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE SET NULL;


--
-- Name: chapter chapter_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chapter
    ADD CONSTRAINT chapter_module_id_fkey FOREIGN KEY (module_id) REFERENCES public.module(id) ON DELETE CASCADE;


--
-- Name: chapter chapter_professeur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chapter
    ADD CONSTRAINT chapter_professeur_id_fkey FOREIGN KEY (professeur_id) REFERENCES public.professeurs(id) ON DELETE CASCADE;


--
-- Name: commentaires commentaires_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commentaires
    ADD CONSTRAINT commentaires_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: commentaires commentaires_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commentaires
    ADD CONSTRAINT commentaires_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE SET NULL;


--
-- Name: enseigner enseigner_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enseigner
    ADD CONSTRAINT enseigner_module_id_fkey FOREIGN KEY (module_id) REFERENCES public.module(id) ON DELETE CASCADE;


--
-- Name: enseigner enseigner_professeur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enseigner
    ADD CONSTRAINT enseigner_professeur_id_fkey FOREIGN KEY (professeur_id) REFERENCES public.professeurs(id) ON DELETE CASCADE;


--
-- Name: etudiants etudiants_groupe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.etudiants
    ADD CONSTRAINT etudiants_groupe_id_fkey FOREIGN KEY (groupe_id) REFERENCES public.groupes(id) ON DELETE SET NULL;


--
-- Name: etudiants etudiants_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.etudiants
    ADD CONSTRAINT etudiants_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


--
-- Name: grades grades_etudiant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_etudiant_id_fkey FOREIGN KEY (etudiant_id) REFERENCES public.etudiants(id) ON DELETE CASCADE;


--
-- Name: grades grades_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_module_id_fkey FOREIGN KEY (module_id) REFERENCES public.module(id) ON DELETE CASCADE;


--
-- Name: grades grades_professeur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_professeur_id_fkey FOREIGN KEY (professeur_id) REFERENCES public.professeurs(id) ON DELETE RESTRICT;


--
-- Name: groupes_modules groupes_modules_groupe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groupes_modules
    ADD CONSTRAINT groupes_modules_groupe_id_fkey FOREIGN KEY (groupe_id) REFERENCES public.groupes(id) ON DELETE CASCADE;


--
-- Name: groupes_modules groupes_modules_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groupes_modules
    ADD CONSTRAINT groupes_modules_module_id_fkey FOREIGN KEY (module_id) REFERENCES public.module(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE SET NULL;


--
-- Name: professeurs professeurs_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professeurs
    ADD CONSTRAINT professeurs_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


--
-- Name: souggestions souggestions_etudiant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.souggestions
    ADD CONSTRAINT souggestions_etudiant_id_fkey FOREIGN KEY (etudiant_id) REFERENCES public.etudiants(id) ON DELETE CASCADE;


--
-- Name: suggestion_votes suggestion_votes_souggestion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_votes
    ADD CONSTRAINT suggestion_votes_souggestion_id_fkey FOREIGN KEY (souggestion_id) REFERENCES public.souggestions(id) ON DELETE CASCADE;


--
-- Name: suggestion_votes suggestion_votes_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_votes
    ADD CONSTRAINT suggestion_votes_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


--
-- Name: tickets tickets_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_module_id_fkey FOREIGN KEY (module_id) REFERENCES public.module(id) ON DELETE SET NULL;


--
-- Name: tickets tickets_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE SET NULL;


--
-- Name: utilisateurs utilisateurs_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20260311184815);
INSERT INTO public."schema_migrations" (version) VALUES (20260311185031);
INSERT INTO public."schema_migrations" (version) VALUES (20260311185259);
INSERT INTO public."schema_migrations" (version) VALUES (20260311185406);
INSERT INTO public."schema_migrations" (version) VALUES (20260311190026);
INSERT INTO public."schema_migrations" (version) VALUES (20260311190123);
INSERT INTO public."schema_migrations" (version) VALUES (20260311190209);
INSERT INTO public."schema_migrations" (version) VALUES (20260311190247);
INSERT INTO public."schema_migrations" (version) VALUES (20260311190259);
INSERT INTO public."schema_migrations" (version) VALUES (20260311190308);
INSERT INTO public."schema_migrations" (version) VALUES (20260311190316);
INSERT INTO public."schema_migrations" (version) VALUES (20260311190325);
INSERT INTO public."schema_migrations" (version) VALUES (20260311190337);
INSERT INTO public."schema_migrations" (version) VALUES (20260312143837);
INSERT INTO public."schema_migrations" (version) VALUES (20260331150000);
INSERT INTO public."schema_migrations" (version) VALUES (20260331150100);
INSERT INTO public."schema_migrations" (version) VALUES (20260424120000);
INSERT INTO public."schema_migrations" (version) VALUES (20260424145930);
INSERT INTO public."schema_migrations" (version) VALUES (20260426125719);
INSERT INTO public."schema_migrations" (version) VALUES (20260426132524);
INSERT INTO public."schema_migrations" (version) VALUES (20260426143737);
INSERT INTO public."schema_migrations" (version) VALUES (20260426200000);
INSERT INTO public."schema_migrations" (version) VALUES (20260426210000);
