--
-- PostgreSQL database dump
--

\restrict uySZTCCC7DUsWTv9YGsbBuj6QH3botpNLGhNgkqgCtNPnhmVwZFsHAn0DSqjzQb

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 15.17 (Debian 15.17-1.pgdg13+1)

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
-- Name: ability; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ability (
    id integer NOT NULL,
    name character varying,
    description character varying
);


--
-- Name: ability_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ability_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ability_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ability_id_seq OWNED BY public.ability.id;


--
-- Name: move; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.move (
    id integer NOT NULL,
    name character varying,
    description character varying,
    type character varying,
    power integer,
    accuracy integer,
    damage_class character varying
);


--
-- Name: move_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.move_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: move_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.move_id_seq OWNED BY public.move.id;


--
-- Name: pokemon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pokemon (
    id integer NOT NULL,
    name character varying,
    generation integer,
    height double precision,
    weight double precision,
    base_experience integer,
    hp integer,
    attack integer,
    defense integer,
    special_attack integer,
    special_defense integer,
    speed integer,
    cries json,
    sprites json,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: pokemon_ability; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pokemon_ability (
    pokemon_id integer,
    ability_id integer
);


--
-- Name: pokemon_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pokemon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pokemon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pokemon_id_seq OWNED BY public.pokemon.id;


--
-- Name: pokemon_move; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pokemon_move (
    pokemon_id integer,
    move_id integer
);


--
-- Name: pokemon_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pokemon_type (
    pokemon_id integer,
    type_id integer
);


--
-- Name: type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.type (
    id integer NOT NULL,
    name character varying,
    double_damage_to json,
    double_damage_from json,
    half_damage_to json,
    half_damage_from json,
    no_damage_to json,
    no_damage_from json
);


--
-- Name: type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.type_id_seq OWNED BY public.type.id;


--
-- Name: ability id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ability ALTER COLUMN id SET DEFAULT nextval('public.ability_id_seq'::regclass);


--
-- Name: move id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.move ALTER COLUMN id SET DEFAULT nextval('public.move_id_seq'::regclass);


--
-- Name: pokemon id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pokemon ALTER COLUMN id SET DEFAULT nextval('public.pokemon_id_seq'::regclass);


--
-- Name: type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type ALTER COLUMN id SET DEFAULT nextval('public.type_id_seq'::regclass);


--
-- Data for Name: ability; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ability (id, name, description) FROM stdin;
1	overgrow	When this Pokémon has 1/3 or less of its HP remaining, its grass-type moves inflict 1.5× as much regular damage.
2	chlorophyll	This Pokémon's Speed is doubled during strong sunlight.\n\nThis bonus does not count as a stat modifier.
\.


--
-- Data for Name: move; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.move (id, name, description, type, power, accuracy, damage_class) FROM stdin;
1	razor-wind	Inflicts regular damage.  User’s critical hit rate is one level higher when using this move.  User charges for one turn before attacking.\n\nThis move cannot be selected by sleep talk.	normal	80	100	special
2	swords-dance	Raises the user’s Attack by two stages.	normal	\N	\N	status
3	cut	Inflicts regular damage.	normal	50	95	physical
4	bind	Inflicts regular damage.  For the next 2–5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.  The user continues to use other moves during this time.  If the user leaves the field, this effect ends.\n\nHas a 3/8 chance each to hit 2 or 3 times, and a 1/8 chance each to hit 4 or 5 times.  Averages to 3 hits per use.\n\nrapid spin cancels this effect.	normal	15	85	physical
5	vine-whip	Inflicts regular damage.	grass	45	100	physical
6	headbutt	Inflicts regular damage.  Has a $effect_chance% chance to make the target flinch.	normal	70	100	physical
7	tackle	Inflicts regular damage.	normal	40	100	physical
8	body-slam	Inflicts regular damage.  Has a $effect_chance% chance to paralyze the target.	normal	85	100	physical
9	take-down	Inflicts regular damage.  User takes 1/4 the damage it inflicts in recoil.	normal	90	85	physical
10	double-edge	Inflicts regular damage.  User takes 1/3 the damage it inflicts in recoil.	normal	120	100	physical
11	growl	Lowers the target’s Attack by one stage.	normal	\N	100	status
12	strength	Inflicts regular damage.	normal	80	100	physical
13	mega-drain	Inflicts regular damage.  Drains half the damage inflicted to heal the user.	grass	40	100	special
14	leech-seed	Plants a seed on the target that drains 1/8 of its max HP at the end of every turn and heals the user for the amount taken.  Has no effect on grass Pokémon.  The seed remains until the target leaves the field.\n\nThe user takes damage instead of being healed if the target has liquid ooze.\n\nrapid spin will remove this effect.\n\nThis effect is passed on by baton pass.	grass	\N	90	status
15	growth	Raises the user’s Attack and Special Attack by one stage each.  During sunny day, raises both stats by two stages.	normal	\N	\N	status
16	razor-leaf	Inflicts regular damage.  User’s critical hit rate is one level higher when using this move.	grass	55	95	physical
17	solar-beam	Inflicts regular damage.  User charges for one turn before attacking.\n\nDuring sunny day, the charge turn is skipped.\n\nDuring hail, rain dance, or sandstorm, power is halved.\n\nThis move cannot be selected by sleep talk.	grass	120	100	special
18	poison-powder	Poisons the target.	poison	\N	75	status
19	sleep-powder	Puts the target to sleep.	grass	\N	75	status
20	petal-dance	Inflicts regular damage.  User is forced to attack with this move for 2–3 turns,selected at random.  After the last hit, the user becomes confused.\n\nsafeguard does not protect against the confusion from this move.	grass	120	100	special
21	string-shot	Lowers the target’s Speed by two stages.	bug	\N	95	status
22	toxic	Badly poisons the target.  Never misses when used by a poison-type Pokémon.	poison	\N	90	status
23	rage	Inflicts regular damage.  Every time the user is hit after it uses this move but before its next action, its Attack raises by one stage.	normal	20	100	physical
24	mimic	This move is replaced by the target’s last successfully used move, and its PP changes to 5.  If the target hasn’t used a move since entering the field, if it tried to use a move this turn and failed, or if the user already knows the targeted move, this move will fail.  This effect vanishes when the user leaves the field.\n\nIf chatter, metronome, mimic, sketch, or struggle is selected, this move will fail.\n\nThis move cannot be copied by mirror move, nor selected by assist or metronome, nor forced by encore.	normal	\N	\N	status
25	double-team	Raises the user’s evasion by one stage.	normal	\N	\N	status
26	defense-curl	Raises user’s Defense by one stage.\n\nAfter this move is used, the power of ice ball and rollout are doubled until the user leaves the field.	normal	\N	\N	status
27	light-screen	Erects a barrier around the user’s side of the field that reduces damage from special attacks by half for five turns.  In double battles, the reduction is 1/3.  Critical hits are not affected by the barrier.\n\nIf the user is holding light clay, the barrier lasts for eight turns.\n\nbrick break or defog used by an opponent will destroy the barrier.	psychic	\N	\N	status
28	reflect	Erects a barrier around the user’s side of the field that reduces damage from physical attacks by half for five turns.  In double battles, the reduction is 1/3.  Critical hits are not affected by the barrier.\n\nIf the user is holding light clay, the barrier lasts for eight turns.\n\nbrick break or defog used by an opponent will destroy the barrier.	psychic	\N	\N	status
29	bide	User waits for two turns.  On the second turn, the user inflicts twice the damage it accumulated on the last Pokémon to hit it.  Damage inflicted is typeless.\n\nThis move cannot be selected by sleep talk.	normal	\N	\N	physical
30	sludge	Inflicts regular damage.  Has a $effect_chance% chance to poison the target.	poison	65	100	special
31	skull-bash	Inflicts regular damage.  Raises the user’s Defense by one stage.  User then charges for one turn before attacking.\n\nThis move cannot be selected by sleep talk.	normal	130	100	physical
32	amnesia	Raises the user’s Special Defense by two stages.	psychic	\N	\N	status
33	flash	Lowers the target’s accuracy by one stage.	normal	\N	100	status
34	rest	User falls to sleep and immediately regains all its HP.  If the user has another major status effect, sleep will replace it.  The user will always wake up after two turns, or one turn with early bird.\n\nThis move fails if the Pokémon cannot fall asleep due to uproar, insomnia, or vital spirit.  It also fails if the Pokémon is at full health or is already asleep.	psychic	\N	\N	status
76	venoshock	Inflicts regular damage.  If the target is poisoned, this move has double power.	poison	65	100	special
77	acid-spray	Inflicts regular damage.  Lowers the target’s Special Defense by two stages.	poison	40	100	special
78	round	Inflicts regular damage.  If round has already been used this turn, this move’s power is doubled.  After this move is used, any other Pokémon using it this turn will immediately do so (in the order they would otherwise act), regardless of Speed or priority.  Pokémon using other moves will then continue to act as usual.	normal	60	100	special
79	echoed-voice	Inflicts regular damage.  If any friendly Pokémon used this move earlier this turn or on the previous turn, that use’s power is added to this move’s power, to a maximum of 200.	normal	40	100	special
35	substitute	Transfers 1/4 the user’s max HP into a doll that absorbs damage and causes most negative move effects to fail.  If the user leaves the field, the doll will vanish.  If the user cannot pay the HP cost, this move will fail.\n\nThe doll takes damage as normal, using the user’s stats and types, and will break when its HP reaches zero.  Self-inflicted damage from confusion or recoil is not absorbed.  Healing effects from opponents ignore the doll and heal the user as normal.  Moves that work based on the user’s HP still do so; the doll’s HP does not influence any move.\n\nThe doll will block major status effects, confusion, and flinching.  The effects of smelling salts and wake up slap do not trigger against a doll, even if the Pokémon behind the doll has the appropriate major status effect.  Multi-turn trapping moves like wrap will hit the doll for their regular damage, but the multi-turn trapping and damage effects will not activate.\n\nMoves blocked or damage absorbed by the doll do not count as hitting the user or inflicting damage for any effects that respond to such, e.g., avalanche, counter, or a rowap berry.  magic coat still works as normal, even against moves the doll would block.  Opposing Pokémon that damage the doll with a leech move like absorb are healed as normal.\n\nIt will also block acupressure, block, the curse effect of curse, dream eater, embargo, flatter, gastro acid, grudge, heal block, leech seed, lock on, mean look, mimic, mind reader, nightmare, pain split, psycho shift, spider web, sketch, swagger, switcheroo, trick, worry seed, and yawn.  A Pokémon affected by yawn before summoning the doll will still fall to sleep.\n\nThe doll blocks intimidate, but all other abilities act as though the doll did not exist.  If the user has an ability that absorbs moves of a certain type for HP (such as volt absorb absorbing thunder wave), such moves will not be blocked.\n\nlife orb and berries that cause confusion still work as normal, but their respective HP loss and confusion are absorbed/blocked by the doll.\n\nThe user is still vulnerable to damage inflicted when entering or leaving the field, such as by pursuit or spikes; however, the doll will block the poison effect of toxic spikes.\n\nThe doll is passed on by baton pass.  It keeps its existing HP, but uses the replacement Pokémon’s stats and types for damage calculation.\n\nAll other effects work as normal.	normal	\N	\N	status
36	snore	Only usable if the user is sleeping.  Inflicts regular damage.  Has a $effect_chance% chance to make the target flinch.	normal	50	100	special
37	curse	If the user is a ghost: user pays half its max HP to place a curse on the target, damaging it for 1/4 its max HP every turn.\nOtherwise: Lowers the user’s Speed by one stage, and raises its Attack and Defense by one stage each.\n\nThe curse effect is passed on by baton pass.\n\nThis move cannot be copied by mirror move.	ghost	\N	\N	status
38	protect	No moves will hit the user for the remainder of this turn.  If the user is last to act this turn, this move will fail.\n\nIf the user successfully used detect, endure, protect, quick guard, or wide guard on the last turn, this move has a 50% chance to fail.\n\nlock on, mind reader, and no guard provide a (100 – accuracy)% chance for moves to break through this move.  This does not apply to one-hit KO moves (fissure, guillotine, horn drill, and sheer cold); those are always blocked by this move.\n\nthunder during rain dance and blizzard during hail have a 30% chance to break through this move.\n\nThe following effects are not prevented by this move:\n\n* acupressure from an ally\n* curse’s curse effect\n* Delayed damage from doom desire and future sight; however, these moves will be prevented if they are used this turn\n* feint, which will also end this move’s protection after it hits\n* imprison\n* perish song\n* shadow force\n* Moves that merely copy the user, such as transform or psych up\n\nThis move cannot be selected by assist or metronome.	normal	\N	\N	status
39	sludge-bomb	Inflicts regular damage.  Has a $effect_chance% chance to poison the target.	poison	90	100	special
40	mud-slap	Inflicts regular damage.  Has a $effect_chance% chance to lower the target’s accuracy by one stage.	ground	20	100	special
41	outrage	Inflicts regular damage.  User is forced to attack with this move for 2–3 turns,selected at random.  After the last hit, the user becomes confused.\n\nsafeguard does not protect against the confusion from this move.	dragon	120	100	physical
42	giga-drain	Inflicts regular damage.  Drains half the damage inflicted to heal the user.	grass	75	100	special
43	endure	The user’s HP cannot be lowered below 1 by any means for the remainder of this turn.\n\nIf the user successfully used detect, endure, protect, quick guard, or wide guard on the last turn, this move has a 50% chance to fail.\n\nThis move cannot be selected by assist or metronome.	normal	\N	\N	status
44	charm	Lowers the target’s Attack by two stages.	fairy	\N	100	status
45	false-swipe	Inflicts regular damage.  Will not reduce the target’s HP below 1.	normal	40	100	physical
46	swagger	Raises the target’s Attack by two stages, then confuses it.  If the target’s Attack cannot be raised by two stages, the confusion is not applied.	normal	\N	85	status
47	fury-cutter	Inflicts regular damage.  Power doubles after every time this move is used, whether consecutively or not, maxing out at 16x.  If this move misses or the user leaves the field, power resets.	bug	40	95	physical
48	attract	Causes the target to fall in love with the user, giving it a 50% chance to do nothing each turn.  If the user and target are the same gender, or either is genderless, this move will fail.  If either Pokémon leaves the field, this effect ends.	normal	\N	100	status
49	sleep-talk	Only usable if the user is sleeping.  Randomly selects and uses one of the user’s other three moves.  Use of the selected move requires and costs 0 PP.\n\nThis move will not select assist, bide, bounce, chatter, copycat, dig, dive, fly, focus punch, me first, metronome, mirror move, shadow force, skull bash, sky attack, sky drop, sleep talk, solar beam, razor wind, or uproar.\n\nIf the selected move requires a recharge turn—i.e., one of blast burn, frenzy plant, giga impact, hydro cannon, hyper beam, roar of time, or rock wrecker—and the user is still sleeping next turn, then it’s forced to use this move again and pay another PP for the recharge turn.\n\nThis move cannot be copied by mirror move, nor selected by assist, metronome, or sleep talk.	normal	\N	\N	status
50	return	Inflicts regular damage.  Power increases with happiness, given by `happiness * 2 / 5`, to a maximum of 102.  Power bottoms out at 1.	normal	\N	100	physical
51	frustration	Inflicts regular damage.  Power increases inversely with happiness, given by `(255 - happiness) * 2 / 5`, to a maximum of 102.  Power bottoms out at 1.	normal	\N	100	physical
52	safeguard	Protects Pokémon on the user’s side of the field from major status effects and confusion for five turns.  Does not cancel existing ailments.  This effect remains even if the user leaves the field.\n\nIf yawn is used while this move is in effect, it will immediately fail.\n\ndefog used by an opponent will end this effect.\n\nThis effect does not prevent the confusion caused by outrage, petal dance, or thrash.	normal	\N	\N	status
53	sweet-scent	Lowers the target’s evasion by one stage.	normal	\N	100	status
54	synthesis	Heals the user for half its max HP.\n\nDuring sunny day, the healing is increased to 2/3 max HP.\n\nDuring hail, rain dance, or sandstorm, the healing is decreased to 1/4 max HP.	grass	\N	\N	status
80	grass-pledge	Inflicts regular damage.  If a friendly Pokémon used fire pledge earlier this turn, all opposing Pokémon will take 1/8 their max HP in damage at the end of every turn for four turns (including this one).	grass	80	100	special
81	work-up	Raises the user’s Attack and Special Attack by one stage each.	normal	\N	\N	status
82	grassy-terrain	For five turns, heals all Pokémon on the ground for 1/16 their max HP each turn and strengthens their grass moves to 1.5× their power.\n\nChanges nature power to energy ball.	grass	\N	\N	status
55	hidden-power	Inflicts regular damage.  Power and type are determined by the user’s IVs.\n\nPower is given by `x * 40 / 63 + 30`.  `x` is obtained by arranging bit 1 from the IV for each of Special Defense, Special Attack, Speed, Defense, Attack, and HP in that order.  (Bit 1 is 1 if the IV is of the form `4n + 2` or `4n + 3`.  `x` is then 64 * Special Defense IV bit 1, plus 32 * Special Attack IV bit 1, etc.)\n\nPower is always between 30 and 70, inclusive.  Average power is 49.5.\n\nType is given by `y * 15 / 63`, where `y` is similar to `x` above, except constructed from bit 0.  (Bit 0 is 1 if the IV is odd.)  The result is looked up in the following table.\n\nValue | Type\n----: | --------\n    0 | fighting\n    1 | flying\n    2 | poison\n    3 | ground\n    4 | rock\n    5 | bug\n    6 | ghost\n    7 | steel\n    8 | fire\n    9 | water\n   10 | grass\n   11 | electric\n   12 | psychic\n   13 | ice\n   14 | dragon\n   15 | dark\n\nThis move thus cannot be normal.  Most other types have an equal 1/16 chance to be selected, given random IVs.  However, due to the flooring used here, bug, fighting, and grass appear 5/64 of the time, and dark only 1/64 of the time.	normal	60	100	special
56	sunny-day	Changes the weather to sunshine for five turns, during which fire moves inflict 50% extra damage, and water moves inflict half damage.\n\nIf the user is holding heat rock, this effect lasts for eight turns.\n\nPokémon cannot become frozen.\n\nthunder has 50% accuracy.\n\nsolar beam skips its charge turn.\n\nmoonlight, morning sun, and synthesis heal 2/3 of the user’s max HP.\n\nPokémon with chlorophyll have doubled original Speed.\n\nPokémon with forecast become fire.\n\nPokémon with leaf guard are not affected by major status effects.\n\nPokémon with flower gift change form; every Pokémon on their side of the field have their original Attack and Special Attack increased by 50%.\n\nPokémon with dry skin lose 1/8 max HP at the end of each turn.\n\nPokémon with solar power have their original Special Attack raised by 50% but lose 1/8 their max HP at the end of each turn.	fire	\N	\N	status
57	rock-smash	Inflicts regular damage.  Has a $effect_chance% chance to lower the target’s Defense by one stage.	fighting	40	100	physical
58	facade	Inflicts regular damage.  If the user is burned, paralyzed, or poisoned, this move has double power.	normal	70	100	physical
59	nature-power	Uses another move chosen according to the terrain.\n\nTerrain                   | Selected move\n------------------------- | ------------------\nBuilding                  | tri attack\nCave                      | rock slide\nDeep water                | hydro pump\nDesert                    | earthquake\nGrass                     | seed bomb\nMountain                  | rock slide\nRoad                      | earthquake\nShallow water             | hydro pump\nSnow                      | blizzard\nTall grass                | seed bomb\nelectric terrain | thunderbolt\ngrassy terrain   | energy ball\nmisty terrain    | moonblast\n\nIn Pokémon Battle Revolution:\n\nTerrain        | Selected move\n-------------- | ------------------\nCourtyard      | tri attack\nCrystal        | rock slide\nGateway        | hydro pump\nMagma          | rock slide\nMain Street    | tri attack\nNeon           | tri attack\nStargazer      | rock slide\nSunny Park     | seed bomb\nSunset         | earthquake\nWaterfall      | seed bomb\n\nThis move cannot be copied by mirror move.	normal	\N	\N	status
60	helping-hand	Boosts the power of the target’s moves by 50% until the end of this turn.\n\nThis move cannot be copied by mirror move, nor selected by assist or metronome.	normal	\N	\N	status
61	ingrain	Prevents the user from switching out.  User regains 1/16 of its max HP at the end of every turn.  If the user was immune to ground attacks, it will now take normal damage from them.\n\nroar and whirlwind will not affect the user.  The user cannot use magnet rise.\n\nThe user may still use u turn to leave the field.\n\nThis effect can be passed with baton pass.	grass	\N	\N	status
62	knock-off	Inflicts regular damage.  Target loses its held item.\n\nNeither the user nor the target can recover its item with recycle.\n\nIf the target has multitype or sticky hold, it will take damage but not lose its item.	dark	65	100	physical
63	secret-power	Inflicts regular damage.  Has a $effect_chance% chance to inflict an effect chosen according to the terrain.\n\nTerrain        | Effect\n-------------- | -------------------------------------------------------------\nBuilding       | Paralyzes target\nCave           | Makes target flinch\nDeep water     | Lowers target’s Attack by one stage\nDesert         | Lowers target’s accuracy by one stage\nGrass          | Puts target to sleep\nMountain       | Makes target flinch\nRoad           | Lowers target’s accuracy by one stage\nShallow water  | Lowers target’s Attack by one stage\nSnow           | Freezes target\nTall grass     | Puts target to sleep\n\nIn Pokémon Battle Revolution:\n\nTerrain        | Effect\n-------------- | -------------------------------------------------------------\nCourtyard      | Paralyzes target\nCrystal        | Makes target flinch\nGateway        | Lowers target’s Attack by one stage\nMagma          | Makes target flinch\nMain Street    | Paralyzes target\nNeon           | Paralyzes target\nStargazer      | Makes target flinch\nSunny Park     | Puts target to sleep\nSunset         | Lowers target’s accuracy by one stage\nWaterfall      | Puts target to sleep\n	normal	70	100	physical
64	weather-ball	Inflicts regular damage.  If a weather move is active, this move has double power, and its type becomes the type of the weather move.  shadow sky is typeless for the purposes of this move.	normal	50	100	special
65	grass-whistle	Puts the target to sleep.	grass	\N	55	status
66	bullet-seed	Inflicts regular damage.  Hits 2–5 times in one turn.\n\nHas a 3/8 chance each to hit 2 or 3 times, and a 1/8 chance each to hit 4 or 5 times.  Averages to 3 hits per use.	grass	25	100	physical
67	magical-leaf	Inflicts regular damage.  Ignores accuracy and evasion modifiers.	grass	60	\N	special
68	natural-gift	Inflicts regular damage.  Power and type are determined by the user’s held berry.  The berry is consumed.  If the user is not holding a berry, this move will fail.	normal	\N	100	physical
69	worry-seed	Changes the target’s ability to insomnia.\n\nIf the target’s ability is truant or multitype, this move will fail.	grass	\N	100	status
70	seed-bomb	Inflicts regular damage.	grass	80	100	physical
71	energy-ball	Inflicts regular damage.  Has a $effect_chance% chance to lower the target’s Special Defense by one stage.	grass	90	100	special
72	leaf-storm	Inflicts regular damage, then lowers the user’s Special Attack by two stages.	grass	130	90	special
73	power-whip	Inflicts regular damage.	grass	120	85	physical
74	captivate	Lowers the target’s Special Attack by two stages.  If the user and target are the same gender, or either is genderless, this move will fail.	normal	\N	100	status
75	grass-knot	Inflicts regular damage.  Power increases with the target’s weight in kilograms, to a maximum of 120.\n\nTarget’s weight | Power\n--------------- | ----:\nUp to 10kg      |    20\nUp to 25kg      |    40\nUp to 50kg      |    60\nUp to 100kg     |    80\nUp to 200kg     |   100\nAbove 200kg     |   120\n	grass	\N	100	special
83	confide	Lowers the target’s Special Attack by one stage.	normal	\N	\N	status
84	grassy-glide	Inflicts regular damage.	grass	55	100	physical
85	tera-blast	No description	normal	80	100	special
86	trailblaze	No description	grass	50	100	physical
87	roar	Switches the target out for another of its trainer’s Pokémon selected at random.  Wild battles end immediately.\n\nDoesn’t affect Pokémon with suction cups or under the effect of ingrain.	normal	\N	\N	status
88	hyper-beam	Inflicts regular damage.  User loses its next turn to "recharge", and cannot attack or switch out during that turn.	normal	150	90	special
89	earthquake	Inflicts regular damage.\n\nIf the target is in the first turn of dig, this move will hit with double power.	ground	100	100	physical
90	scary-face	Lowers the target’s Speed by two stages.	normal	\N	100	status
91	block	The target cannot switch out normally.  Ignores accuracy and evasion modifiers.  This effect ends when the user leaves the field.\n\nThe target may still escape by using baton pass, u turn, or a shed shell.\n\nBoth the user and the target pass on this effect with baton pass.	normal	\N	\N	status
92	frenzy-plant	Inflicts regular damage.  User loses its next turn to "recharge", and cannot attack or switch out during that turn.	grass	150	90	special
93	poison-jab	Inflicts regular damage.  Has a $effect_chance% chance to poison the target.	poison	80	100	physical
94	earth-power	Inflicts regular damage.  Has a $effect_chance% chance to lower the target’s Special Defense by one stage.	ground	90	100	special
95	giga-impact	Inflicts regular damage.  User loses its next turn to "recharge", and cannot attack or switch out during that turn.	normal	150	90	physical
96	rock-climb	Inflicts regular damage.  Has a $effect_chance% chance to confuse the target.	normal	90	85	physical
97	bulldoze	Inflicts regular damage.  Has a $effect_chance% chance to lower the target’s Speed by one stage.	ground	60	100	physical
98	petal-blizzard	Inflicts regular damage.	grass	90	100	physical
99	stomping-tantrum	Inflicts regular damage.  Power is doubled if the user’s last move failed for any reason (i.e., produced the message "But it failed!") or was ineffective due to types.	ground	75	100	physical
100	terrain-pulse	Inflicts regular damage.	normal	50	100	special
\.


--
-- Data for Name: pokemon; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pokemon (id, name, generation, height, weight, base_experience, hp, attack, defense, special_attack, special_defense, speed, cries, sprites, created_at, updated_at) FROM stdin;
1	bulbasaur	1	7	69	64	45	49	49	65	65	45	["https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/1.ogg"]	{"gen-1": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/1.png", "shiny": null}, "gen-2": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/1.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/shiny/1.png"}, "gen-3": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/emerald/1.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/emerald/shiny/1.png"}, "gen-4": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/1.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/shiny/1.png"}, "gen-5": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/1.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/shiny/1.png"}, "gen-6": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/omegaruby-alphasapphire/1.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/omegaruby-alphasapphire/shiny/1.png"}, "gen-7": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vii/ultra-sun-ultra-moon/1.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vii/ultra-sun-ultra-moon/shiny/1.png"}, "gen-8": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-viii/brilliant-diamond-shining-pearl/1.png", "shiny": null}, "gen-9": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ix/scarlet-violet/1.png", "shiny": null}, "home": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/1.png"}}	2026-03-24 18:10:55.860347	2026-03-24 18:10:55.860352
2	ivysaur	1	10	130	142	60	62	63	80	80	60	["https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/2.ogg"]	{"gen-1": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/2.png", "shiny": null}, "gen-2": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/2.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/shiny/2.png"}, "gen-3": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/emerald/2.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/emerald/shiny/2.png"}, "gen-4": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/2.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/shiny/2.png"}, "gen-5": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/2.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/shiny/2.png"}, "gen-6": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/omegaruby-alphasapphire/2.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/omegaruby-alphasapphire/shiny/2.png"}, "gen-7": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vii/ultra-sun-ultra-moon/2.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vii/ultra-sun-ultra-moon/shiny/2.png"}, "gen-8": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-viii/brilliant-diamond-shining-pearl/2.png", "shiny": null}, "gen-9": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ix/scarlet-violet/2.png", "shiny": null}, "home": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/2.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/2.png"}}	2026-03-24 18:10:56.234319	2026-03-24 18:10:56.234323
3	venusaur	1	20	1000	236	80	82	83	100	100	80	["https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/3.ogg"]	{"gen-1": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/3.png", "shiny": null}, "gen-2": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/3.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/shiny/3.png"}, "gen-3": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/emerald/3.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/emerald/shiny/3.png"}, "gen-4": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/3.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/shiny/3.png"}, "gen-5": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/3.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/shiny/3.png"}, "gen-6": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/omegaruby-alphasapphire/3.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/omegaruby-alphasapphire/shiny/3.png"}, "gen-7": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vii/ultra-sun-ultra-moon/3.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vii/ultra-sun-ultra-moon/shiny/3.png"}, "gen-8": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-viii/brilliant-diamond-shining-pearl/3.png", "shiny": null}, "gen-9": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ix/scarlet-violet/3.png", "shiny": null}, "home": {"default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/3.png", "shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/3.png"}}	2026-03-24 18:10:59.384656	2026-03-24 18:10:59.384661
\.


--
-- Data for Name: pokemon_ability; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pokemon_ability (pokemon_id, ability_id) FROM stdin;
1	2
1	1
2	1
2	2
3	2
3	1
\.


--
-- Data for Name: pokemon_move; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pokemon_move (pokemon_id, move_id) FROM stdin;
1	50
1	21
1	76
1	65
1	72
1	15
1	8
1	38
1	13
1	54
1	74
1	22
1	30
1	84
1	55
1	18
1	12
1	37
1	25
1	79
1	31
1	75
1	62
1	14
1	32
1	19
1	41
1	56
1	26
1	36
1	85
1	67
1	83
1	53
1	73
1	44
1	11
1	3
1	43
1	61
1	1
1	77
1	86
1	35
1	64
1	29
1	70
1	42
1	58
1	59
1	2
1	69
1	63
1	46
1	20
1	81
1	6
1	45
1	48
1	78
1	9
1	16
1	28
1	51
1	82
1	71
1	80
1	10
1	40
1	4
1	57
1	49
1	68
1	47
1	33
1	5
1	17
1	34
1	27
1	23
1	66
1	7
1	39
1	60
1	52
1	24
2	41
2	71
2	72
2	42
2	73
2	74
2	2
2	22
2	75
2	78
2	76
2	77
2	20
2	25
2	43
2	26
2	3
2	27
2	4
2	5
2	28
2	21
2	6
2	29
2	7
2	32
2	8
2	19
2	33
2	9
2	34
2	10
2	35
2	11
2	36
2	80
2	44
2	37
2	45
2	38
2	46
2	39
2	24
2	47
2	84
2	40
2	48
2	85
2	79
2	49
2	86
2	50
2	23
2	51
2	83
2	52
2	82
2	53
2	18
2	81
2	54
2	87
2	55
2	56
2	57
2	58
2	59
2	60
2	61
2	62
2	12
2	63
2	13
2	64
2	14
2	66
2	15
2	67
2	16
2	68
2	70
2	17
2	69
3	94
3	34
3	100
3	90
3	89
3	83
3	10
3	68
3	72
3	4
3	73
3	39
3	74
3	16
3	82
3	45
3	36
3	7
3	33
3	19
3	88
3	29
3	62
3	75
3	93
3	60
3	76
3	77
3	64
3	61
3	78
3	20
3	38
3	17
3	79
3	80
3	22
3	15
3	84
3	96
3	23
3	95
3	98
3	81
3	43
3	63
3	9
3	12
3	28
3	49
3	42
3	56
3	70
3	27
3	35
3	57
3	24
3	92
3	44
3	71
3	11
3	40
3	50
3	54
3	99
3	46
3	14
3	37
3	97
3	41
3	8
3	13
3	67
3	66
3	55
3	48
3	69
3	58
3	91
3	47
3	2
3	59
3	6
3	53
3	32
3	52
3	5
3	25
3	51
3	86
3	3
3	85
3	87
3	21
3	18
3	26
\.


--
-- Data for Name: pokemon_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pokemon_type (pokemon_id, type_id) FROM stdin;
1	1
1	2
2	1
2	2
3	1
3	2
\.


--
-- Data for Name: type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.type (id, name, double_damage_to, double_damage_from, half_damage_to, half_damage_from, no_damage_to, no_damage_from) FROM stdin;
1	grass	["ground", "rock", "water"]	["flying", "poison", "bug", "fire", "ice"]	["flying", "poison", "bug", "steel", "fire", "grass", "dragon"]	["ground", "water", "grass", "electric"]	[]	[]
2	poison	["grass", "fairy"]	["ground", "psychic"]	["poison", "ground", "rock", "ghost"]	["fighting", "poison", "bug", "grass", "fairy"]	["steel"]	[]
\.


--
-- Name: ability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ability_id_seq', 2, true);


--
-- Name: move_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.move_id_seq', 100, true);


--
-- Name: pokemon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pokemon_id_seq', 6, true);


--
-- Name: type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.type_id_seq', 2, true);


--
-- Name: ability ability_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ability
    ADD CONSTRAINT ability_pkey PRIMARY KEY (id);


--
-- Name: move move_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.move
    ADD CONSTRAINT move_pkey PRIMARY KEY (id);


--
-- Name: pokemon pokemon_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pokemon
    ADD CONSTRAINT pokemon_pkey PRIMARY KEY (id);


--
-- Name: type type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type
    ADD CONSTRAINT type_pkey PRIMARY KEY (id);


--
-- Name: ix_ability_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_ability_name ON public.ability USING btree (name);


--
-- Name: ix_move_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_move_name ON public.move USING btree (name);


--
-- Name: ix_pokemon_attack; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_pokemon_attack ON public.pokemon USING btree (attack);


--
-- Name: ix_pokemon_defense; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_pokemon_defense ON public.pokemon USING btree (defense);


--
-- Name: ix_pokemon_generation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_pokemon_generation ON public.pokemon USING btree (generation);


--
-- Name: ix_pokemon_height; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_pokemon_height ON public.pokemon USING btree (height);


--
-- Name: ix_pokemon_hp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_pokemon_hp ON public.pokemon USING btree (hp);


--
-- Name: ix_pokemon_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_pokemon_name ON public.pokemon USING btree (name);


--
-- Name: ix_pokemon_special_attack; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_pokemon_special_attack ON public.pokemon USING btree (special_attack);


--
-- Name: ix_pokemon_special_defense; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_pokemon_special_defense ON public.pokemon USING btree (special_defense);


--
-- Name: ix_pokemon_speed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_pokemon_speed ON public.pokemon USING btree (speed);


--
-- Name: ix_pokemon_weight; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_pokemon_weight ON public.pokemon USING btree (weight);


--
-- Name: ix_type_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_type_name ON public.type USING btree (name);


--
-- Name: pokemon_ability pokemon_ability_ability_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pokemon_ability
    ADD CONSTRAINT pokemon_ability_ability_id_fkey FOREIGN KEY (ability_id) REFERENCES public.ability(id);


--
-- Name: pokemon_ability pokemon_ability_pokemon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pokemon_ability
    ADD CONSTRAINT pokemon_ability_pokemon_id_fkey FOREIGN KEY (pokemon_id) REFERENCES public.pokemon(id);


--
-- Name: pokemon_move pokemon_move_move_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pokemon_move
    ADD CONSTRAINT pokemon_move_move_id_fkey FOREIGN KEY (move_id) REFERENCES public.move(id);


--
-- Name: pokemon_move pokemon_move_pokemon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pokemon_move
    ADD CONSTRAINT pokemon_move_pokemon_id_fkey FOREIGN KEY (pokemon_id) REFERENCES public.pokemon(id);


--
-- Name: pokemon_type pokemon_type_pokemon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pokemon_type
    ADD CONSTRAINT pokemon_type_pokemon_id_fkey FOREIGN KEY (pokemon_id) REFERENCES public.pokemon(id);


--
-- Name: pokemon_type pokemon_type_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pokemon_type
    ADD CONSTRAINT pokemon_type_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.type(id);


--
-- PostgreSQL database dump complete
--

\unrestrict uySZTCCC7DUsWTv9YGsbBuj6QH3botpNLGhNgkqgCtNPnhmVwZFsHAn0DSqjzQb

