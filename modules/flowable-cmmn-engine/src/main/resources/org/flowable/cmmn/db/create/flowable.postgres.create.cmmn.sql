CREATE TABLE ACT_CMMN_DEPLOYMENT
(
    ID_                   VARCHAR(255) NOT NULL,
    NAME_                 VARCHAR(255),
    CATEGORY_             VARCHAR(255),
    KEY_                  VARCHAR(255),
    DEPLOY_TIME_          TIMESTAMP WITHOUT TIME ZONE,
    PARENT_DEPLOYMENT_ID_ VARCHAR(255),
    TENANT_ID_            VARCHAR(255) DEFAULT '',
    CONSTRAINT "ACT_CMMN_DEPLOYMENT_pkey" PRIMARY KEY (ID_)
);

CREATE TABLE ACT_CMMN_DEPLOYMENT_RESOURCE
(
    ID_             VARCHAR(255) NOT NULL,
    NAME_           VARCHAR(255),
    DEPLOYMENT_ID_  VARCHAR(255),
    RESOURCE_BYTES_ BYTEA,
    GENERATED_ BOOLEAN,
    CONSTRAINT PK_CMMN_DEPLOYMENT_RESOURCE PRIMARY KEY (ID_)
);

ALTER TABLE ACT_CMMN_DEPLOYMENT_RESOURCE
    ADD CONSTRAINT ACT_FK_CMMN_RSRC_DPL FOREIGN KEY (DEPLOYMENT_ID_) REFERENCES ACT_CMMN_DEPLOYMENT (ID_);

CREATE INDEX ACT_IDX_CMMN_RSRC_DPL ON ACT_CMMN_DEPLOYMENT_RESOURCE (DEPLOYMENT_ID_);

CREATE TABLE ACT_CMMN_CASEDEF
(
    ID_                     VARCHAR(255) NOT NULL,
    REV_                    INTEGER      NOT NULL,
    NAME_                   VARCHAR(255),
    KEY_                    VARCHAR(255) NOT NULL,
    VERSION_                INTEGER      NOT NULL,
    CATEGORY_               VARCHAR(255),
    DEPLOYMENT_ID_          VARCHAR(255),
    RESOURCE_NAME_          VARCHAR(4000),
    DESCRIPTION_            VARCHAR(4000),
    HAS_GRAPHICAL_NOTATION_ BOOLEAN,
    DGRM_RESOURCE_NAME_ VARCHAR(4000),
    HAS_START_FORM_KEY_ BOOLEAN,
    TENANT_ID_              VARCHAR(255) DEFAULT '',
    CONSTRAINT "ACT_CMMN_CASEDEF_pkey" PRIMARY KEY (ID_)
);

ALTER TABLE ACT_CMMN_CASEDEF
    ADD CONSTRAINT ACT_FK_CASE_DEF_DPLY FOREIGN KEY (DEPLOYMENT_ID_) REFERENCES ACT_CMMN_DEPLOYMENT (ID_);
CREATE INDEX ACT_IDX_CASE_DEF_DPLY ON ACT_CMMN_CASEDEF (DEPLOYMENT_ID_);

CREATE UNIQUE INDEX ACT_IDX_CASE_DEF_UNIQ ON ACT_CMMN_CASEDEF (KEY_, VERSION_, TENANT_ID_);

CREATE TABLE ACT_CMMN_RU_CASE_INST
(
    ID_                        VARCHAR(255) NOT NULL,
    REV_                       INTEGER      NOT NULL,
    BUSINESS_KEY_              VARCHAR(255),
    NAME_                      VARCHAR(255),
    PARENT_ID_                 VARCHAR(255),
    CASE_DEF_ID_               VARCHAR(255),
    STATE_                     VARCHAR(255),
    START_TIME_                TIMESTAMP WITHOUT TIME ZONE,
    START_USER_ID_             VARCHAR(255),
    CALLBACK_ID_               VARCHAR(255),
    CALLBACK_TYPE_             VARCHAR(255),
    LOCK_TIME_                 TIMESTAMP WITHOUT TIME ZONE,
    LOCK_OWNER_                VARCHAR(255),
    IS_COMPLETEABLE_           BOOLEAN,
    REFERENCE_ID_              VARCHAR(255),
    REFERENCE_TYPE_            VARCHAR(255),
    LAST_REACTIVATION_TIME_    TIMESTAMP(3) WITHOUT TIME ZONE,
    LAST_REACTIVATION_USER_ID_ VARCHAR(255),
    BUSINESS_STATUS_           VARCHAR(255),
    TENANT_ID_                 VARCHAR(255) DEFAULT '',
    CONSTRAINT "ACT_CMMN_RU_CASE_INST_pkey" PRIMARY KEY (ID_)
);

ALTER TABLE ACT_CMMN_RU_CASE_INST
    ADD CONSTRAINT ACT_FK_CASE_INST_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_);

CREATE INDEX ACT_IDX_CASE_INST_CASE_DEF ON ACT_CMMN_RU_CASE_INST (CASE_DEF_ID_);
CREATE INDEX ACT_IDX_CASE_INST_PARENT ON ACT_CMMN_RU_CASE_INST (PARENT_ID_);
CREATE INDEX ACT_IDX_CASE_INST_REF_ID_ ON ACT_CMMN_RU_CASE_INST (REFERENCE_ID_);

CREATE TABLE ACT_CMMN_RU_PLAN_ITEM_INST
(
    ID_                     VARCHAR(255) NOT NULL,
    REV_                    INTEGER      NOT NULL,
    CASE_DEF_ID_            VARCHAR(255),
    CASE_INST_ID_           VARCHAR(255),
    STAGE_INST_ID_          VARCHAR(255),
    IS_STAGE_               BOOLEAN,
    ELEMENT_ID_             VARCHAR(255),
    NAME_                   VARCHAR(255),
    STATE_                  VARCHAR(255),
    CREATE_TIME_            TIMESTAMP WITHOUT TIME ZONE,
    START_USER_ID_          VARCHAR(255),
    REFERENCE_ID_           VARCHAR(255),
    REFERENCE_TYPE_         VARCHAR(255),
    ITEM_DEFINITION_ID_     VARCHAR(255),
    ITEM_DEFINITION_TYPE_   VARCHAR(255),
    IS_COMPLETEABLE_        BOOLEAN,
    IS_COUNT_ENABLED_       BOOLEAN,
    VAR_COUNT_              INTEGER,
    SENTRY_PART_INST_COUNT_ INTEGER,
    LAST_AVAILABLE_TIME_    TIMESTAMP(3) WITHOUT TIME ZONE,
    LAST_ENABLED_TIME_      TIMESTAMP(3) WITHOUT TIME ZONE,
    LAST_DISABLED_TIME_     TIMESTAMP(3) WITHOUT TIME ZONE,
    LAST_STARTED_TIME_      TIMESTAMP(3) WITHOUT TIME ZONE,
    LAST_SUSPENDED_TIME_    TIMESTAMP(3) WITHOUT TIME ZONE,
    COMPLETED_TIME_         TIMESTAMP(3) WITHOUT TIME ZONE,
    OCCURRED_TIME_          TIMESTAMP(3) WITHOUT TIME ZONE,
    TERMINATED_TIME_        TIMESTAMP(3) WITHOUT TIME ZONE,
    EXIT_TIME_              TIMESTAMP(3) WITHOUT TIME ZONE,
    ENDED_TIME_             TIMESTAMP(3) WITHOUT TIME ZONE,
    ENTRY_CRITERION_ID_     VARCHAR(255),
    EXIT_CRITERION_ID_      VARCHAR(255),
    EXTRA_VALUE_            VARCHAR(255),
    DERIVED_CASE_DEF_ID_    VARCHAR(255),
    LAST_UNAVAILABLE_TIME_  TIMESTAMP(3) WITHOUT TIME ZONE,
    TENANT_ID_              VARCHAR(255) DEFAULT '',
    CONSTRAINT PK_CMMN_PLAN_ITEM_INST PRIMARY KEY (ID_)
);

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST
    ADD CONSTRAINT ACT_FK_PLAN_ITEM_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_);
CREATE INDEX ACT_IDX_PLAN_ITEM_CASE_DEF ON ACT_CMMN_RU_PLAN_ITEM_INST (CASE_DEF_ID_);

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST
    ADD CONSTRAINT ACT_FK_PLAN_ITEM_CASE_INST FOREIGN KEY (CASE_INST_ID_) REFERENCES ACT_CMMN_RU_CASE_INST (ID_);
CREATE INDEX ACT_IDX_PLAN_ITEM_CASE_INST ON ACT_CMMN_RU_PLAN_ITEM_INST (CASE_INST_ID_);

CREATE INDEX ACT_IDX_PLAN_ITEM_STAGE_INST ON ACT_CMMN_RU_PLAN_ITEM_INST (STAGE_INST_ID_);

CREATE TABLE ACT_CMMN_RU_SENTRY_PART_INST
(
    ID_                VARCHAR(255) NOT NULL,
    REV_               INTEGER      NOT NULL,
    CASE_DEF_ID_       VARCHAR(255),
    CASE_INST_ID_      VARCHAR(255),
    PLAN_ITEM_INST_ID_ VARCHAR(255),
    ON_PART_ID_        VARCHAR(255),
    IF_PART_ID_        VARCHAR(255),
    TIME_STAMP_        TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT PK_CMMN_SENTRY_PART_INST PRIMARY KEY (ID_)
);

ALTER TABLE ACT_CMMN_RU_SENTRY_PART_INST
    ADD CONSTRAINT ACT_FK_SENTRY_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_);
CREATE INDEX ACT_IDX_SENTRY_CASE_DEF ON ACT_CMMN_RU_SENTRY_PART_INST (CASE_DEF_ID_);

ALTER TABLE ACT_CMMN_RU_SENTRY_PART_INST
    ADD CONSTRAINT ACT_FK_SENTRY_CASE_INST FOREIGN KEY (CASE_INST_ID_) REFERENCES ACT_CMMN_RU_CASE_INST (ID_);
CREATE INDEX ACT_IDX_SENTRY_CASE_INST ON ACT_CMMN_RU_SENTRY_PART_INST (CASE_INST_ID_);

ALTER TABLE ACT_CMMN_RU_SENTRY_PART_INST
    ADD CONSTRAINT ACT_FK_SENTRY_PLAN_ITEM FOREIGN KEY (PLAN_ITEM_INST_ID_) REFERENCES ACT_CMMN_RU_PLAN_ITEM_INST (ID_);
CREATE INDEX ACT_IDX_SENTRY_PLAN_ITEM ON ACT_CMMN_RU_SENTRY_PART_INST (PLAN_ITEM_INST_ID_);

CREATE TABLE ACT_CMMN_RU_MIL_INST
(
    ID_           VARCHAR(255)                NOT NULL,
    NAME_         VARCHAR(255)                NOT NULL,
    TIME_STAMP_   TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CASE_INST_ID_ VARCHAR(255)                NOT NULL,
    CASE_DEF_ID_  VARCHAR(255)                NOT NULL,
    ELEMENT_ID_   VARCHAR(255)                NOT NULL,
    TENANT_ID_    VARCHAR(255) DEFAULT '',
    CONSTRAINT "ACT_CMMN_RU_MIL_INST_pkey" PRIMARY KEY (ID_)
);

ALTER TABLE ACT_CMMN_RU_MIL_INST
    ADD CONSTRAINT ACT_FK_MIL_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_);
CREATE INDEX ACT_IDX_MIL_CASE_DEF ON ACT_CMMN_RU_MIL_INST (CASE_DEF_ID_);

ALTER TABLE ACT_CMMN_RU_MIL_INST
    ADD CONSTRAINT ACT_FK_MIL_CASE_INST FOREIGN KEY (CASE_INST_ID_) REFERENCES ACT_CMMN_RU_CASE_INST (ID_);
CREATE INDEX ACT_IDX_MIL_CASE_INST ON ACT_CMMN_RU_MIL_INST (CASE_INST_ID_);

CREATE TABLE ACT_CMMN_HI_CASE_INST
(
    ID_                        VARCHAR(255) NOT NULL,
    REV_                       INTEGER      NOT NULL,
    BUSINESS_KEY_              VARCHAR(255),
    NAME_                      VARCHAR(255),
    PARENT_ID_                 VARCHAR(255),
    CASE_DEF_ID_               VARCHAR(255),
    STATE_                     VARCHAR(255),
    START_TIME_                TIMESTAMP WITHOUT TIME ZONE,
    END_TIME_                  TIMESTAMP WITHOUT TIME ZONE,
    START_USER_ID_             VARCHAR(255),
    CALLBACK_ID_               VARCHAR(255),
    CALLBACK_TYPE_             VARCHAR(255),
    REFERENCE_ID_              VARCHAR(255),
    REFERENCE_TYPE_            VARCHAR(255),
    LAST_REACTIVATION_TIME_    TIMESTAMP(3) WITHOUT TIME ZONE,
    LAST_REACTIVATION_USER_ID_ VARCHAR(255),
    BUSINESS_STATUS_           VARCHAR(255),
    TENANT_ID_                 VARCHAR(255) DEFAULT '',
    CONSTRAINT "ACT_CMMN_HI_CASE_INST_pkey" PRIMARY KEY (ID_)
);

CREATE INDEX ACT_IDX_HI_CASE_INST_END ON ACT_CMMN_HI_CASE_INST (END_TIME_);

CREATE TABLE ACT_CMMN_HI_MIL_INST
(
    ID_           VARCHAR(255)                NOT NULL,
    REV_          INTEGER                     NOT NULL,
    NAME_         VARCHAR(255)                NOT NULL,
    TIME_STAMP_   TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CASE_INST_ID_ VARCHAR(255)                NOT NULL,
    CASE_DEF_ID_  VARCHAR(255)                NOT NULL,
    ELEMENT_ID_   VARCHAR(255)                NOT NULL,
    TENANT_ID_    VARCHAR(255) DEFAULT '',
    CONSTRAINT "ACT_CMMN_HI_MIL_INST_pkey" PRIMARY KEY (ID_)
);

CREATE TABLE ACT_CMMN_HI_PLAN_ITEM_INST
(
    ID_                    VARCHAR(255) NOT NULL,
    REV_                   INTEGER      NOT NULL,
    NAME_                  VARCHAR(255),
    STATE_                 VARCHAR(255),
    CASE_DEF_ID_           VARCHAR(255),
    CASE_INST_ID_          VARCHAR(255),
    STAGE_INST_ID_         VARCHAR(255),
    IS_STAGE_              BOOLEAN,
    ELEMENT_ID_            VARCHAR(255),
    ITEM_DEFINITION_ID_    VARCHAR(255),
    ITEM_DEFINITION_TYPE_  VARCHAR(255),
    CREATE_TIME_           TIMESTAMP WITHOUT TIME ZONE,
    LAST_AVAILABLE_TIME_   TIMESTAMP WITHOUT TIME ZONE,
    LAST_ENABLED_TIME_     TIMESTAMP WITHOUT TIME ZONE,
    LAST_DISABLED_TIME_    TIMESTAMP WITHOUT TIME ZONE,
    LAST_STARTED_TIME_     TIMESTAMP WITHOUT TIME ZONE,
    LAST_SUSPENDED_TIME_   TIMESTAMP WITHOUT TIME ZONE,
    COMPLETED_TIME_        TIMESTAMP WITHOUT TIME ZONE,
    OCCURRED_TIME_         TIMESTAMP WITHOUT TIME ZONE,
    TERMINATED_TIME_       TIMESTAMP WITHOUT TIME ZONE,
    EXIT_TIME_             TIMESTAMP WITHOUT TIME ZONE,
    ENDED_TIME_            TIMESTAMP WITHOUT TIME ZONE,
    LAST_UPDATED_TIME_     TIMESTAMP WITHOUT TIME ZONE,
    START_USER_ID_         VARCHAR(255),
    REFERENCE_ID_          VARCHAR(255),
    REFERENCE_TYPE_        VARCHAR(255),
    ENTRY_CRITERION_ID_    VARCHAR(255),
    EXIT_CRITERION_ID_     VARCHAR(255),
    SHOW_IN_OVERVIEW_      BOOLEAN,
    EXTRA_VALUE_           VARCHAR(255),
    DERIVED_CASE_DEF_ID_   VARCHAR(255),
    LAST_UNAVAILABLE_TIME_ TIMESTAMP(3) WITHOUT TIME ZONE,
    TENANT_ID_             VARCHAR(255) DEFAULT '',
    CONSTRAINT "ACT_CMMN_HI_PLAN_ITEM_INST_pkey" PRIMARY KEY (ID_)
);

CREATE INDEX ACT_IDX_HI_PLAN_ITEM_INST_CASE ON ACT_CMMN_HI_PLAN_ITEM_INST (CASE_INST_ID_);

insert into ACT_GE_PROPERTY
values ('cmmn.schema.version', '7.1.0.1', 1);
