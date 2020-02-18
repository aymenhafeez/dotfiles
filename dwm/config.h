/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 19;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "TerminessTTF Nerd Font Mono:size=12" };
static const char dmenufont[]       = { "TerminessTTF Nerd Font Mono:size=12" };
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "vlc",      NULL,       NULL,       0,            1,           -1 },
	{ "Spotify",  NULL,       NULL,       1 << 8,       1,           -1 },
	{NULL,        NULL,       "mutt",     1 << 7,       0,           -1 },
	{NULL,        NULL,       "ranger",   0,            1,           -1 },
	{NULL,        NULL,       "htop",     0,            1,           -1 },
	{NULL,        NULL,       "Pcmanfm",  0,            1,           -1 },
	{NULL,        NULL,       "mc",       0,            1,           -1 },
	{NULL,        NULL,       "sxiv",     0,            1,           -1 },
};

/* grid of tags */
#define DRAWCLASSICTAGS             1 << 0
#define DRAWTAGGRID                 1 << 1

#define SWITCHTAG_UP                1 << 0
#define SWITCHTAG_DOWN              1 << 1
#define SWITCHTAG_LEFT              1 << 2
#define SWITCHTAG_RIGHT             1 << 3
#define SWITCHTAG_TOGGLETAG         1 << 4
#define SWITCHTAG_TAG               1 << 5
#define SWITCHTAG_VIEW              1 << 6
#define SWITCHTAG_TOGGLEVIEW        1 << 7

static const unsigned int drawtagmask = DRAWTAGGRID; /* | DRAWCLASSICTAGS to show classic row of tags */
static const int tagrows = 1;

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

/* static const Layout layouts[] = { */
/* 	/1* symbol     arrange function *1/ */
/* 	{ "[]=",      tile },    /1* first entry is default *1/ */
/* 	{ "><>",      NULL },    /1* no layout function means floating behavior *1/ */
/* 	{ "[M]",      monocle }, */
/* }; */

#include "fibonacci.c"
#include "gaplessgrid.c"
static const Layout layouts[] = {
	/* symbol               function */
	{ "[]=",  tile }, /* first entry is default */
	{ "><>",  NULL },
	{ "[M]",  monocle },
	{ "[@]",  spiral },
	{ "[\\]", dwindle },
    { "|M|",  centeredmaster },
    { ">M>",  centeredfloatingmaster },
    { "###",  gaplessgrid },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, "-b" };
static const char *termcmd[]  = { "urxvt", NULL };

/* #include <X11/XF86keysym.h> */
#include "movestack.c"
#include "nextprevtag.c"
static Key keys[] = {
	/* modifier                     key                    function        argument */
    { MODKEY|ControlMask,           XK_k,                  switchtag,      { .ui = SWITCHTAG_UP    | SWITCHTAG_VIEW } },
	{ MODKEY|ControlMask,           XK_j,                  switchtag,      { .ui = SWITCHTAG_DOWN  | SWITCHTAG_VIEW } },
	{ MODKEY|ControlMask,           XK_l,                  switchtag,      { .ui = SWITCHTAG_RIGHT | SWITCHTAG_VIEW } },
	{ MODKEY|ControlMask,           XK_h,                  switchtag,      { .ui = SWITCHTAG_LEFT  | SWITCHTAG_VIEW } },
	/* { MODKEY|Mod1Mask,              XK_k,                  switchtag,      { .ui = SWITCHTAG_UP    | SWITCHTAG_TAG | SWITCHTAG_VIEW } }, */
	/* { MODKEY|Mod1Mask,              XK_j,                  switchtag,      { .ui = SWITCHTAG_DOWN  | SWITCHTAG_TAG | SWITCHTAG_VIEW } }, */
	{ MODKEY|Mod1Mask,              XK_n,                  switchtag,      { .ui = SWITCHTAG_RIGHT | SWITCHTAG_TAG | SWITCHTAG_VIEW } },
	{ MODKEY|Mod1Mask,              XK_p,                  switchtag,      { .ui = SWITCHTAG_LEFT  | SWITCHTAG_TAG | SWITCHTAG_VIEW } },
    { MODKEY|ShiftMask,             XK_j,                  movestack,      {.i = +1 } },
    { MODKEY|ShiftMask,             XK_k,                  movestack,      {.i = -1 } },
    { MODKEY,                       XK_n,                  view_adjacent,  { .i = +1 } },
	{ MODKEY,                       XK_p,                  view_adjacent,  { .i = -1 } },
	{ MODKEY,                       XK_Return,             spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_d,                  spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_b,                  togglebar,      {0} },
	{ MODKEY,                       XK_j,                  focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,                  focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_i,                  incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_d,                  incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,                  setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,                  setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return,             zoom,           {0} },
	{ MODKEY,                       XK_Tab,                view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,                  killclient,     {0} },
	{ MODKEY|Mod1Mask,              XK_t,                  setlayout,      {.v = &layouts[0]} },
	{ MODKEY|Mod1Mask,              XK_f,                  setlayout,      {.v = &layouts[1]} },
	{ MODKEY|Mod1Mask,              XK_m,                  setlayout,      {.v = &layouts[2]} },
	{ MODKEY|Mod1Mask,              XK_s,                  setlayout,      {.v = &layouts[3]} },
	{ MODKEY|Mod1Mask,              XK_d,                  setlayout,      {.v = &layouts[4]} },
	{ MODKEY|Mod1Mask,              XK_c,                  setlayout,      {.v = &layouts[5]} },
	{ MODKEY|Mod1Mask,              XK_space,              setlayout,      {.v = &layouts[6]} },
	{ MODKEY|Mod1Mask,              XK_g,                  setlayout,      {.v = &layouts[7]} },
	{ MODKEY,                       XK_space,              setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,              togglefloating, {0} },
	/* { MODKEY|Mod1Mask,              XK_m,                  togglewin,      {0} }, */
	{ MODKEY,                       XK_0,                  view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,                  tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,              focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period,             focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,              tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,             tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                                  0)
	TAGKEYS(                        XK_2,                                  1)
	TAGKEYS(                        XK_3,                                  2)
	TAGKEYS(                        XK_4,                                  3)
	TAGKEYS(                        XK_5,                                  4)
	TAGKEYS(                        XK_6,                                  5)
	TAGKEYS(                        XK_7,                                  6)
	TAGKEYS(                        XK_8,                                  7)
	TAGKEYS(                        XK_9,                                  8)
	{ MODKEY|ShiftMask|ControlMask, XK_x,                  quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
    { ClkWinTitle,          0,              Button1,        togglewin,      {0} },
	/* { ClkWinTitle,          0,              Button3,        showhide, {0} }, */
};

