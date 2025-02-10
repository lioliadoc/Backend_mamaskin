--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Homebrew)
-- Dumped by pg_dump version 14.13 (Homebrew)

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
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


--
-- Name: condition; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.condition (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying NOT NULL,
    "references" character varying NOT NULL,
    requires_healthcare_provider boolean NOT NULL
);


--
-- Name: condition_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.condition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: condition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.condition_id_seq OWNED BY public.condition.id;


--
-- Name: story; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.story (
    id integer NOT NULL,
    name character varying NOT NULL,
    text character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    like_count integer DEFAULT 0 NOT NULL,
    fk_story_user_id integer NOT NULL
);


--
-- Name: story_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.story_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: story_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.story_id_seq OWNED BY public.story.id;


--
-- Name: symptom; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.symptom (
    id integer NOT NULL,
    name character varying NOT NULL,
    condition_id integer NOT NULL
);


--
-- Name: symptom_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.symptom_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: symptom_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.symptom_id_seq OWNED BY public.symptom.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    google_id character varying NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: condition id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.condition ALTER COLUMN id SET DEFAULT nextval('public.condition_id_seq'::regclass);


--
-- Name: story id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story ALTER COLUMN id SET DEFAULT nextval('public.story_id_seq'::regclass);


--
-- Name: symptom id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.symptom ALTER COLUMN id SET DEFAULT nextval('public.symptom_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.alembic_version (version_num) FROM stdin;
\.


--
-- Data for Name: condition; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.condition (id, name, description, "references", requires_healthcare_provider) FROM stdin;
2	Pemphigoid Gestationis	Pemphigoid Gestationis is an autoimmune blistering disorder that most often appears during the second or third trimester of pregnancy. It is marked by the development of tense blisters and urticarial plaques that are intensely pruritic and may appear on the abdomen, limbs, and occasionally the face. The condition is believed to arise when the immune system mistakenly targets the basement membrane of the skin, triggering inflammation and subsequent blister formation. Affected women often report discomfort, burning, and significant itching that can interfere with sleep and daily activities. Treatment usually involves systemic corticosteroids and other immunosuppressive agents to control the inflammatory process while maintaining careful skin care with soothing cleansers and emollients. Frequent monitoring by healthcare professionals is essential to manage the condition effectively and to ensure both maternal and fetal well-being. After delivery, symptoms tend to subside; however, some patients might require extended treatment postpartum. Early diagnosis and a tailored treatment plan are key in managing this rare but challenging dermatosis.	https://dermnetnz.org/topics/pemphigoid-gestationis	t
3	Prurigo of Pregnancy	Prurigo of Pregnancy is a dermatosis that appears in some women during pregnancy and is noted for its persistent, itchy, raised bumps. These lesions generally appear on the arms, legs, and sometimes the trunk, causing significant discomfort throughout the day. Although the exact mechanism remains unclear, the condition is thought to be related to immunologic changes and the skin’s reaction to the physical stresses of pregnancy. Women experiencing this condition often report that the intensity of the itching increases at night, affecting sleep quality. Treatment focuses on symptom relief and may include topical corticosteroids, oral antihistamines, and soothing emollients to calm the skin. Maintaining a gentle skincare regimen and avoiding irritants is also recommended. Medical evaluation is important to differentiate prurigo from other similar conditions, ensuring that an appropriate management plan is in place. With proper care, symptoms typically subside postpartum, although flare-ups may recur in subsequent pregnancies.	https://dermnetnz.org/topics/prurigo-of-pregnancy	t
4	Atopic Eruption of Pregnancy	Atopic Eruption of Pregnancy is a common inflammatory skin disorder that appears during pregnancy and is characterized by widespread dry, scaly, and itchy patches. Often emerging in the first or early second trimester, this condition may present as eczematous lesions on the face, arms, and torso. The pathogenesis is believed to be associated with a shift in the immune system and hormonal influences that occur during pregnancy. Affected women might experience discomfort, redness, and persistent irritation that can interfere with daily life. A combination of topical emollients, mild corticosteroids, and avoidance of known skin irritants is usually recommended. Maintaining a consistent and gentle skincare routine can help alleviate the symptoms. Regular consultations with a dermatologist are advised to rule out other dermatoses and to adjust treatment as needed. Overall, while the condition can be bothersome, it is manageable and generally resolves after delivery with appropriate care.	https://dermnetnz.org/topics/atopic-dermatitis	f
5	Gestational Melasma (Chloasma)	Gestational Melasma, also known as chloasma or the ‘mask of pregnancy,’ is a hyperpigmentation disorder that typically affects the facial skin during pregnancy. It is characterized by the appearance of irregular, brownish patches on the cheeks, forehead, and sometimes the upper lip. The discoloration is believed to be caused by hormonal fluctuations and increased sun sensitivity, which stimulate the overproduction of melanin. Although melasma does not pose a health risk, it can be a source of cosmetic concern and may lead to psychological distress. Management strategies include the regular use of broad-spectrum sunscreen, gentle skin care products, and, in some cases, topical lightening agents after delivery. Patients are advised to avoid direct sun exposure and to use protective measures when outdoors. Consultation with a dermatologist is recommended to confirm the diagnosis and to receive guidance on treatment options. In most cases, the pigmentation gradually fades postpartum.	https://dermnetnz.org/topics/melasma	f
6	Impetigo Herpetiformis	Impetigo Herpetiformis is a rare, pustular dermatosis that occurs during pregnancy and is regarded as a variant of pustular psoriasis. It typically manifests in the third trimester with the sudden onset of small pustules that coalesce into larger areas of inflammation. Patients often describe a burning sensation and intense itching along with the appearance of red, scaly patches on the skin. The exact cause remains uncertain, though it is believed to be linked to hormonal changes and alterations in immune regulation during pregnancy. Management generally involves systemic corticosteroids and supportive care, including the use of emollients and careful monitoring for potential complications. Due to its rarity and severity, early diagnosis is essential to prevent secondary infections and to ensure maternal and fetal safety. Close follow-up with a dermatologist and obstetrician is advised for appropriate treatment adjustments throughout pregnancy. Although symptoms usually improve after delivery, some women may require extended treatment postpartum.	https://dermnetnz.org/topics/impetigo-herpetiformis	t
7	Pregnancy-related Acne Vulgaris	Pregnancy-related Acne Vulgaris is an exacerbation of acne that can occur during pregnancy due to hormonal fluctuations and increased sebum production. It is characterized by inflamed papules, pustules, and occasionally cystic lesions that commonly appear on the face, back, and chest. The condition can cause discomfort and self-consciousness at a time when many women are already experiencing physical and emotional changes. Treatment options are carefully considered during pregnancy; mild topical agents and non-comedogenic skincare products are typically recommended over systemic medications. Patients are advised to maintain a gentle cleansing routine and to avoid harsh exfoliants that might further irritate the skin. Regular follow-up with a healthcare provider helps in monitoring the condition and adjusting the treatment plan if needed. Although acne may improve postpartum, some women might experience residual scarring or pigmentation changes that require additional care.	https://dermnetnz.org/topics/acne-vulgaris	f
8	Gestational Dermatitis	Gestational Dermatitis is a nonspecific inflammatory skin reaction that may occur during pregnancy, presenting as red, irritated patches on various parts of the body. Often appearing during the second or third trimester, this condition can be triggered by hormonal changes, stress, or environmental factors. Affected women commonly experience discomfort and itching, which can lead to further skin irritation if the area is scratched frequently. Standard management includes the use of gentle cleansers, regular moisturizing, and the application of low‐potency topical steroids when necessary. Patients are encouraged to avoid known irritants and to maintain a cool, soothing environment for the skin. Regular monitoring by a healthcare provider is important to rule out other causes of dermatitis and to tailor treatment appropriately. Although uncomfortable, gestational dermatitis is generally self-limited and tends to resolve after the pregnancy, allowing for full recovery of the skin.	https://dermnetnz.org/topics/dermatitis	f
9	Pruritic Folliculitis of Pregnancy	Pruritic Folliculitis of Pregnancy is a rare inflammatory condition that primarily affects the hair follicles during pregnancy, resulting in small, itchy bumps. The condition usually appears in the second or third trimester and is most commonly found on the chest, back, and shoulders. Although the exact cause is not fully understood, it is thought to be related to hormonal changes and immune system modulation during pregnancy. Women experiencing this condition report persistent itching and discomfort that can interfere with daily activities. Treatment generally involves the use of topical antibiotics or corticosteroids to reduce inflammation and prevent secondary infections. A gentle skincare regimen and the avoidance of harsh detergents or irritants are also recommended to soothe the affected areas. Close consultation with a dermatologist ensures that the condition is correctly diagnosed and managed, providing relief during pregnancy. In most cases, the symptoms subside following delivery.	https://dermnetnz.org/topics/folliculitis	t
10	Eczema in Pregnancy	Eczema in Pregnancy is an inflammatory skin condition characterized by dry, red, and itchy patches that can appear on different parts of the body. This condition may be an exacerbation of pre-existing eczema or a new onset triggered by the hormonal and immune changes that occur during pregnancy. Women often experience significant discomfort as the itching and inflammation may interfere with sleep and daily routines. Management typically involves a careful skincare regimen with regular moisturizing, the use of mild topical steroids, and avoidance of known irritants. In addition, cool compresses and gentle cleansing agents can help soothe the skin and reduce flare-ups. Regular follow-up with a healthcare provider is advised to monitor the condition and adjust treatments if necessary. With proper management, eczema during pregnancy is usually controlled and tends to improve postpartum, although some women may experience recurrences.	https://dermnetnz.org/topics/eczema	f
11	Lichen Planus of Pregnancy	Lichen Planus of Pregnancy is an inflammatory skin condition that may occur during pregnancy and is characterized by purple, polygonal, flat-topped papules. The lesions are often accompanied by intense itching and may appear on the wrists, lower legs, and oral mucosa. Although the underlying cause is not completely understood, it is believed that immune dysregulation during pregnancy plays a significant role. Affected women may experience discomfort and irritation that can affect their quality of life. Management typically includes topical corticosteroids, antihistamines, and a strict avoidance of potential irritants. Patients are encouraged to maintain a gentle skincare routine and to consult a dermatologist for a tailored treatment plan. Close observation during pregnancy helps to ensure that the condition is properly managed and that any complications are promptly addressed. After delivery, many women find that the symptoms gradually improve.	https://dermnetnz.org/topics/lichen-planus	f
12	Contact Dermatitis in Pregnancy	Contact Dermatitis in Pregnancy is an acute inflammatory reaction of the skin that results from direct exposure to irritants or allergens. This condition often presents as red, swollen, and itchy patches localized to the area of contact, which in pregnant women may be influenced by hormonal changes that increase skin sensitivity. Women experiencing contact dermatitis are advised to identify and avoid triggers such as harsh soaps, cosmetics, or other chemical agents. Treatment typically includes the application of topical corticosteroids, emollients, and in some cases, systemic antihistamines to reduce inflammation and itching. A careful review of personal care products and a commitment to a gentle skincare regimen are essential for managing symptoms. Consultation with a healthcare provider is important to rule out other dermatoses and to ensure a safe and effective treatment plan throughout pregnancy. Most cases resolve once the offending agent is eliminated and with appropriate supportive care.	https://dermnetnz.org/topics/contact-dermatitis	f
13	Allergic Dermatitis in Pregnancy	Allergic Dermatitis in Pregnancy is a skin condition caused by an immunologic reaction to external allergens, resulting in red, itchy, and inflamed patches. This condition may develop due to exposure to substances such as fragrances, metals, or certain fabrics, and hormonal changes during pregnancy can heighten skin reactivity. Affected women often experience widespread irritation that can interfere with sleep and daily activities. Management strategies include the avoidance of known allergens, the use of hypoallergenic skincare products, and topical corticosteroids to calm the inflammation. Patients are advised to follow a strict skincare regimen, including regular moisturizing and gentle cleansing. Early consultation with a healthcare provider can help confirm the diagnosis and develop an individualized treatment plan. With appropriate care and allergen avoidance, symptoms generally improve and the skin returns to normal after the pregnancy.	https://dermnetnz.org/topics/allergic-dermatitis	f
14	Gestational Urticaria	Gestational Urticaria is characterized by the sudden appearance of raised, red, and itchy welts on the skin during pregnancy. Often emerging in the later trimesters, the hives may vary in size and can appear anywhere on the body. The condition is thought to result from immune system fluctuations and hormonal changes that occur during pregnancy. Women experiencing gestational urticaria typically report that the welts are transient, appearing and fading over a short period, yet the itching can be intense and disruptive. Treatment usually involves oral antihistamines and, in more severe cases, low-dose corticosteroids, while maintaining a cool environment and avoiding triggers that worsen the reaction. A consistent skincare routine that includes gentle cleansing and regular moisturizing is recommended to help soothe the irritation. Close consultation with a healthcare provider is important to rule out other causes of hives and to ensure the safety of both the mother and the baby.	https://dermnetnz.org/topics/urticaria	t
15	Psoriasis in Pregnancy	Psoriasis in Pregnancy is a chronic inflammatory skin disorder that may be affected by the hormonal and immune changes during gestation. It is characterized by the appearance of thick, scaly plaques on the elbows, knees, scalp, and lower back. During pregnancy, some women may experience an improvement in symptoms, while others might notice a flare-up of their condition. The exact relationship between pregnancy and psoriasis is complex, with factors such as stress, genetics, and immune modulation playing a role. Treatment is carefully tailored to minimize potential risks to the fetus and may include topical treatments, moisturizers, and, in severe cases, light therapy. Patients are advised to follow a gentle skincare routine and avoid irritants that can worsen the plaques. Regular dermatologic monitoring is essential to manage symptoms effectively during pregnancy and to adjust therapies as needed.	https://dermnetnz.org/topics/psoriasis	f
16	Vitiligo during Pregnancy	Vitiligo during Pregnancy is a pigmentary disorder characterized by the loss of melanocytes, resulting in well‐defined white patches on the skin. The condition may become more noticeable during pregnancy due to hormonal fluctuations and increased skin sensitivity. Although vitiligo itself is not harmful, the cosmetic changes can be distressing for some women during an already vulnerable time. Management typically involves the use of topical corticosteroids or calcineurin inhibitors and strict sun protection to prevent further depigmentation. Many patients benefit from counseling and support groups to help cope with the emotional impact of the condition. Regular follow-up with a dermatologist is important to monitor progression and to discuss emerging treatment options. In most cases, the extent of depigmentation remains stable during pregnancy, with some improvement noted postpartum.	https://dermnetnz.org/topics/vitiligo	f
17	Dermatosis Papulosa of Pregnancy	Dermatosis Papulosa of Pregnancy is an uncommon skin disorder that presents as multiple small, raised, and sometimes red papules during pregnancy. These lesions tend to appear on the trunk and limbs, causing mild to moderate itching and discomfort. The underlying mechanism is thought to be linked to hormonal changes and immune system shifts that occur during gestation. Although the condition is benign, the visible nature of the papules can be a source of concern for expectant mothers. Management usually involves the application of topical anti-inflammatory agents and strict skin hygiene. Women are advised to avoid harsh skincare products and to use gentle cleansers along with regular moisturizers. Medical evaluation is recommended to differentiate this condition from other papular eruptions and to establish an appropriate treatment plan. Symptoms typically resolve after delivery, leaving little to no lasting effects on the skin.	https://dermnetnz.org/topics/papular-dermatosis	f
18	Gestational Acne Rosacea	Gestational Acne Rosacea is a variant of facial inflammatory dermatosis seen during pregnancy, characterized by redness, pimple-like lesions, and a burning sensation on the central face. This condition may develop as a result of hormonal fluctuations that increase skin sensitivity and oil production. Lesions often appear around the nose, cheeks, and forehead, and may be accompanied by visible dilated blood vessels. Although it is primarily a cosmetic concern, the discomfort and persistent inflammation can affect daily routines and self-esteem. Management typically includes gentle facial cleansing, avoidance of known triggers, and the use of non-irritating topical agents. In some cases, a dermatologist may recommend topical metronidazole or other agents deemed safe during pregnancy. Patients are encouraged to use broad-spectrum sunscreen and to consult their healthcare provider for a personalized treatment plan. Postpartum improvement is common, although some women may require ongoing care.	https://dermnetnz.org/topics/rosacea	f
19	Hidradenitis Suppurativa in Pregnancy	Hidradenitis Suppurativa in Pregnancy is a chronic inflammatory skin disease that affects the sweat gland–bearing areas, such as the underarms, groin, and buttocks. It is characterized by painful, deep-seated nodules, abscesses, and sinus tracts that can lead to significant scarring. The condition may worsen during pregnancy due to hormonal changes and increased friction in skin folds. Women often experience recurrent flare-ups accompanied by severe pain and discomfort, which can interfere with daily activities. Management includes a combination of topical and systemic antibiotics, anti-inflammatory medications, and in some cases, hormonal therapies that are safe for use during pregnancy. Strict hygiene, warm compresses, and gentle cleansing are recommended to reduce irritation. Early intervention and regular follow-up with a dermatologist are essential to minimize complications and maintain quality of life. Although challenging, the condition is managed with a multidisciplinary approach throughout pregnancy.	https://dermnetnz.org/topics/hidradenitis-suppurativa	t
20	Pityriasis Rosea in Pregnancy	Pityriasis Rosea in Pregnancy is a self-limiting skin condition that typically begins with a single herald patch followed by a generalized rash of smaller lesions. The rash is usually oval, scaly, and distributed along the lines of skin cleavage on the trunk, often causing mild to moderate itching. Although the exact etiology remains unclear, a viral trigger has been suggested in many cases. During pregnancy, the appearance of pityriasis rosea can be particularly concerning due to the overlapping symptoms with other dermatoses. Management is largely supportive, including the use of emollients, mild topical corticosteroids, and oral antihistamines to control itching. Women are encouraged to keep the skin cool and well-moisturized while avoiding harsh skin care products. Regular follow-up with healthcare professionals ensures accurate diagnosis and reassurance that the condition is benign and typically resolves postpartum.	https://dermnetnz.org/topics/pityriasis-rosea	f
21	Lichen Nitidus of Pregnancy	Lichen Nitidus of Pregnancy is a rare dermatosis that manifests as tiny, skin-colored or slightly reddish papules, often grouped together on the chest, abdomen, or limbs. The lesions are usually asymptomatic or only mildly pruritic, though some women may report slight discomfort or irritation. The condition is thought to be benign and may be related to immune system changes that occur during pregnancy. Although its appearance can be alarming, lichen nitidus is typically self-limited and does not lead to scarring. Management is usually conservative, focusing on symptomatic relief with emollients and, if needed, low-potency topical steroids. Patients are advised to avoid any harsh skincare products that could exacerbate the condition. A thorough examination by a dermatologist is recommended to rule out other papular eruptions and to confirm the diagnosis. The lesions often resolve spontaneously postpartum with no lasting effects.	https://dermnetnz.org/topics/lichen-nitidus	f
22	Erythema Annulare in Pregnancy	Erythema Annulare in Pregnancy is characterized by the appearance of ring-shaped, red lesions that often expand outward with central clearing. This distinctive pattern can cause mild to moderate itching and is thought to be associated with the hormonal and immunologic shifts of pregnancy. The lesions may appear on the limbs or trunk and can sometimes be mistaken for other annular dermatoses. Management typically focuses on symptomatic relief using topical corticosteroids and antihistamines to reduce inflammation and itching. Maintaining a cool environment and using soothing moisturizers can also be beneficial in controlling discomfort. Regular follow-up with a healthcare provider is advised to monitor the condition and ensure that no secondary infection develops. Although the rash can be visually striking, it is generally self-limited and improves following delivery with appropriate care.	https://dermnetnz.org/topics/annular-erythema	f
23	Erythema Multiforme in Pregnancy	Erythema Multiforme in Pregnancy is an acute, immune-mediated condition marked by the sudden appearance of target-like lesions with concentric rings of color change. Often triggered by infections or medications, the condition presents with a central dark area, surrounded by a pale ring and an outer red ring. Affected women may experience a burning sensation, mild to moderate itching, and sometimes systemic symptoms such as fever. Because the appearance of these lesions can mimic other more serious conditions, prompt evaluation by a dermatologist is essential. Treatment usually involves supportive care, including cool compresses, topical steroids, and antihistamines to relieve discomfort. Patients are advised to avoid known triggers and to maintain gentle skincare routines. With early diagnosis and proper management, erythema multiforme typically resolves without complications, although careful monitoring is recommended during pregnancy.	https://dermnetnz.org/topics/erythema-multiforme	t
24	Seborrheic Dermatitis in Pregnancy	Seborrheic Dermatitis in Pregnancy is a chronic inflammatory skin condition that often affects areas rich in sebaceous glands such as the scalp, face, and upper chest. It is characterized by greasy, yellowish scales, redness, and mild itching. Hormonal changes during pregnancy can exacerbate the condition, making it more noticeable and sometimes more uncomfortable. Management typically involves the use of medicated shampoos, antifungal creams, and gentle cleansing routines to control scaling and inflammation. Women are advised to use non-irritating, fragrance-free products and to avoid over-washing the skin, which can worsen dryness and irritation. Regular follow-up with a dermatologist helps to tailor the treatment and to monitor the skin’s response over time. Although seborrheic dermatitis is chronic, its symptoms can often be managed effectively during pregnancy with appropriate care.	https://dermnetnz.org/topics/seborrheic-dermatitis	f
25	Dyshidrotic Eczema in Pregnancy	Dyshidrotic Eczema in Pregnancy is characterized by the sudden onset of small, fluid-filled blisters that appear on the palms, soles, and sometimes the sides of the fingers. These lesions are extremely pruritic and can cause discomfort as well as difficulty with daily tasks. The exact cause is unclear, but it may be related to sweating, stress, or hormonal changes during pregnancy. Management involves the use of cool compresses, emollients, and topical steroids to reduce inflammation and itching. Patients are encouraged to avoid triggers such as excessive heat and moisture, and to keep the affected areas dry and clean. Close consultation with a healthcare provider is recommended to confirm the diagnosis and to adjust treatment protocols as needed. Although dyshidrotic eczema can be quite distressing during pregnancy, most cases improve postpartum with proper management.	https://dermnetnz.org/topics/dyshidrotic-eczema	f
26	Granuloma Annulare in Pregnancy	Granuloma Annulare in Pregnancy is a benign inflammatory condition that presents as ring-shaped or arciform lesions with a smooth border. These lesions are typically skin-colored or slightly reddish and are most commonly found on the hands, feet, or lower legs. The condition is thought to be linked to alterations in immune function during pregnancy, although its precise cause remains unknown. Affected women may notice mild itching or irritation around the lesions, though many remain asymptomatic. Management is usually conservative, with topical steroids and emollients used to reduce any discomfort. Patients are advised to follow a gentle skincare routine and to avoid any known irritants that might worsen the appearance of the lesions. Regular follow-up with a dermatologist can help monitor changes over time, and most lesions resolve or improve after delivery.	https://dermnetnz.org/topics/granuloma-annulare	f
27	Acne Mechanica in Pregnancy	Acne Mechanica in Pregnancy is an acne variant that results from physical factors such as friction, pressure, or heat in addition to hormonal changes. It is characterized by inflamed papules and pustules, often found on areas subjected to repeated friction such as under the chin or on the back. Women may notice that their acne worsens with tight clothing, prolonged exercise, or use of occlusive skincare products. Management includes avoiding excessive friction, using non-comedogenic products, and applying gentle cleansing routines. Topical treatments, including mild retinoids and antibiotics, may be used when deemed safe by a healthcare provider during pregnancy. Patients are encouraged to adopt lifestyle modifications and to maintain a balanced skincare regimen. While this type of acne can be distressing, most cases improve postpartum with proper care and adjustments.	https://dermnetnz.org/topics/acne	f
28	Folliculitis Decalvans in Pregnancy	Folliculitis Decalvans in Pregnancy is a rare inflammatory condition that affects hair follicles, leading to painful pustules, crusting, and sometimes scarring alopecia on the scalp. The condition is thought to be triggered by bacterial infection compounded by the immune and hormonal changes during pregnancy. Patients typically experience persistent itching, burning, and tenderness in affected areas, which may cause significant discomfort. Treatment generally involves long-term topical and/or systemic antibiotics to control the infection, as well as anti-inflammatory medications to reduce discomfort. Gentle scalp care and avoidance of irritants are also recommended to minimize further damage. Close dermatologic monitoring is essential to manage symptoms and to prevent permanent hair loss. Although challenging, early and aggressive treatment often results in significant improvement, and symptoms may stabilize or improve after delivery.	https://dermnetnz.org/topics/folliculitis-decalvans	t
43	Miliaria in Pregnancy	Miliaria in Pregnancy is a heat-induced skin condition caused by the blockage of sweat ducts, resulting in small, red, and sometimes itchy bumps. This condition typically occurs in areas where skin friction and moisture are prevalent, such as the neck, chest, and back. Hormonal changes during pregnancy can increase sweating and skin sensitivity, making women more susceptible to miliaria. Management is primarily supportive and includes cooling measures, wearing loose-fitting clothing, and using gentle skin cleansers to reduce sweat buildup. In addition, the use of lightweight moisturizers can help soothe the skin and prevent further irritation. Patients are advised to avoid excessive heat and to stay well-hydrated during periods of high temperature. While miliaria is generally self-limited, these measures can help alleviate symptoms until the condition resolves, often postpartum.	https://dermnetnz.org/topics/miliaria	f
29	Rosacea Pregnancy Variant	Rosacea Pregnancy Variant is a form of rosacea that can be exacerbated by the hormonal fluctuations experienced during pregnancy. It typically presents as persistent facial redness, visible blood vessels, and papulopustular lesions, especially on the cheeks, nose, and forehead. Patients often report a burning sensation and increased sensitivity to triggers such as heat, spicy foods, or stress. Management strategies include the use of gentle, fragrance-free skincare products, sun protection, and topical metronidazole or azelaic acid as appropriate. Women are advised to avoid known irritants and to follow a strict regimen to minimize flare-ups. Regular follow-up with a dermatologist is essential to tailor the treatment plan and to monitor any changes throughout the pregnancy. In many cases, symptoms improve postpartum, although maintenance therapy may be required for long-term management.	https://dermnetnz.org/topics/rosacea	f
30	Bacterial Folliculitis in Pregnancy	Bacterial Folliculitis in Pregnancy is an infection of the hair follicles that leads to the formation of small, pus-filled bumps accompanied by redness and tenderness. This condition is often triggered by the overgrowth of bacteria in areas where the skin is moist or irritated. During pregnancy, changes in the immune system may increase susceptibility to such infections. Affected women typically experience localized itching and discomfort, and the lesions may sometimes coalesce into larger inflamed areas. Management includes the use of appropriate topical or oral antibiotics, along with proper hygiene and the avoidance of occlusive skin products. Patients are encouraged to keep the affected areas clean and dry to prevent further bacterial proliferation. Close monitoring by a healthcare provider is important to ensure that the infection responds to treatment and to avoid complications.	https://dermnetnz.org/topics/folliculitis	t
31	Viral Exanthem of Pregnancy	Viral Exanthem of Pregnancy is a generalized rash that occurs as a reaction to a viral infection during pregnancy. It typically presents with widespread, red maculopapular lesions accompanied by mild itching and occasional systemic symptoms such as low-grade fever or malaise. The rash is believed to be a hypersensitivity reaction to viral antigens, with the hormonal changes of pregnancy possibly exacerbating the skin’s response. Treatment is generally supportive, including the use of cool compresses, gentle cleansing, and emollients to relieve discomfort. Antiviral medications may be considered if an active viral infection is identified, while antihistamines can help manage itching. Women are advised to maintain adequate hydration and rest, and to follow up with their healthcare provider to monitor both the rash and any underlying infection. In most cases, the exanthem resolves as the viral illness subsides.	https://dermnetnz.org/topics/viral-exanthem	f
32	Parapsoriasis in Pregnancy	Parapsoriasis in Pregnancy is a chronic skin condition that presents as scaly, erythematous patches, often resembling psoriasis in appearance. The lesions may appear on the trunk, arms, or legs and are usually accompanied by mild itching and discomfort. Although the exact cause remains unclear, immune system changes during pregnancy are thought to play a role in its development. Management typically involves topical corticosteroids, emollients, and sometimes phototherapy, all chosen with safety in mind during pregnancy. Patients are advised to follow a gentle skincare routine and avoid any known irritants that may exacerbate the condition. Regular follow-up with a dermatologist is essential to monitor the progression of the skin lesions and adjust treatment as needed. In many cases, the condition remains stable throughout the pregnancy and improves after delivery.	https://dermnetnz.org/topics/parapsoriasis	f
33	Cutaneous Lupus Erythematosus in Pregnancy	Cutaneous Lupus Erythematosus in Pregnancy is an autoimmune condition that primarily affects the skin, often manifesting as photosensitive red, scaly patches on sun-exposed areas. The condition may be exacerbated during pregnancy due to hormonal influences and immune system modulation. Affected women may experience burning, itching, and discomfort, especially after exposure to sunlight. Management involves strict sun protection measures, including high-SPF sunscreen and protective clothing, along with the use of topical corticosteroids or calcineurin inhibitors. A gentle skincare routine and avoidance of triggers are essential for symptom control. Close collaboration between dermatologists and obstetricians is crucial to ensure both maternal and fetal safety while managing the disease. Although cutaneous lupus can be challenging, many patients see an improvement in symptoms postpartum with appropriate treatment.	https://dermnetnz.org/topics/lupus-erythematosus	t
34	Dermatomyositis in Pregnancy	Dermatomyositis in Pregnancy is a rare inflammatory condition that affects both the skin and muscles. It is characterized by a distinctive heliotrope rash around the eyes, red papules over the knuckles, and varying degrees of muscle weakness. The exact pathogenesis is not fully understood, but the condition is believed to be mediated by an autoimmune response that may be influenced by pregnancy-related hormonal changes. Patients typically experience burning, tenderness, and difficulty with muscle movements along with the visible skin changes. Management requires a careful balance between treating inflammation with safe medications – such as low-dose corticosteroids – and minimizing potential risks to the fetus. A multidisciplinary approach involving dermatologists and rheumatologists is essential. With early diagnosis and tailored therapy, many women experience improvement in symptoms postpartum, though long-term follow-up may be required.	https://dermnetnz.org/topics/dermatomyositis	t
35	Urticarial Vasculitis in Pregnancy	Urticarial Vasculitis in Pregnancy is an uncommon condition that presents with persistent, red, and raised wheals that last longer than typical hives. It is thought to result from an immune complex–mediated process that leads to inflammation of the small blood vessels in the skin. Patients often report a burning sensation along with the persistent itching that distinguishes it from ordinary urticaria. Treatment typically involves systemic antihistamines and, in some cases, low-dose corticosteroids to control the inflammatory response. A careful evaluation is necessary to rule out systemic involvement and to ensure that the treatment regimen is safe during pregnancy. A gentle skincare routine and avoidance of known triggers are also recommended. With proper management and regular follow-up, symptoms usually subside after delivery, although some cases may require ongoing monitoring.	https://dermnetnz.org/topics/urticarial-vasculitis	t
36	Erythema Nodosum in Pregnancy	Erythema Nodosum in Pregnancy is characterized by the sudden onset of tender, red nodules, most commonly on the shins. This condition is thought to be a hypersensitivity reaction that can be triggered by infections, medications, or systemic inflammatory conditions, and it may be influenced by the hormonal changes during pregnancy. Patients typically experience significant pain and discomfort in the affected areas, which can interfere with walking and daily activities. Management includes the use of non-steroidal anti-inflammatory drugs, rest, and compression stockings to alleviate symptoms. A careful diagnostic workup is necessary to rule out underlying causes and to ensure appropriate treatment. Maintaining a cool environment and elevating the legs can help reduce inflammation. Although erythema nodosum is self-limited, close monitoring during pregnancy is recommended to ensure a favorable outcome.	https://dermnetnz.org/topics/erythema-nodosum	t
37	Prurigo Nodularis in Pregnancy	Prurigo Nodularis in Pregnancy is a chronic skin condition characterized by the formation of firm, itchy nodules as a result of repetitive scratching and inflammation. These nodules typically appear on the arms and legs and can cause significant discomfort. The condition may be exacerbated by the hormonal fluctuations of pregnancy, which can increase skin sensitivity and itching. Management usually involves a combination of high-potency topical steroids, oral antihistamines, and measures to reduce scratching. Patients are advised to keep the skin well-moisturized and to use gentle cleansing routines to minimize irritation. Close consultation with a dermatologist is important to tailor therapy and monitor for potential complications. Although prurigo nodularis can be persistent, many patients experience a reduction in symptoms postpartum with proper care.	https://dermnetnz.org/topics/prurigo-nodularis	f
38	Pityriasis Rubra Pilaris in Pregnancy	Pityriasis Rubra Pilaris in Pregnancy is an uncommon chronic skin disorder that manifests as orange-red scaling patches with well-demarcated borders and areas of normal skin in between. This condition may be accompanied by intense itching and discomfort, affecting daily activities and self-esteem. Its exact cause is not fully understood, but hormonal and immunologic changes during pregnancy are thought to contribute to its development. Management typically involves topical corticosteroids, emollients, and in some cases, systemic therapies that are safe for use during pregnancy. Patients are advised to maintain a consistent skincare regimen and to avoid harsh chemicals that might aggravate the condition further. Regular dermatologic follow-up is essential to monitor the progression and adjust treatment protocols as necessary. In many cases, symptoms improve after delivery, although some women may require long-term management.	https://dermnetnz.org/topics/pityriasis-rubra-pilaris	t
39	Eosinophilic Folliculitis in Pregnancy	Eosinophilic Folliculitis in Pregnancy is a rare inflammatory condition characterized by the appearance of itchy, red papules and pustules centered on hair follicles. The condition is believed to be mediated by an eosinophilic immune response that may be triggered or exacerbated by the hormonal changes during pregnancy. Patients often report persistent itching and discomfort, with lesions typically appearing on the upper body, including the face and trunk. Management includes the use of topical corticosteroids and antihistamines to control inflammation and itching, along with gentle cleansing routines. In severe cases, systemic therapy may be considered under close medical supervision. Regular follow-up with a dermatologist is important to monitor the response to treatment and to adjust the regimen as needed. With proper care, the condition generally improves postpartum, leaving minimal residual effects.	https://dermnetnz.org/topics/eosinophilic-folliculitis	f
40	Reactive Granulomatous Dermatitis in Pregnancy	Reactive Granulomatous Dermatitis in Pregnancy is an inflammatory condition characterized by firm, red nodules or plaques that develop as a reaction to systemic inflammation. The lesions are typically localized and may cause mild to moderate itching or tenderness. Hormonal changes during pregnancy are thought to modify the immune response, thereby contributing to the development of this condition. Management includes topical or systemic anti-inflammatory treatments such as corticosteroids and may involve additional immunomodulatory agents if necessary. Patients are advised to adhere to a gentle skincare routine and to avoid triggers that can exacerbate the inflammation. Close collaboration with healthcare providers ensures that any underlying systemic issues are addressed while safely managing the skin symptoms. Often, with appropriate treatment, the condition gradually resolves after delivery, although some patients may require long-term monitoring.	https://dermnetnz.org/topics/granulomatous-dermatitis	t
41	Pseudolymphomatous Dermatitis of Pregnancy	Pseudolymphomatous Dermatitis of Pregnancy is a rare skin disorder that mimics the appearance of lymphoid infiltrates by presenting as clusters of small, red to violaceous papules. This condition is believed to be a benign reactive process, likely influenced by the immunologic and hormonal changes during pregnancy. Patients may experience mild itching and a burning sensation in the affected areas, which are most commonly located on the trunk and extremities. Management generally involves topical corticosteroids and careful skin care to reduce inflammation and discomfort. A definitive diagnosis often requires histopathological evaluation to distinguish it from true lymphoproliferative disorders. Regular follow-up with a dermatologist is essential to monitor the condition and to ensure that any changes are promptly addressed. Fortunately, the lesions often resolve or markedly improve following delivery.	https://dermnetnz.org/topics/pseudolymphomatous-dermatitis	f
42	Lichen Simplex Chronicus in Pregnancy	Lichen Simplex Chronicus in Pregnancy is a skin disorder characterized by thickened, scaly patches resulting from chronic scratching or rubbing. These lesions often appear on the arms, legs, or neck and are associated with intense itching and discomfort. The condition may be exacerbated during pregnancy due to increased skin sensitivity and stress. Management involves breaking the itch-scratch cycle through the use of high-potency topical steroids, emollients, and behavior modification techniques. Patients are encouraged to adopt gentle skincare practices and to avoid any known irritants that may worsen the condition. Close monitoring by a dermatologist is important to assess treatment efficacy and to prevent secondary infection. With appropriate care, symptoms often improve postpartum, although some cases may require long-term management.	https://dermnetnz.org/topics/lichen-simplex-chronicus	f
44	Scabies in Pregnancy	Scabies in Pregnancy is caused by infestation with the mite Sarcoptes scabiei, leading to intense itching, particularly at night, and the formation of small, red burrows in the skin. The condition often affects the web spaces of the fingers, wrists, and other intertriginous areas. During pregnancy, the diagnosis can be challenging due to the increased sensitivity of the skin and the presence of other dermatoses. Management requires the use of scabicidal treatments that are safe for both mother and fetus, along with strict hygiene measures to prevent re-infestation. Patients are advised to wash all bedding and clothing in hot water and to treat close contacts simultaneously. Early diagnosis and treatment are essential to alleviate symptoms and to avoid secondary bacterial infections. With appropriate therapy and careful follow-up, scabies can be effectively managed during pregnancy.	https://dermnetnz.org/topics/scabies	t
45	Dermatophytosis in Pregnancy	Dermatophytosis in Pregnancy refers to fungal infections of the skin, commonly known as ringworm, which present as circular, scaly, and itchy patches with a clear center. Hormonal and immune changes during pregnancy can predispose women to these superficial infections, particularly in warm and moist areas of the body. Affected patients often notice mild to moderate itching and discomfort around the margins of the lesions. Management involves the use of topical antifungal creams and strict hygiene practices to reduce moisture and friction on the skin. Patients are advised to keep the affected areas clean and dry, and to avoid sharing personal items that could spread the infection. Regular follow-up is recommended to ensure resolution of the infection and to prevent recurrences. While dermatophytosis is generally not serious, prompt treatment is important to avoid secondary bacterial infections and to maintain skin integrity.	https://dermnetnz.org/topics/dermatophytosis	f
46	Folliculitis in Pregnancy	Folliculitis in Pregnancy is an inflammation of the hair follicles that results in small, red bumps or pustules, often accompanied by mild itching and tenderness. The condition may occur due to bacterial colonization or irritation from occlusive clothing and hormonal changes that affect the skin’s natural barrier. Affected women are advised to maintain proper hygiene, use gentle cleansers, and avoid tight-fitting garments that may contribute to friction and irritation. Topical antibiotics or antiseptics are commonly prescribed to control the infection, and supportive measures such as warm compresses can provide symptomatic relief. Regular follow-up with a healthcare provider is recommended to ensure that the condition does not progress or lead to more extensive skin involvement. Overall, with appropriate management, folliculitis during pregnancy is typically a mild condition that resolves without long-term complications.	https://dermnetnz.org/topics/folliculitis	f
47	Perioral Dermatitis in Pregnancy	Perioral Dermatitis in Pregnancy is characterized by a red, bumpy rash that typically appears around the mouth, chin, and sometimes the eyes. The condition may be exacerbated by the use of heavy facial creams, hormonal changes, and increased skin sensitivity during pregnancy. Affected women often experience burning and stinging sensations along with persistent itching in the affected areas. Management includes discontinuing the use of potential irritants, adopting a gentle skincare routine, and applying topical antibiotics or metronidazole to reduce inflammation. Patients are advised to avoid steroid creams unless prescribed, as these can sometimes worsen the condition. Early intervention and dermatologist consultation are key to controlling symptoms and preventing further skin irritation. In most cases, perioral dermatitis improves with appropriate treatment and typically resolves after the pregnancy.	https://dermnetnz.org/topics/perioral-dermatitis	f
48	Nummular Eczema in Pregnancy	Nummular Eczema in Pregnancy is a chronic inflammatory skin disorder characterized by coin-shaped, itchy patches that are red and scaly. These lesions can appear on various parts of the body and are often exacerbated by dryness, stress, and the hormonal fluctuations of pregnancy. Patients typically experience persistent itching and discomfort, which can lead to secondary infections if the skin is repeatedly scratched. Management includes the use of high-quality emollients, topical corticosteroids, and avoidance of known triggers such as harsh soaps and environmental irritants. A consistent and gentle skincare regimen is essential to soothe the skin and reduce flare-ups. Regular follow-up with a dermatologist is recommended to adjust treatment as needed and to ensure that the skin remains well-moisturized and protected. With proper care, many women see significant improvement in their symptoms postpartum.	https://dermnetnz.org/topics/eczema	f
49	Actinic Keratosis in Pregnancy	Actinic Keratosis in Pregnancy is an uncommon condition for this age group but can occur due to significant sun exposure and hormonal changes that affect skin repair mechanisms. It is characterized by rough, scaly patches on sun-exposed areas of the skin, such as the face, ears, and hands. Although these lesions are typically considered precancerous in the general population, their management in pregnancy requires special consideration to ensure fetal safety. Treatment options are limited during pregnancy; hence, the focus is on sun protection, gentle exfoliation, and close monitoring by a dermatologist. Patients are advised to avoid direct sunlight and to use broad-spectrum sunscreen along with protective clothing. Regular skin examinations help in early detection and management, ensuring that any changes are promptly addressed. In most cases, actinic keratosis is managed conservatively during pregnancy with definitive treatment deferred until after delivery.	https://dermnetnz.org/topics/actinic-keratosis	f
50	Sebaceous Hyperplasia in Pregnancy	Sebaceous Hyperplasia in Pregnancy is a benign condition characterized by small, yellowish papules that appear on the face due to the enlargement of sebaceous glands. Hormonal fluctuations during pregnancy can stimulate these glands, resulting in the development of multiple, soft bumps that are usually asymptomatic but may be cosmetically concerning. The lesions are most commonly observed on the forehead, cheeks, and nose. Management is typically conservative, focusing on patient education and gentle skincare routines to minimize irritation. Topical treatments may be recommended if the lesions become inflamed, though invasive procedures are generally postponed until after pregnancy. Regular follow-up with a dermatologist ensures that any changes are monitored and that the condition does not mimic more serious disorders. Overall, sebaceous hyperplasia is a manageable and benign condition during pregnancy that usually improves postpartum.	https://dermnetnz.org/topics/sebaceous-hyperplasia	f
51	Striae Gravidarum	Striae gravidarum, commonly known as stretch marks, are a frequent skin change during pregnancy that result from the rapid stretching of the skin combined with hormonal fluctuations. Typically appearing on the abdomen, breasts, hips, and thighs, these linear, atrophic streaks often begin as reddish or purplish lines and gradually fade to a pale, silvery appearance over time. Although striae gravidarum are benign and primarily a cosmetic concern, they can cause emotional distress for some women during and after pregnancy. Preventative measures such as maintaining optimal skin hydration and managing gradual weight gain may help reduce their severity, though they are not completely preventable. Treatment options, including moisturizers, emollients, and laser therapy (typically postpartum), have variable success. Overall, while these stretch marks are an expected part of the physical changes of pregnancy, they do not usually require medical intervention unless accompanied by other complications.	https://dermnetnz.org/topics/striae-gravidarum	f
1	PUPPP	Pruritic Urticarial Papules and Plaques of Pregnancy (PUPPP) is a skin condition that typically emerges in the later stages of pregnancy. It is characterized by the sudden onset of red, inflamed bumps and patches primarily on the abdomen, thighs, and arms – yet it usually spares the area around the navel. Although its precise cause remains uncertain, many experts believe that the rapid stretching of the skin combined with hormonal changes triggers an inflammatory response. Women with PUPPP often experience intense itching that disrupts sleep and daily activities, although the condition is benign and resolves after childbirth. Standard management includes the use of topical corticosteroids, antihistamines to reduce itching, and a gentle skincare routine with regular moisturizing. Patients are advised to avoid harsh chemicals and abrasive cleansers to prevent further irritation. Regular follow-up with a healthcare provider is recommended to rule out other dermatoses and ensure proper treatment. Overall, with careful management, PUPPP remains a manageable condition during pregnancy.	https://my.clevelandclinic.org/health/diseases/22374-puppp-rash, https://dermnetnz.org/topics/polymorphic-eruption-of-pregnancy	t
52	Linea Nigra	Linea nigra is a common and harmless skin change that occurs during pregnancy, characterized by a dark vertical line running from the navel down to the pubic area. This line can sometimes extend above the navel. It is thought to result from hormonal changes that increase melanin production, leading to hyperpigmentation along the midline of the abdomen. Linea nigra often appears around the second trimester, though the timing can vary among individuals. While it usually fades on its own after childbirth, some women may notice that it persists for several months postpartum. No specific treatment is required, but maintaining a gentle skincare routine and using sunscreen can help reduce further pigmentation. If the line appears unusually wide, dark, or is accompanied by other abnormal skin changes, seeking medical evaluation can provide reassurance.	https://dermnetnz.org/topics/linea-nigra, https://americanpregnancy.org/healthy-pregnancy/pregnancy-concerns/pregnancy-line-linea-nigra/	f
53	Striae Gravidarum	"Striae Gravidarum, commonly referred to as stretch marks, are pink, red, or purple streaks that commonly develop on the abdomen, breasts, hips, buttocks, or thighs during pregnancy. "\n                "They typically appear in the later stages of pregnancy when rapid stretching of the skin and hormonal changes affect the dermis. "\n                "Over time, these marks usually fade to a lighter or silvery shade postpartum. "\n                "While they are generally benign and do not cause medical complications, some women may experience mild itching. "\n                "Maintaining skin hydration through lotions or creams may help alleviate dryness or discomfort, though definitive prevention methods remain inconclusive. "\n                "No specific treatment is required, and many women find that the appearance of striae diminishes over time. "\n                "If there is concern about unusual skin changes or severe itching, consulting a healthcare provider can provide reassurance or further guidance."	"https://dermnetnz.org/topics/stretch-marks	f
55	Spider Telangiectasias	Spider telangiectasias, also known as spider angiomas or spider veins, are small, dilated blood vessels visible near the surface of the skin. "\n                "They often appear as tiny red spots with radiating spider-like legs and are commonly found on the face, neck, upper trunk, or arms. "\n                "During pregnancy, increased estrogen levels contribute to their development, making them more prevalent. "\n                "While usually harmless and painless, some women may experience mild itching or notice them for cosmetic reasons. "\n                "They may fade or become less noticeable after childbirth as hormone levels return to normal. "\n                "No specific treatment is necessary unless they cause significant discomfort or concern, in which case medical therapies such as laser treatment or sclerotherapy may be considered. "\n                "If there is an unusually large number of spider telangiectasias or other worrisome skin changes, consulting a healthcare provider is recommended.	https://dermnetnz.org/topics/spider-naevus	f
54	Spider Palmar Erythema	Spider Palmar Erythema, commonly referred to simply as Palmar Erythema, is characterized by a reddish discoloration of the palms. \n                During pregnancy, elevated estrogen levels can increase blood flow to the skin, causing the palms to appear warm and flushed. \n                It often presents symmetrically on both hands and may become more pronounced when pressure is applied or during times of increased body temperature, such as with exercise or hot weather. \n                Most cases are benign and typically resolve after childbirth as hormone levels return to pre-pregnancy states. \n                While usually harmless, persistent redness or associated symptoms (such as severe itching) may warrant medical evaluation to exclude other underlying conditions.	https://dermnetnz.org/topics/palmar-erythema	f
\.


--
-- Data for Name: story; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.story (id, name, text, created_at, like_count, fk_story_user_id) FROM stdin;
3	Maria	During my second trimester, I started noticing an incredibly itchy rash on my belly, arms, and thighs. After talking to my OB-GYN, I discovered it was called Pruritic Urticarial Papules and Plaques of Pregnancy (PUPPP). At first, I felt overwhelmed—I’d never dealt with a rash like this, and being pregnant already made me anxious enough. I tried a few different approaches to get relief: 1) Oatmeal Baths: Soaking in lukewarm water with colloidal oatmeal helped soothe my skin.\n2) Moisturizing Creams: My dermatologist recommended fragrance-free creams to reduce dryness and irritation.\n3) Cool Compresses: Applying a cool, damp cloth on the itchiest spots provided short-term relief.\n\nIt took about three weeks for the rash to calm down significantly, and it was such a relief. Going through this made me realize how important self-care and a supportive medical team can be during pregnancy. I hope my story helps other moms-to-be feel less alone if they encounter similar skin issues.\n\nIf you’re dealing with a severe itch or rash, don’t hesitate to talk to your doctor or a dermatologist. You’re not alone—and there are ways to ease the discomfort so you can focus on the more exciting parts of pregnancy.	2025-02-03 13:34:06.505282	1	1
4	BestMomEver	I recently gave birth and noticed large amounts of hair shedding whenever I brushed or showered.\nWorried and unsure, I turned to MamaSkin to search for possible postpartum hair loss conditions.\nI discovered something called telogen effluvium, which can happen due to hormonal changes.\nReading through MamaSkin’s resources and success stories helped me realize this was a common experience rather than something to panic about.\nArmed with tips on gentle scalp care and proper nutrition, I feel more reassured and confident that my hair will gradually return to normal.	2025-02-03 13:37:28.651755	3	1
\.


--
-- Data for Name: symptom; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.symptom (id, name, condition_id) FROM stdin;
1	Intense itching on the abdomen	1
2	Red papules and plaques observed on the skin	1
3	Tense blister formation on the abdomen and limbs	2
4	Severe itching with burning sensation	2
5	Itchy, raised bumps on the arms and legs	3
6	Localized skin nodules with persistent irritation	3
7	Widespread dry, scaly patches causing discomfort	4
8	Intense itching with red inflamed areas	4
9	Hyperpigmented patches on the face	5
10	Mottled discoloration around the cheeks and forehead	5
11	Pustular lesions on inflamed skin	6
12	Severe itching with blister-like eruptions	6
13	Inflamed acne lesions on the face and back	7
14	Persistent pimples with oily skin exacerbated by hormones	7
15	Red, irritated patches on the torso	8
16	Itching and discomfort on the limbs	8
17	Small, itchy bumps around hair follicles	9
18	Inflammation on the chest and back	9
19	Dry, itchy patches with visible scaling	10
20	Persistent irritation with red inflamed areas	10
21	Purple, flat-topped papules on the wrists	11
22	Itching with fine white lines on lesions	11
23	Localized redness and swelling due to irritants	12
24	Itchy rash in areas of direct contact	12
25	Itchy, red rash triggered by allergens	13
26	Inflamed patches with possible blistering	13
27	Raised, itchy welts that appear suddenly	14
28	Transient hives with intense itching	14
29	Thick, scaly plaques with red borders	15
30	Flare-ups with persistent itching	15
31	Well-demarcated patches of depigmentation	16
32	Mild itching around the affected areas	16
33	Multiple small papules scattered over the skin	17
34	Mild irritation with scattered bumps	17
35	Redness and pimple-like lesions on the central face	18
36	Burning sensation around the nose and cheeks	18
37	Painful lumps and abscesses in underarm and groin	19
38	Recurring nodules with severe inflammation	19
39	Herald patch followed by a generalized scaly rash	20
40	Mild to moderate itching across the torso	20
41	Tiny, flesh-colored papules on the chest	21
42	Slight irritation with clusters of small bumps	21
43	Ring-shaped red lesions on the limbs	22
44	Expanding circular rash with mild itching	22
45	Target-like lesions with concentric color rings	23
46	Burning sensation with mild to moderate itching	23
47	Greasy scales and mild redness on the scalp	24
48	Flaking and discomfort on the face and chest	24
49	Small, fluid-filled blisters on hands and feet	25
50	Severe itching with discomfort in affected areas	25
51	Ring-shaped lesions with smooth borders	26
52	Mild localized itching and inflammation	26
53	Acne lesions exacerbated by friction	27
54	Persistent inflamed pimples on pressure areas	27
55	Painful pustules and crusting on the scalp	28
56	Persistent irritation leading to scarring alopecia	28
57	Facial redness with visible blood vessels	29
58	Burning and sensitivity in central facial areas	29
59	Small pus-filled bumps around hair follicles	30
60	Localized redness and tenderness with signs of infection	30
61	Widespread red maculopapular rash	31
62	Mild itching with diffuse skin irritation	31
63	Scaly patches resembling psoriasis	32
64	Persistent itching with discoloration on the skin	32
65	Photosensitive red, scaly patches on sun-exposed areas	33
66	Burning and itching that worsens with sunlight	33
67	Heliotrope rash around the eyes and red papules on the knuckles	34
68	Muscle weakness accompanied by skin inflammation	34
69	Long-lasting hives with a burning sensation	35
70	Raised, reddish bumps persisting longer than typical hives	35
71	Painful red nodules on the shins	36
72	Tender, inflamed bumps with mild systemic symptoms	36
73	Firm, itchy nodules from chronic scratching	37
74	Localized skin thickening with persistent discomfort	37
75	Orange-red scaling patches with defined borders	38
76	Persistent itching with generalized inflammation	38
77	Itchy red bumps centered on hair follicles	39
78	Small pustules and persistent irritation on the upper body	39
79	Firm red nodules due to inflammatory response	40
80	Localized tenderness with mild itching	40
81	Clusters of red to purple papules resembling lymphoid infiltrates	41
82	Persistent itching with slight burning sensation	41
83	Thickened, scaly patches from chronic scratching	42
84	Severe itching with lichenification on the arms and legs	42
85	Small, red bumps from sweat retention	43
86	Mild irritation in friction-prone areas	43
87	Intense itching with tiny burrows in the skin	44
88	Widespread rash with pimple-like lesions in intertriginous areas	44
89	Ring-shaped scaly rash with a clear center	45
90	Itching and mild inflammation along the lesion edges	45
91	Red, tender bumps around hair follicles	46
92	Occasional pustule formation with mild itching	46
93	Red, bumpy rash around the mouth	47
94	Persistent irritation and mild burning near the chin	47
95	Coin-shaped, itchy patches with defined borders	48
96	Persistent scaling and irritation on affected areas	48
97	Rough, scaly patches on sun-exposed skin	49
98	Mild irritation with a rough texture	49
99	Small yellowish papules on the face	50
100	Mild irritation with a shiny appearance in affected areas	50
101	Noticeable linear red or purple streaks on the abdomen and hips	51
102	Mild itching and skin tightness over stretch mark areas	51
103	Dark vertical line on the abdomen	52
104	Reddish or pinkish streaks on the abdomen or thighs	53
105	Silvery or white lines remaining after childbirth	53
106	Tiny red spots with radiating blood vessels	55
107	Visible spider-like veins commonly on the face or neck	55
108	Mild itching	55
109	Reddish discoloration of the palms	54
110	Warmth or flushing in the hands	54
111	Discoloration becomes more pronounced with pressure or heat	54
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, google_id, name, email) FROM stdin;
1	google-1234	Maria	maria@gmail.com
2	google-2345	Kate	kate@gmail.com
3	google-3456	Ivanka	ivanka@gmail.com
\.


--
-- Name: condition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.condition_id_seq', 55, true);


--
-- Name: story_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.story_id_seq', 4, true);


--
-- Name: symptom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.symptom_id_seq', 111, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: condition condition_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.condition
    ADD CONSTRAINT condition_pkey PRIMARY KEY (id);


--
-- Name: story story_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story
    ADD CONSTRAINT story_pkey PRIMARY KEY (id);


--
-- Name: symptom symptom_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.symptom
    ADD CONSTRAINT symptom_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_google_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_google_id_key UNIQUE (google_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: story story_fk_story_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story
    ADD CONSTRAINT story_fk_story_user_id_fkey FOREIGN KEY (fk_story_user_id) REFERENCES public.users(id);


--
-- Name: symptom symptom_condition_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.symptom
    ADD CONSTRAINT symptom_condition_id_fkey FOREIGN KEY (condition_id) REFERENCES public.condition(id);


--
-- PostgreSQL database dump complete
--

