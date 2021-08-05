/*==============================================================*/
/* Nom de SGBD :  PostgreSQL 8                                  */
/* Date de cr?ation :  05/08/2021 15:34:02                      */
/*==============================================================*/


drop table IF EXISTS COPROD CASCADE;

drop table IF EXISTS DOMAINS CASCADE;

drop table IF EXISTS ELEMENTS CASCADE;

drop table IF EXISTS FBS_ITEM CASCADE;

drop table IF EXISTS FBS_RECORD CASCADE;

drop table IF EXISTS FBS_TREE CASCADE;

drop table IF EXISTS FLAGS CASCADE;

drop table IF EXISTS HS_ITEM CASCADE;

drop table IF EXISTS IS_MAPPED CASCADE;

drop table IF EXISTS SUA_ITEMS CASCADE;

drop table IF EXISTS SUA_RECORDS CASCADE;

drop table IF EXISTS SUA_TREE CASCADE;

drop table IF EXISTS TRADE_RECORD CASCADE;

drop table IF EXISTS YEARS CASCADE;

/*==============================================================*/
/* Table : COPROD                                               */
/*==============================================================*/
create table COPROD (
   ITEM_CPC             CHAR(10)             not null,
   SUA_ITEM_CPC         CHAR(10)             not null,
   COMMENT              TEXT                 null,
   constraint PK_COPROD primary key (ITEM_CPC, SUA_ITEM_CPC)
);

/*==============================================================*/
/* Table : DOMAINS                                              */
/*==============================================================*/
create table DOMAINS (
   DOMAIN_CODE          CHAR(3)              not null,
   DOMAIN_DESCRIPTION   VARCHAR(255)         null,
   constraint PK_DOMAINS primary key (DOMAIN_CODE)
);

/*==============================================================*/
/* Table : ELEMENTS                                             */
/*==============================================================*/
create table ELEMENTS (
   ELEMENT_CODE         CHAR(4)              not null,
   ELEMENT_DESCRIPTION  VARCHAR(255)         null,
   UNIT                 VARCHAR(50)          null,
   constraint PK_ELEMENTS primary key (ELEMENT_CODE)
);

/*==============================================================*/
/* Table : FBS_ITEM                                             */
/*==============================================================*/
create table FBS_ITEM (
   FBS_CODE             CHAR(4)              not null,
   FBS_DESCRIPTION      VARCHAR(255)         null,
   constraint PK_FBS_ITEM primary key (FBS_CODE)
);

/*==============================================================*/
/* Table : FBS_RECORD                                           */
/*==============================================================*/
create table FBS_RECORD (
   FBS_RECORD_ID        SERIAL               not null,
   FBS_CODE             CHAR(4)              not null,
   DOMAIN_CODE          CHAR(3)              not null,
   ELEMENT_CODE         CHAR(4)              not null,
   YEAR_CODE            CHAR(4)              not null,
   FLAG_CODE            CHAR(1)              not null,
   QUATITY              FLOAT8               null,
   constraint PK_FBS_RECORD primary key (FBS_RECORD_ID)
);

/*==============================================================*/
/* Table : FBS_TREE                                             */
/*==============================================================*/
create table FBS_TREE (
   FBS_CODE             CHAR(4)              not null,
   FBS_FBS_CODE         CHAR(4)              not null,
   LEVEL                INT4                 null,
   constraint PK_FBS_TREE primary key (FBS_CODE, FBS_FBS_CODE)
);

/*==============================================================*/
/* Table : FLAGS                                                */
/*==============================================================*/
create table FLAGS (
   FLAG_DESCRIPTION     VARCHAR(255)         null,
   FLAG_CODE            CHAR(1)              not null,
   constraint PK_FLAGS primary key (FLAG_CODE)
);

/*==============================================================*/
/* Table : HS_ITEM                                              */
/*==============================================================*/
create table HS_ITEM (
   HS_CODE              VARCHAR(10)          not null,
   HS_DESCRIPTION       VARCHAR(255)         null,
   constraint PK_HS_ITEM primary key (HS_CODE)
);

/*==============================================================*/
/* Table : IS_MAPPED                                            */
/*==============================================================*/
create table IS_MAPPED (
   ITEM_CPC             CHAR(10)             not null,
   HS_CODE              VARCHAR(10)          not null,
   constraint PK_IS_MAPPED primary key (ITEM_CPC, HS_CODE)
);

/*==============================================================*/
/* Table : SUA_ITEMS                                            */
/*==============================================================*/
create table SUA_ITEMS (
   ITEM_CPC             CHAR(10)             not null,
   FBS_CODE             CHAR(4)              not null,
   ITEM_NAME            VARCHAR(255)         null,
   ITEM_DESCRIPTION     VARCHAR(255)         null,
   constraint PK_SUA_ITEMS primary key (ITEM_CPC)
);

/*==============================================================*/
/* Table : SUA_RECORDS                                          */
/*==============================================================*/
create table SUA_RECORDS (
   SEQ_ID               SERIAL               not null,
   ITEM_CPC             CHAR(10)             not null,
   YEAR_CODE            CHAR(4)              not null,
   ELEMENT_CODE         CHAR(4)              not null,
   DOMAIN_CODE          CHAR(3)              not null,
   FLAG_CODE            CHAR(1)              not null,
   QUATITY              FLOAT8               null,
   SOURCE               TEXT                 null,
   PRECISION            VARCHAR(1)           null,
   COMMENTS             TEXT                 null,
   constraint PK_SUA_RECORDS primary key (SEQ_ID)
);

/*==============================================================*/
/* Table : SUA_TREE                                             */
/*==============================================================*/
create table SUA_TREE (
   ITEM_CPC             CHAR(10)             not null,
   SUA_ITEM_CPC         CHAR(10)             not null,
   ELEMENT_CODE         CHAR(4)              not null,
   FLAG_CODE            CHAR(1)              not null,
   QUATITY              FLOAT8               null,
   FLAG                 CHAR(1)              null,
   constraint PK_SUA_TREE primary key (ITEM_CPC, SUA_ITEM_CPC, ELEMENT_CODE, FLAG_CODE)
);

/*==============================================================*/
/* Table : TRADE_RECORD                                         */
/*==============================================================*/
create table TRADE_RECORD (
   SED_ID               SERIAL               not null,
   HS_CODE              VARCHAR(10)          not null,
   YEAR_CODE            CHAR(4)              not null,
   ELEMENT_CODE         CHAR(4)              not null,
   FLAG_CODE            CHAR(1)              not null,
   QUATITY              FLOAT8               null,
   VALUE                FLOAT8               null,
   constraint PK_TRADE_RECORD primary key (SED_ID)
);

/*==============================================================*/
/* Table : YEARS                                                */
/*==============================================================*/
create table YEARS (
   YEAR_CODE            CHAR(4)              not null,
   YEAR_DESCRIPTION     CHAR(4)              null,
   constraint PK_YEARS primary key (YEAR_CODE)
);

alter table COPROD
   add constraint FK_COPROD_COPROD_SUA_ITEM foreign key (SUA_ITEM_CPC)
      references SUA_ITEMS (ITEM_CPC)
      on delete restrict on update restrict;

alter table COPROD
   add constraint FK_COPROD_COPROD2_SUA_ITEM foreign key (ITEM_CPC)
      references SUA_ITEMS (ITEM_CPC)
      on delete restrict on update restrict;

alter table FBS_RECORD
   add constraint FK_FBS_RECO_HAS_FBS_D_DOMAINS foreign key (DOMAIN_CODE)
      references DOMAINS (DOMAIN_CODE)
      on delete restrict on update restrict;

alter table FBS_RECORD
   add constraint FK_FBS_RECO_HAS_FBS_E_ELEMENTS foreign key (ELEMENT_CODE)
      references ELEMENTS (ELEMENT_CODE)
      on delete restrict on update restrict;

alter table FBS_RECORD
   add constraint FK_FBS_RECO_HAS_FBS_F_FLAGS foreign key (FLAG_CODE)
      references FLAGS (FLAG_CODE)
      on delete restrict on update restrict;

alter table FBS_RECORD
   add constraint FK_FBS_RECO_HAS_FBS_I_FBS_ITEM foreign key (FBS_CODE)
      references FBS_ITEM (FBS_CODE)
      on delete restrict on update restrict;

alter table FBS_RECORD
   add constraint FK_FBS_RECO_HAS_FBS_Y_YEARS foreign key (YEAR_CODE)
      references YEARS (YEAR_CODE)
      on delete restrict on update restrict;

alter table FBS_TREE
   add constraint FK_FBS_TREE_FBS_TREE_FBS_ITEM foreign key (FBS_FBS_CODE)
      references FBS_ITEM (FBS_CODE)
      on delete restrict on update restrict;

alter table FBS_TREE
   add constraint FK_FBS_TREE_FBS_TREE2_FBS_ITEM foreign key (FBS_CODE)
      references FBS_ITEM (FBS_CODE)
      on delete restrict on update restrict;

alter table IS_MAPPED
   add constraint FK_IS_MAPPE_IS_MAPPED_HS_ITEM foreign key (HS_CODE)
      references HS_ITEM (HS_CODE)
      on delete restrict on update restrict;

alter table IS_MAPPED
   add constraint FK_IS_MAPPE_IS_MAPPED_SUA_ITEM foreign key (ITEM_CPC)
      references SUA_ITEMS (ITEM_CPC)
      on delete restrict on update restrict;

alter table SUA_ITEMS
   add constraint FK_SUA_ITEM_BELONGS_FBS_ITEM foreign key (FBS_CODE)
      references FBS_ITEM (FBS_CODE)
      on delete restrict on update restrict;

alter table SUA_RECORDS
   add constraint FK_SUA_RECO_HAS_SUA_E_ELEMENTS foreign key (ELEMENT_CODE)
      references ELEMENTS (ELEMENT_CODE)
      on delete restrict on update restrict;

alter table SUA_RECORDS
   add constraint FK_SUA_RECO_HAS_SUA_F_FLAGS foreign key (FLAG_CODE)
      references FLAGS (FLAG_CODE)
      on delete restrict on update restrict;

alter table SUA_RECORDS
   add constraint FK_SUA_RECO_HAS_SUA_I_SUA_ITEM foreign key (ITEM_CPC)
      references SUA_ITEMS (ITEM_CPC)
      on delete restrict on update restrict;

alter table SUA_RECORDS
   add constraint FK_SUA_RECO_HAS_YEAR_YEARS foreign key (YEAR_CODE)
      references YEARS (YEAR_CODE)
      on delete restrict on update restrict;

alter table SUA_RECORDS
   add constraint FK_SUA_RECO_SUA_DOMAI_DOMAINS foreign key (DOMAIN_CODE)
      references DOMAINS (DOMAIN_CODE)
      on delete restrict on update restrict;

alter table SUA_TREE
   add constraint FK_SUA_TREE_SUA_TREE_FLAGS foreign key (FLAG_CODE)
      references FLAGS (FLAG_CODE)
      on delete restrict on update restrict;

alter table SUA_TREE
   add constraint FK_SUA_TREE_SUA_TREE2_SUA_ITEM foreign key (ITEM_CPC)
      references SUA_ITEMS (ITEM_CPC)
      on delete restrict on update restrict;

alter table SUA_TREE
   add constraint FK_SUA_TREE_SUA_TREE3_SUA_ITEM foreign key (SUA_ITEM_CPC)
      references SUA_ITEMS (ITEM_CPC)
      on delete restrict on update restrict;

alter table SUA_TREE
   add constraint FK_SUA_TREE_SUA_TREE4_ELEMENTS foreign key (ELEMENT_CODE)
      references ELEMENTS (ELEMENT_CODE)
      on delete restrict on update restrict;

alter table TRADE_RECORD
   add constraint FK_TRADE_RE_ASSOCIATI_YEARS foreign key (YEAR_CODE)
      references YEARS (YEAR_CODE)
      on delete restrict on update restrict;

alter table TRADE_RECORD
   add constraint FK_TRADE_RE_ASSOCIATI_ELEMENTS foreign key (ELEMENT_CODE)
      references ELEMENTS (ELEMENT_CODE)
      on delete restrict on update restrict;

alter table TRADE_RECORD
   add constraint FK_TRADE_RE_HAS_HS_HS_ITEM foreign key (HS_CODE)
      references HS_ITEM (HS_CODE)
      on delete restrict on update restrict;

alter table TRADE_RECORD
   add constraint FK_TRADE_RE_HAS_TRADE_FLAGS foreign key (FLAG_CODE)
      references FLAGS (FLAG_CODE)
      on delete restrict on update restrict;

