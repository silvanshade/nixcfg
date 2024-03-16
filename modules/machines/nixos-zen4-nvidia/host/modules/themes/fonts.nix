{ inputs, pkgs, ... }:

{
  fonts.enableDefaultPackages = true;

  fonts.enableGhostscriptFonts = true;

  fonts.fontconfig = {
    enable = true;
    allowBitmaps = true;
    antialias = true;
    cache32Bit = true;
    hinting = {
      enable = true;
      autohint = false;
      style = "slight";
    };
    subpixel = {
      lcdfilter = "default";
      rgba = "rgb";
    };
    useEmbeddedBitmaps = true;
  };

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "PragmataPro Mono Liga"
      "FiraCode Nerd Font"
    ];
    sansSerif = [
      "Fira Sans"
    ];
    serif = [
      "Roboto Slab"
    ];
  };

  fonts.packages = with pkgs; [
    andika
    ankacoder
    anonymousPro
    azeret-mono
    bakoma_ttf
    behdad-fonts
    brill
    bront_fonts
    cantarell-fonts
    cascadia-code
    ccsymbols
    charis-sil
    cm_unicode
    corefonts
    cozette
    culmus
    dejavu_fonts
    dosemu_fonts
    dotcolon-fonts
    doulos-sil
    emacs-all-the-icons-fonts
    eurofurence
    fira-code-nerdfont
    font-awesome
    freefont_ttf
    google-fonts
    gyre-fonts
    hannom
    helvetica-neue-lt-std
    hubot-sans
    ibm-plex
    inconsolata-nerdfont
    input-fonts
    inriafonts
    iosevka
    ipaexfont
    ipafont
    ir-standard-fonts
    joypixels
    kacst
    khmeros
    kochi-substitute
    # NOTE: causes build to freeze?
    # kochi-substitute-naga10
    kreative-square-fonts
    lalezar-fonts
    league-of-moveable-type
    lohit-fonts.assamese
    lohit-fonts.bengali
    lohit-fonts.devanagari
    lohit-fonts.gujarati
    lohit-fonts.gurmukhi
    lohit-fonts.kannada
    lohit-fonts.kashmiri
    lohit-fonts.konkani
    lohit-fonts.maithili
    lohit-fonts.malayalam
    lohit-fonts.marathi
    lohit-fonts.nepali
    lohit-fonts.odia
    lohit-fonts.sindhi
    lohit-fonts.tamil
    lohit-fonts.tamil-classical
    lohit-fonts.telugu
    liberation-sans-narrow
    liberation_ttf
    libertine
    libertinus
    libre-bodoni
    libre-caslon
    line-awesome
    migmix
    migu
    mona-sans
    monaspace
    mplus-outline-fonts.osdnRelease
    nahid-fonts
    nanoemoji
    nerdfonts
    newcomputermodern
    nika-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    noto-fonts-emoji-blob-bin
    noto-fonts-lgc-plus
    open-fonts
    open-sans
    orbitron
    oxygenfonts
    powerline-fonts
    inputs.self.packages.${pkgs.system}.pragmata-pro
    proggyfonts
    redhat-official-fonts
    roboto
    roboto-mono
    roboto-serif
    rubik
    sahel-fonts
    samim-fonts
    sarabun-font
    shabnam-fonts
    spleen
    stix-otf
    stix-two
    swaycons
    takao
    tamzen
    terminus-nerdfont
    textfonts
    tlwg
    ttf-tw-moe
    # typodermic-free-fonts # FIXME: broken link
    typodermic-public-domain
    ucs-fonts
    ultimate-oldschool-pc-font-pack
    unfonts-core
    unscii
    uw-ttyp0
    wineWow64Packages.fonts
    xits-math
    vazir-fonts
    vdrsymbols
    vistafonts
    vistafonts-chs
    zilla-slab
  ];
}
