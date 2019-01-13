<p>;;; markdown-mode.el --- Major mode for Markdown-formatted text -*- lexical-binding: t; -*-</p>

<p>;; Copyright (C) 2007-2017 Jason R. Blevins and markdown-mode<br />
;; contributors (see the commit log for details).</p>

<p>;; Author: Jason R. Blevins &lt;jblevins@xbeta.org&gt;<br />
;; Maintainer: Jason R. Blevins &lt;jblevins@xbeta.org&gt;<br />
;; Created: May 24, 2007<br />
;; Version: 2.3<br />
;; Package-Requires: ((emacs &quot;24&quot;) (cl-lib &quot;0.5&quot;))<br />
;; Keywords: Markdown, GitHub Flavored Markdown, itex<br />
;; URL: https://jblevins.org/projects/markdown-mode/</p>

<p>;; This file is not part of GNU Emacs.</p>

<p>;; This program is free software; you can redistribute it and/or modify<br />
;; it under the terms of the GNU General Public License as published by<br />
;; the Free Software Foundation, either version 3 of the License, or<br />
;; (at your option) any later version.</p>

<p>;; This program is distributed in the hope that it will be useful,<br />
;; but WITHOUT ANY WARRANTY; without even the implied warranty of<br />
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. &nbsp;See the<br />
;; GNU General Public License for more details.</p>

<p>;; You should have received a copy of the GNU General Public License<br />
;; along with this program. &nbsp;If not, see &lt;http://www.gnu.org/licenses/&gt;.</p>

<p>;;; Commentary:</p>

<p>;; markdown-mode is a major mode for editing [Markdown][]-formatted<br />
;; text. &nbsp;The latest stable version is markdown-mode 2.3, released on<br />
;; August 31, 2017. &nbsp;See the [release notes][] for details.<br />
;; markdown-mode is free software, licensed under the GNU GPL,<br />
;; version 3 or later.</p>

<p>;; ![Markdown Mode Screenshot](https://jblevins.org/projects/markdown-mode/screenshots/20170818-001.png)</p>

<p>;; [Markdown]: http://daringfireball.net/projects/markdown/<br />
;; [release notes]: https://jblevins.org/projects/markdown-mode/rev-2-3</p>

<p>;;; Documentation:</p>

<p>;; &lt;a href=&quot;https://leanpub.com/markdown-mode&quot;&gt;<br />
;; &lt;img src=&quot;https://jblevins.org/projects/markdown-mode/guide-v2.3.png&quot; align=&quot;right&quot; height=&quot;350&quot; width=&quot;231&quot;&gt;<br />
;; &lt;/a&gt;</p>

<p>;; The primary documentation for Markdown Mode is available below, and<br />
;; is generated from comments in the source code. &nbsp;For a more in-depth<br />
;; treatment, the [_Guide to Markdown Mode for Emacs_][guide] covers<br />
;; Markdown syntax, advanced movement and editing in Emacs,<br />
;; extensions, configuration examples, tips and tricks, and a survey<br />
;; of other packages that work with Markdown Mode. &nbsp;Finally, Emacs is<br />
;; also a self-documenting editor. &nbsp;This means that the source code<br />
;; itself contains additional documentation: each function has its own<br />
;; docstring available via `C-h f` (`describe-function&#39;), individual<br />
;; keybindings can be investigated with `C-h k` (`describe-key&#39;), and<br />
;; a complete list of keybindings is available using `C-h m`<br />
;; (`describe-mode&#39;).</p>

<p>;; &nbsp;[guide]: https://leanpub.com/markdown-mode</p>

<p>;;; Installation:</p>

<p>;; _Note:_ To use all of the features of `markdown-mode&#39;, you&#39;ll need<br />
;; to install the Emacs package itself and also have a local Markdown<br />
;; processor installed (e.g., Markdown.pl, MultiMarkdown, or Pandoc).<br />
;; The external processor is not required for editing, but will be<br />
;; used for rendering HTML for preview and export. After installing<br />
;; the Emacs package, be sure to configure `markdown-command&#39; to point<br />
;; to the preferred Markdown executable on your system. &nbsp;See the<br />
;; Customization section below for more details.</p>

<p>;; The recommended way to install `markdown-mode&#39; is to install the package<br />
;; from [MELPA Stable](https://stable.melpa.org/#/markdown-mode)<br />
;; using `package.el&#39;. First, configure `package.el&#39; and the MELPA Stable<br />
;; repository by adding the following to your `.emacs&#39;, `init.el&#39;,<br />
;; or equivalent startup file:</p>

<p>;; ``` Lisp<br />
;; (require &#39;package)<br />
;; (add-to-list &#39;package-archives<br />
;; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;(&quot;melpa-stable&quot; . &quot;https://stable.melpa.org/packages/&quot;))<br />
;; (package-initialize)<br />
;; ```</p>

<p>;; Then, after restarting Emacs or evaluating the above statements, issue<br />
;; the following command: `M-x package-install RET markdown-mode RET`.<br />
;; When installed this way, the major modes `markdown-mode&#39; and `gfm-mode&#39;<br />
;; will be autoloaded and `markdown-mode&#39; will be used for file names<br />
;; ending in either `.md` or `.markdown`.<br />
;;<br />
;; Alternatively, if you manage loading packages with [use-package][]<br />
;; then you can automatically install and configure `markdown-mode&#39; by<br />
;; adding a declaration such as this one to your init file (as an<br />
;; example; adjust settings as desired):<br />
;;<br />
;; ``` Lisp<br />
;; (use-package markdown-mode<br />
;; &nbsp; :ensure t<br />
;; &nbsp; :commands (markdown-mode gfm-mode)<br />
;; &nbsp; :mode ((&quot;README\\.md\\&#39;&quot; . gfm-mode)<br />
;; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(&quot;\\.md\\&#39;&quot; . markdown-mode)<br />
;; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(&quot;\\.markdown\\&#39;&quot; . markdown-mode))<br />
;; &nbsp; :init (setq markdown-command &quot;multimarkdown&quot;))<br />
;; ```</p>

<p>;; [MELPA Stable]: http://stable.melpa.org/<br />
;; [use-package]: https://github.com/jwiegley/use-package</p>

<p>;; **Direct Download**</p>

<p>;; Alternatively you can manually download and install markdown-mode.<br />
;; First, download the [latest stable version][markdown-mode.el] and<br />
;; save the file where Emacs can find it (i.e., a directory in your<br />
;; `load-path&#39;). You can then configure `markdown-mode&#39; and `gfm-mode&#39;<br />
;; to load automatically by adding the following to your init file:</p>

<p>;; ``` Lisp<br />
;; (autoload &#39;markdown-mode &quot;markdown-mode&quot;<br />
;; &nbsp; &nbsp;&quot;Major mode for editing Markdown files&quot; t)<br />
;; (add-to-list &#39;auto-mode-alist &#39;(&quot;\\.markdown\\&#39;&quot; . markdown-mode))<br />
;; (add-to-list &#39;auto-mode-alist &#39;(&quot;\\.md\\&#39;&quot; . markdown-mode))<br />
;;<br />
;; (autoload &#39;gfm-mode &quot;markdown-mode&quot;<br />
;; &nbsp; &nbsp;&quot;Major mode for editing GitHub Flavored Markdown files&quot; t)<br />
;; (add-to-list &#39;auto-mode-alist &#39;(&quot;README\\.md\\&#39;&quot; . gfm-mode))<br />
;; ```</p>

<p>;; [markdown-mode.el]: https://jblevins.org/projects/markdown-mode/markdown-mode.el</p>

<p>;; **Development Version**</p>

<p>;; To follow or contribute to markdown-mode development, you can<br />
;; browse or clone the Git repository<br />
;; [on GitHub](https://github.com/jrblevin/markdown-mode):</p>

<p>;; ```<br />
;; git clone https://github.com/jrblevin/markdown-mode.git<br />
;; ```</p>

<p>;; If you prefer to install and use the development version, which may<br />
;; become unstable at some times, you can either clone the Git<br />
;; repository as above or install markdown-mode from<br />
;; [MELPA](https://melpa.org/#/markdown-mode).<br />
;;<br />
;; If you clone the repository directly, then make sure that Emacs can<br />
;; find it by adding the following line to your startup file:<br />
;;<br />
;; ``` Lisp<br />
;; (add-to-list &#39;load-path &quot;/path/to/markdown-mode/repository&quot;)<br />
;; ```</p>

<p>;; **Packaged Installation**</p>

<p>;; markdown-mode is also available in several package managers. You<br />
;; may want to confirm that the package you install contains the<br />
;; latest stable version first (and please notify the package<br />
;; maintainer if not).<br />
;;<br />
;; &nbsp; &nbsp;* Debian Linux: [elpa-markdown-mode][] and [emacs-goodies-el][]<br />
;; &nbsp; &nbsp;* Ubuntu Linux: [elpa-markdown-mode][elpa-ubuntu] and [emacs-goodies-el][emacs-goodies-el-ubuntu]<br />
;; &nbsp; &nbsp;* RedHat and Fedora Linux: [emacs-goodies][]<br />
;; &nbsp; &nbsp;* NetBSD: [textproc/markdown-mode][]<br />
;; &nbsp; &nbsp;* MacPorts: [markdown-mode.el][macports-package] ([pending][macports-ticket])<br />
;; &nbsp; &nbsp;* FreeBSD: [textproc/markdown-mode.el][freebsd-port]<br />
;;<br />
;; &nbsp;[elpa-markdown-mode]: https://packages.debian.org/sid/lisp/elpa-markdown-mode<br />
;; &nbsp;[elpa-ubuntu]: http://packages.ubuntu.com/search?keywords=elpa-markdown-mode<br />
;; &nbsp;[emacs-goodies-el]: http://packages.debian.org/emacs-goodies-el<br />
;; &nbsp;[emacs-goodies-el-ubuntu]: http://packages.ubuntu.com/search?keywords=emacs-goodies-el<br />
;; &nbsp;[emacs-goodies]: https://apps.fedoraproject.org/packages/emacs-goodies<br />
;; &nbsp;[textproc/markdown-mode]: http://pkgsrc.se/textproc/markdown-mode<br />
;; &nbsp;[macports-package]: https://trac.macports.org/browser/trunk/dports/editors/markdown-mode.el/Portfile<br />
;; &nbsp;[macports-ticket]: http://trac.macports.org/ticket/35716<br />
;; &nbsp;[freebsd-port]: http://svnweb.freebsd.org/ports/head/textproc/markdown-mode.el</p>

<p>;; **Dependencies**</p>

<p>;; To enable editing of code blocks in indirect buffers using `C-c &#39;`,<br />
;; you will need to install the [`edit-indirect&#39;][ei] package.</p>

<p>;; &nbsp; [ei]: https://github.com/Fanael/edit-indirect/</p>

<p>;;; Usage:</p>

<p>;; Keybindings are grouped by prefixes based on their function. &nbsp;For<br />
;; example, the commands for styling text are grouped under `C-c C-s`<br />
;; and toggle commands begin with `C-c C-x`. &nbsp;The primary commands in<br />
;; each group will are described below. &nbsp;You can obtain a list of all<br />
;; keybindings by pressing `C-c C-h`. &nbsp;Movement and shifting commands<br />
;; tend to be associated with paired delimiters such as `M-{` and<br />
;; `M-}` or `C-c &lt;` and `C-c &gt;`. &nbsp;Outline navigation keybindings the<br />
;; same as in `org-mode&#39;. &nbsp;Finally, commands for running Markdown or<br />
;; doing maintenance on an open file are grouped under the `C-c C-c`<br />
;; prefix. &nbsp;The most commonly used commands are described below. You<br />
;; can obtain a list of all keybindings by pressing `C-c C-h`.<br />
;;<br />
;; &nbsp; * Links and Images: `C-c C-l` and `C-c C-i`<br />
;;<br />
;; &nbsp; &nbsp; `C-c C-l` (`markdown-insert-link`) is a general command for<br />
;; &nbsp; &nbsp; inserting new link markup or editing existing link markup. This<br />
;; &nbsp; &nbsp; is especially useful when markup or URL hiding is enabled, so<br />
;; &nbsp; &nbsp; that URLs can&#39;t easily be edited directly. &nbsp;This command can be<br />
;; &nbsp; &nbsp; used to insert links of any form: either inline links,<br />
;; &nbsp; &nbsp; reference links, or plain URLs in angle brackets. &nbsp;The URL or<br />
;; &nbsp; &nbsp; `[reference]` label, link text, and optional title are entered<br />
;; &nbsp; &nbsp; through a series of interactive prompts. &nbsp;The type of link is<br />
;; &nbsp; &nbsp; determined by which values are provided:<br />
;;<br />
;; &nbsp; &nbsp; * &nbsp; If both a URL and link text are given, insert an inline link:<br />
;; &nbsp; &nbsp; &nbsp; &nbsp; `[text](url)`.<br />
;; &nbsp; &nbsp; * &nbsp; If both a `[reference]` label and link text are given, insert<br />
;; &nbsp; &nbsp; &nbsp; &nbsp; a reference link: `[text][reference]`.<br />
;; &nbsp; &nbsp; * &nbsp; If only link text is given, insert an implicit reference link:<br />
;; &nbsp; &nbsp; &nbsp; &nbsp; `[text][]`.<br />
;; &nbsp; &nbsp; * &nbsp; If only a URL is given, insert a plain URL link:<br />
;; &nbsp; &nbsp; &nbsp; &nbsp; `&lt;url&gt;`.<br />
;;<br />
;; &nbsp; &nbsp; Similarly, `C-c C-i` (`markdown-insert-image`) is a general<br />
;; &nbsp; &nbsp; command for inserting or editing image markup. &nbsp;As with the link<br />
;; &nbsp; &nbsp; insertion command, through a series interactive prompts you can<br />
;; &nbsp; &nbsp; insert either an inline or reference image:<br />
;;<br />
;; &nbsp; &nbsp; * &nbsp; If both a URL and alt text are given, insert an inline<br />
;; &nbsp; &nbsp; &nbsp; &nbsp; image: `![alt text](url)`.<br />
;; &nbsp; &nbsp; * &nbsp; If both a `[reference]` label and alt text are given,<br />
;; &nbsp; &nbsp; &nbsp; &nbsp; insert a reference link: `![alt text][reference]`.<br />
;;<br />
;; &nbsp; &nbsp; If there is an existing link or image at the point, these<br />
;; &nbsp; &nbsp; command will edit the existing markup rather than inserting new<br />
;; &nbsp; &nbsp; markup. &nbsp;Otherwise, if there is an active region, these commands<br />
;; &nbsp; &nbsp; use the region as either the default URL (if it seems to be a<br />
;; &nbsp; &nbsp; URL) or link text value otherwise. &nbsp;In that case, the region<br />
;; &nbsp; &nbsp; will be deleted and replaced by the link.<br />
;;<br />
;; &nbsp; &nbsp; Note that these functions can be used to convert links and<br />
;; &nbsp; &nbsp; images from one type to another (inline, reference, or plain<br />
;; &nbsp; &nbsp; URL) by selectively adding or removing properties via the<br />
;; &nbsp; &nbsp; interactive prompts.<br />
;;<br />
;; &nbsp; &nbsp; If a reference label is given that is not yet defined, you<br />
;; &nbsp; &nbsp; will be prompted for the URL and optional title and the<br />
;; &nbsp; &nbsp; reference will be inserted according to the value of<br />
;; &nbsp; &nbsp; `markdown-reference-location&#39;. &nbsp;If a title is given, it will be<br />
;; &nbsp; &nbsp; added to the end of the reference definition and will be used<br />
;; &nbsp; &nbsp; to populate the title attribute when converted to HTML.<br />
;;<br />
;; &nbsp; &nbsp; Local images associated with image links may be displayed<br />
;; &nbsp; &nbsp; inline in the buffer by pressing `C-c C-x C-i`<br />
;; &nbsp; &nbsp; (`markdown-toggle-inline-images&#39;). This is a toggle command, so<br />
;; &nbsp; &nbsp; pressing this once again will remove inline images.<br />
;;<br />
;; &nbsp; * Text Styles: `C-c C-s`<br />
;;<br />
;; &nbsp; &nbsp; `C-c C-s i` inserts markup to make a region or word italic. If<br />
;; &nbsp; &nbsp; there is an active region, make the region italic. &nbsp;If the point<br />
;; &nbsp; &nbsp; is at a non-italic word, make the word italic. &nbsp;If the point is<br />
;; &nbsp; &nbsp; at an italic word or phrase, remove the italic markup.<br />
;; &nbsp; &nbsp; Otherwise, simply insert italic delimiters and place the cursor<br />
;; &nbsp; &nbsp; in between them. &nbsp;Similarly, use `C-c C-s b` for bold, `C-c C-s c`<br />
;; &nbsp; &nbsp; for inline code, and `C-c C-s k` for inserting `&lt;kbd&gt;` tags.<br />
;;<br />
;; &nbsp; &nbsp; `C-c C-s q` inserts a blockquote using the active region, if<br />
;; &nbsp; &nbsp; any, or starts a new blockquote. `C-c C-s Q` is a variation<br />
;; &nbsp; &nbsp; which always operates on the region, regardless of whether it<br />
;; &nbsp; &nbsp; is active or not (i.e., when `transient-mark-mode` is off but<br />
;; &nbsp; &nbsp; the mark is set). &nbsp;The appropriate amount of indentation, if<br />
;; &nbsp; &nbsp; any, is calculated automatically given the surrounding context,<br />
;; &nbsp; &nbsp; but may be adjusted later using the region indentation<br />
;; &nbsp; &nbsp; commands.<br />
;;<br />
;; &nbsp; &nbsp; `C-c C-s p` behaves similarly for inserting preformatted code<br />
;; &nbsp; &nbsp; blocks (with `C-c C-s P` being the region-only counterpart)<br />
;; &nbsp; &nbsp; and `C-c C-s C` inserts a GFM style backquote fenced code block.<br />
;;<br />
;; &nbsp; * Headings: `C-c C-s`<br />
;;<br />
;; &nbsp; &nbsp; To insert or replace headings, there are two options. &nbsp;You can<br />
;; &nbsp; &nbsp; insert a specific level heading directly or you can have<br />
;; &nbsp; &nbsp; `markdown-mode&#39; determine the level for you based on the previous<br />
;; &nbsp; &nbsp; heading. &nbsp;As with the other markup commands, the heading<br />
;; &nbsp; &nbsp; insertion commands use the text in the active region, if any,<br />
;; &nbsp; &nbsp; as the heading text. &nbsp;Otherwise, if the current line is not<br />
;; &nbsp; &nbsp; blank, they use the text on the current line. &nbsp;Finally, the<br />
;; &nbsp; &nbsp; setext commands will prompt for heading text if there is no<br />
;; &nbsp; &nbsp; active region and the current line is blank.<br />
;;<br />
;; &nbsp; &nbsp; `C-c C-s h` inserts a heading with automatically chosen type and<br />
;; &nbsp; &nbsp; level (both determined by the previous heading). &nbsp;`C-c C-s H`<br />
;; &nbsp; &nbsp; behaves similarly, but uses setext (underlined) headings when<br />
;; &nbsp; &nbsp; possible, still calculating the level automatically.<br />
;; &nbsp; &nbsp; In cases where the automatically-determined level is not what<br />
;; &nbsp; &nbsp; you intended, the level can be quickly promoted or demoted<br />
;; &nbsp; &nbsp; (as described below). &nbsp;Alternatively, a `C-u` prefix can be<br />
;; &nbsp; &nbsp; given to insert a heading _promoted_ (lower number) by one<br />
;; &nbsp; &nbsp; level or a `C-u C-u` prefix can be given to insert a heading<br />
;; &nbsp; &nbsp; demoted (higher number) by one level.<br />
;;<br />
;; &nbsp; &nbsp; To insert a heading of a specific level and type, use `C-c C-s 1`<br />
;; &nbsp; &nbsp; through `C-c C-s 6` for atx (hash mark) headings and `C-c C-s !` or<br />
;; &nbsp; &nbsp; `C-c C-s @` for setext headings of level one or two, respectively.<br />
;; &nbsp; &nbsp; Note that `!` is `S-1` and `@` is `S-2`.<br />
;;<br />
;; &nbsp; &nbsp; If the point is at a heading, these commands will replace the<br />
;; &nbsp; &nbsp; existing markup in order to update the level and/or type of the<br />
;; &nbsp; &nbsp; heading. &nbsp;To remove the markup of the heading at the point,<br />
;; &nbsp; &nbsp; press `C-c C-k` to kill the heading and press `C-y` to yank the<br />
;; &nbsp; &nbsp; heading text back into the buffer.<br />
;;<br />
;; &nbsp; * Horizontal Rules: `C-c C-s -`<br />
;;<br />
;; &nbsp; &nbsp; `C-c C-s -` inserts a horizontal rule. &nbsp;By default, insert the<br />
;; &nbsp; &nbsp; first string in the list `markdown-hr-strings&#39; (the most<br />
;; &nbsp; &nbsp; prominent rule). &nbsp;With a `C-u` prefix, insert the last string.<br />
;; &nbsp; &nbsp; With a numeric prefix `N`, insert the string in position `N`<br />
;; &nbsp; &nbsp; (counting from 1).<br />
;;<br />
;; &nbsp; * Footnotes: `C-c C-s f`<br />
;;<br />
;; &nbsp; &nbsp; `C-c C-s f` inserts a footnote marker at the point, inserts a<br />
;; &nbsp; &nbsp; footnote definition below, and positions the point for<br />
;; &nbsp; &nbsp; inserting the footnote text. &nbsp;Note that footnotes are an<br />
;; &nbsp; &nbsp; extension to Markdown and are not supported by all processors.<br />
;;<br />
;; &nbsp; * Wiki Links: `C-c C-s w`<br />
;;<br />
;; &nbsp; &nbsp; `C-c C-s w` inserts a wiki link of the form `[[WikiLink]]`. &nbsp;If<br />
;; &nbsp; &nbsp; there is an active region, use the region as the link text. &nbsp;If the<br />
;; &nbsp; &nbsp; point is at a word, use the word as the link text. &nbsp;If there is<br />
;; &nbsp; &nbsp; no active region and the point is not at word, simply insert<br />
;; &nbsp; &nbsp; link markup. &nbsp;Note that wiki links are an extension to Markdown<br />
;; &nbsp; &nbsp; and are not supported by all processors.<br />
;;<br />
;; &nbsp; * Markdown and Maintenance Commands: `C-c C-c`<br />
;;<br />
;; &nbsp; &nbsp; *Compile:* `C-c C-c m` will run Markdown on the current buffer<br />
;; &nbsp; &nbsp; and show the output in another buffer. &nbsp;*Preview*: `C-c C-c p`<br />
;; &nbsp; &nbsp; runs Markdown on the current buffer and previews, stores the<br />
;; &nbsp; &nbsp; output in a temporary file, and displays the file in a browser.<br />
;; &nbsp; &nbsp; *Export:* `C-c C-c e` will run Markdown on the current buffer<br />
;; &nbsp; &nbsp; and save the result in the file `basename.html`, where<br />
;; &nbsp; &nbsp; `basename` is the name of the Markdown file with the extension<br />
;; &nbsp; &nbsp; removed. &nbsp;*Export and View:* press `C-c C-c v` to export the<br />
;; &nbsp; &nbsp; file and view it in a browser. &nbsp;*Open:* `C-c C-c o` will open<br />
;; &nbsp; &nbsp; the Markdown source file directly using `markdown-open-command&#39;.<br />
;; &nbsp; &nbsp; *Live Export*: Press `C-c C-c l` to turn on<br />
;; &nbsp; &nbsp; `markdown-live-preview-mode&#39; to view the exported output<br />
;; &nbsp; &nbsp; side-by-side with the source Markdown. **For all export commands,<br />
;; &nbsp; &nbsp; the output file will be overwritten without notice.**<br />
;; &nbsp; &nbsp; `markdown-live-preview-window-function&#39; can be customized to open<br />
;; &nbsp; &nbsp; in a browser other than `eww&#39;. &nbsp;If you want to force the<br />
;; &nbsp; &nbsp; preview window to appear at the bottom or right, you can<br />
;; &nbsp; &nbsp; customize `markdown-split-window-direction&#39;.<br />
;;<br />
;; &nbsp; &nbsp; To summarize:<br />
;;<br />
;; &nbsp; &nbsp; &nbsp; - `C-c C-c m`: `markdown-command&#39; &gt; `*markdown-output*` buffer.<br />
;; &nbsp; &nbsp; &nbsp; - `C-c C-c p`: `markdown-command&#39; &gt; temporary file &gt; browser.<br />
;; &nbsp; &nbsp; &nbsp; - `C-c C-c e`: `markdown-command&#39; &gt; `basename.html`.<br />
;; &nbsp; &nbsp; &nbsp; - `C-c C-c v`: `markdown-command&#39; &gt; `basename.html` &gt; browser.<br />
;; &nbsp; &nbsp; &nbsp; - `C-c C-c w`: `markdown-command&#39; &gt; kill ring.<br />
;; &nbsp; &nbsp; &nbsp; - `C-c C-c o`: `markdown-open-command&#39;.<br />
;; &nbsp; &nbsp; &nbsp; - `C-c C-c l`: `markdown-live-preview-mode&#39; &gt; `*eww*` buffer.<br />
;;<br />
;; &nbsp; &nbsp; `C-c C-c c` will check for undefined references. &nbsp;If there are<br />
;; &nbsp; &nbsp; any, a small buffer will open with a list of undefined<br />
;; &nbsp; &nbsp; references and the line numbers on which they appear. &nbsp;In Emacs<br />
;; &nbsp; &nbsp; 22 and greater, selecting a reference from this list and<br />
;; &nbsp; &nbsp; pressing `RET` will insert an empty reference definition at the<br />
;; &nbsp; &nbsp; end of the buffer. &nbsp;Similarly, selecting the line number will<br />
;; &nbsp; &nbsp; jump to the corresponding line.<br />
;;<br />
;; &nbsp; &nbsp; `C-c C-c n` renumbers any ordered lists in the buffer that are<br />
;; &nbsp; &nbsp; out of sequence.<br />
;;<br />
;; &nbsp; &nbsp; `C-c C-c ]` completes all headings and normalizes all horizontal<br />
;; &nbsp; &nbsp; rules in the buffer.<br />
;;<br />
;; &nbsp; * Following Links: `C-c C-o`<br />
;;<br />
;; &nbsp; &nbsp; Press `C-c C-o` when the point is on an inline or reference<br />
;; &nbsp; &nbsp; link to open the URL in a browser. &nbsp;When the point is at a<br />
;; &nbsp; &nbsp; wiki link, open it in another buffer (in the current window,<br />
;; &nbsp; &nbsp; or in the other window with the `C-u` prefix). &nbsp;Use `M-p` and<br />
;; &nbsp; &nbsp; `M-n` to quickly jump to the previous or next link of any type.<br />
;;<br />
;; &nbsp; * Doing Things: `C-c C-d`<br />
;;<br />
;; &nbsp; &nbsp; Use `C-c C-d` to do something sensible with the object at the point:<br />
;;<br />
;; &nbsp; &nbsp; &nbsp; - Jumps between reference links and reference definitions.<br />
;; &nbsp; &nbsp; &nbsp; &nbsp; If more than one link uses the same reference label, a<br />
;; &nbsp; &nbsp; &nbsp; &nbsp; window will be shown containing clickable buttons for<br />
;; &nbsp; &nbsp; &nbsp; &nbsp; jumping to each link. &nbsp;Pressing `TAB` or `S-TAB` cycles<br />
;; &nbsp; &nbsp; &nbsp; &nbsp; between buttons in this window.<br />
;; &nbsp; &nbsp; &nbsp; - Jumps between footnote markers and footnote text.<br />
;; &nbsp; &nbsp; &nbsp; - Toggles the completion status of GFM task list items<br />
;; &nbsp; &nbsp; &nbsp; &nbsp; (checkboxes).<br />
;;<br />
;; &nbsp; * Promotion and Demotion: `C-c C--` and `C-c C-=`<br />
;;<br />
;; &nbsp; &nbsp; Headings, horizontal rules, and list items can be promoted and<br />
;; &nbsp; &nbsp; demoted, as well as bold and italic text. &nbsp;For headings,<br />
;; &nbsp; &nbsp; &quot;promotion&quot; means *decreasing* the level (i.e., moving from<br />
;; &nbsp; &nbsp; `&lt;h2&gt;` to `&lt;h1&gt;`) while &quot;demotion&quot; means *increasing* the<br />
;; &nbsp; &nbsp; level. &nbsp;For horizontal rules, promotion and demotion means<br />
;; &nbsp; &nbsp; moving backward or forward through the list of rule strings in<br />
;; &nbsp; &nbsp; `markdown-hr-strings&#39;. &nbsp;For bold and italic text, promotion and<br />
;; &nbsp; &nbsp; demotion means changing the markup from underscores to asterisks.<br />
;; &nbsp; &nbsp; Press `C-c C--` or `C-c LEFT` to promote the element at the point<br />
;; &nbsp; &nbsp; if possible.<br />
;;<br />
;; &nbsp; &nbsp; To remember these commands, note that `-` is for decreasing the<br />
;; &nbsp; &nbsp; level (promoting), and `=` (on the same key as `+`) is for<br />
;; &nbsp; &nbsp; increasing the level (demoting). &nbsp;Similarly, the left and right<br />
;; &nbsp; &nbsp; arrow keys indicate the direction that the atx heading markup<br />
;; &nbsp; &nbsp; is moving in when promoting or demoting.<br />
;;<br />
;; &nbsp; * Completion: `C-c C-]`<br />
;;<br />
;; &nbsp; &nbsp; Complete markup is in normalized form, which means, for<br />
;; &nbsp; &nbsp; example, that the underline portion of a setext header is the<br />
;; &nbsp; &nbsp; same length as the heading text, or that the number of leading<br />
;; &nbsp; &nbsp; and trailing hash marks of an atx header are equal and that<br />
;; &nbsp; &nbsp; there is no extra whitespace in the header text. &nbsp;`C-c C-]`<br />
;; &nbsp; &nbsp; completes the markup at the point, if it is determined to be<br />
;; &nbsp; &nbsp; incomplete.<br />
;;<br />
;; &nbsp; * Editing Lists: `M-RET`, `C-c UP`, `C-c DOWN`, `C-c LEFT`, and `C-c RIGHT`<br />
;;<br />
;; &nbsp; &nbsp; New list items can be inserted with `M-RET` or `C-c C-j`. &nbsp;This<br />
;; &nbsp; &nbsp; command determines the appropriate marker (one of the possible<br />
;; &nbsp; &nbsp; unordered list markers or the next number in sequence for an<br />
;; &nbsp; &nbsp; ordered list) and indentation level by examining nearby list<br />
;; &nbsp; &nbsp; items. &nbsp;If there is no list before or after the point, start a<br />
;; &nbsp; &nbsp; new list. &nbsp;As with heading insertion, you may prefix this<br />
;; &nbsp; &nbsp; command by `C-u` to decrease the indentation by one level.<br />
;; &nbsp; &nbsp; Prefix this command by `C-u C-u` to increase the indentation by<br />
;; &nbsp; &nbsp; one level.<br />
;;<br />
;; &nbsp; &nbsp; Existing list items (and their nested sub-items) can be moved<br />
;; &nbsp; &nbsp; up or down with `C-c UP` or `C-c DOWN` and indented or<br />
;; &nbsp; &nbsp; outdented with `C-c RIGHT` or `C-c LEFT`.<br />
;;<br />
;; &nbsp; * Editing Subtrees: `C-c UP`, `C-c DOWN`, `C-c LEFT`, and `C-c RIGHT`<br />
;;<br />
;; &nbsp; &nbsp; Entire subtrees of ATX headings can be promoted and demoted<br />
;; &nbsp; &nbsp; with `C-c LEFT` and `C-c RIGHT`, which are the same keybindings<br />
;; &nbsp; &nbsp; used for promotion and demotion of list items. &nbsp; If the point is in<br />
;; &nbsp; &nbsp; a list item, the operate on the list item. &nbsp;Otherwise, they operate<br />
;; &nbsp; &nbsp; on the current heading subtree. &nbsp;Similarly, subtrees can be<br />
;; &nbsp; &nbsp; moved up and down with `C-c UP` and `C-c DOWN`.<br />
;;<br />
;; &nbsp; &nbsp; These commands currently do not work properly if there are<br />
;; &nbsp; &nbsp; Setext headings in the affected region.<br />
;;<br />
;; &nbsp; &nbsp; Please note the following &quot;boundary&quot; behavior for promotion and<br />
;; &nbsp; &nbsp; demotion. &nbsp;Any level-six headings will not be demoted further<br />
;; &nbsp; &nbsp; (i.e., they remain at level six, since Markdown and HTML define<br />
;; &nbsp; &nbsp; only six levels) and any level-one headings will promoted away<br />
;; &nbsp; &nbsp; entirely (i.e., heading markup will be removed, since a<br />
;; &nbsp; &nbsp; level-zero heading is not defined).<br />
;;<br />
;; &nbsp; * Shifting the Region: `C-c &lt;` and `C-c &gt;`<br />
;;<br />
;; &nbsp; &nbsp; Text in the region can be indented or outdented as a group using<br />
;; &nbsp; &nbsp; `C-c &gt;` to indent to the next indentation point (calculated in<br />
;; &nbsp; &nbsp; the current context), and `C-c &lt;` to outdent to the previous<br />
;; &nbsp; &nbsp; indentation point. &nbsp;These keybindings are the same as those for<br />
;; &nbsp; &nbsp; similar commands in `python-mode&#39;.<br />
;;<br />
;; &nbsp; * Killing Elements: `C-c C-k`<br />
;;<br />
;; &nbsp; &nbsp; Press `C-c C-k` to kill the thing at point and add important<br />
;; &nbsp; &nbsp; text, without markup, to the kill ring. &nbsp;Possible things to<br />
;; &nbsp; &nbsp; kill include (roughly in order of precedece): inline code,<br />
;; &nbsp; &nbsp; headings, horizonal rules, links (add link text to kill ring),<br />
;; &nbsp; &nbsp; images (add alt text to kill ring), angle URIs, email<br />
;; &nbsp; &nbsp; addresses, bold, italics, reference definitions (add URI to<br />
;; &nbsp; &nbsp; kill ring), footnote markers and text (kill both marker and<br />
;; &nbsp; &nbsp; text, add text to kill ring), and list items.<br />
;;<br />
;; &nbsp; * Outline Navigation: `C-c C-n`, `C-c C-p`, `C-c C-f`, `C-c C-b`, and `C-c C-u`<br />
;;<br />
;; &nbsp; &nbsp; These keys are used for hierarchical navigation in lists and<br />
;; &nbsp; &nbsp; headings. &nbsp;When the point is in a list, they move between list<br />
;; &nbsp; &nbsp; items. &nbsp;Otherwise, they move between headings. &nbsp;Use `C-c C-n` and<br />
;; &nbsp; &nbsp; `C-c C-p` to move between the next and previous visible<br />
;; &nbsp; &nbsp; headings or list items of any level. &nbsp;Similarly, `C-c C-f` and<br />
;; &nbsp; &nbsp; `C-c C-b` move to the next and previous visible headings or<br />
;; &nbsp; &nbsp; list items at the same level as the one at the point. &nbsp;Finally,<br />
;; &nbsp; &nbsp; `C-c C-u` will move up to the parent heading or list item.<br />
;;<br />
;; &nbsp; * Movement by Markdown paragraph: `M-{`, `M-}`, and `M-h`<br />
;;<br />
;; &nbsp; &nbsp; Paragraphs in `markdown-mode&#39; are regular paragraphs,<br />
;; &nbsp; &nbsp; paragraphs inside blockquotes, individual list items, headings,<br />
;; &nbsp; &nbsp; etc. &nbsp;These keys are usually bound to `forward-paragraph&#39; and<br />
;; &nbsp; &nbsp; `backward-paragraph&#39;, but the built-in Emacs functions are<br />
;; &nbsp; &nbsp; based on simple regular expressions that fail in Markdown<br />
;; &nbsp; &nbsp; files. &nbsp;Instead, they are bound to `markdown-forward-paragraph&#39;<br />
;; &nbsp; &nbsp; and `markdown-backward-paragraph&#39;. &nbsp;To mark a paragraph,<br />
;; &nbsp; &nbsp; you can use `M-h` (`markdown-mark-paragraph&#39;).<br />
;;<br />
;; &nbsp; * Movement by Markdown block: `C-M-{`, `C-M-}`, and `C-c M-h`<br />
;;<br />
;; &nbsp; &nbsp; Markdown blocks are regular paragraphs in many cases, but<br />
;; &nbsp; &nbsp; contain many paragraphs in other cases: blocks are considered<br />
;; &nbsp; &nbsp; to be entire lists, entire code blocks, and entire blockquotes.<br />
;; &nbsp; &nbsp; To move backward one block use `C-M-{`<br />
;; &nbsp; &nbsp; (`markdown-beginning-block`) and to move forward use `C-M-}`<br />
;; &nbsp; &nbsp; (`markdown-end-of-block`). &nbsp;To mark a block, use `C-c M-h`<br />
;; &nbsp; &nbsp; (`markdown-mark-block`).<br />
;;<br />
;; &nbsp; * Movement by Defuns: `C-M-a`, `C-M-e`, and `C-M-h`<br />
;;<br />
;; &nbsp; &nbsp; The usual Emacs commands can be used to move by defuns<br />
;; &nbsp; &nbsp; (top-level major definitions). &nbsp;In markdown-mode, a defun is a<br />
;; &nbsp; &nbsp; section. &nbsp;As usual, `C-M-a` will move the point to the<br />
;; &nbsp; &nbsp; beginning of the current or preceding defun, `C-M-e` will move<br />
;; &nbsp; &nbsp; to the end of the current or following defun, and `C-M-h` will<br />
;; &nbsp; &nbsp; put the region around the entire defun.<br />
;;<br />
;; &nbsp; * Miscellaneous Commands:<br />
;;<br />
;; &nbsp; &nbsp; When the [`edit-indirect&#39;][ei] package is installed, `C-c &#39;`<br />
;; &nbsp; &nbsp; (`markdown-edit-code-block`) can be used to edit a code block<br />
;; &nbsp; &nbsp; in an indirect buffer in the native major mode. Press `C-c C-c`<br />
;; &nbsp; &nbsp; to commit changes and return or `C-c C-k` to cancel.<br />
;;<br />
;; As noted, many of the commands above behave differently depending<br />
;; on whether Transient Mark mode is enabled or not. &nbsp;When it makes<br />
;; sense, if Transient Mark mode is on and the region is active, the<br />
;; command applies to the text in the region (e.g., `C-c C-s b` makes the<br />
;; region bold). &nbsp;For users who prefer to work outside of Transient<br />
;; Mark mode, since Emacs 22 it can be enabled temporarily by pressing<br />
;; `C-SPC C-SPC`. &nbsp;When this is not the case, many commands then<br />
;; proceed to look work with the word or line at the point.<br />
;;<br />
;; When applicable, commands that specifically act on the region even<br />
;; outside of Transient Mark mode have the same keybinding as their<br />
;; standard counterpart, but the letter is uppercase. &nbsp;For example,<br />
;; `markdown-insert-blockquote&#39; is bound to `C-c C-s q` and only acts on<br />
;; the region in Transient Mark mode while `markdown-blockquote-region&#39;<br />
;; is bound to `C-c C-s Q` and always applies to the region (when nonempty).<br />
;;<br />
;; Note that these region-specific functions are useful in many<br />
;; cases where it may not be obvious. &nbsp;For example, yanking text from<br />
;; the kill ring sets the mark at the beginning of the yanked text<br />
;; and moves the point to the end. &nbsp;Therefore, the (inactive) region<br />
;; contains the yanked text. &nbsp;So, `C-y` followed by `C-c C-s Q` will<br />
;; yank text and turn it into a blockquote.<br />
;;<br />
;; markdown-mode attempts to be flexible in how it handles<br />
;; indentation. &nbsp;When you press `TAB` repeatedly, the point will cycle<br />
;; through several possible indentation levels corresponding to things<br />
;; you might have in mind when you press `RET` at the end of a line or<br />
;; `TAB`. &nbsp;For example, you may want to start a new list item,<br />
;; continue a list item with hanging indentation, indent for a nested<br />
;; pre block, and so on. &nbsp;Outdenting is handled similarly when backspace<br />
;; is pressed at the beginning of the non-whitespace portion of a line.<br />
;;<br />
;; markdown-mode supports outline-minor-mode as well as org-mode-style<br />
;; visibility cycling for atx- or hash-style headings. &nbsp;There are two<br />
;; types of visibility cycling: Pressing `S-TAB` cycles globally between<br />
;; the table of contents view (headings only), outline view (top-level<br />
;; headings only), and the full document view. &nbsp;Pressing `TAB` while the<br />
;; point is at a heading will cycle through levels of visibility for the<br />
;; subtree: completely folded, visible children, and fully visible.<br />
;; Note that mixing hash and underline style headings will give undesired<br />
;; results.</p>

<p>;;; Customization:</p>

<p>;; Although no configuration is *necessary* there are a few things<br />
;; that can be customized. &nbsp;The `M-x customize-mode` command<br />
;; provides an interface to all of the possible customizations:<br />
;;<br />
;; &nbsp; * `markdown-command&#39; - the command used to run Markdown (default:<br />
;; &nbsp; &nbsp; `markdown`). &nbsp;This variable may be customized to pass<br />
;; &nbsp; &nbsp; command-line options to your Markdown processor of choice.<br />
;;<br />
;; &nbsp; * `markdown-command-needs-filename&#39; - set to `t&#39; if<br />
;; &nbsp; &nbsp; `markdown-command&#39; does not accept standard input (default:<br />
;; &nbsp; &nbsp; `nil&#39;). &nbsp;When `nil&#39;, `markdown-mode&#39; will pass the Markdown<br />
;; &nbsp; &nbsp; content to `markdown-command&#39; using standard input (`stdin`).<br />
;; &nbsp; &nbsp; When set to `t&#39;, `markdown-mode&#39; will pass the name of the file<br />
;; &nbsp; &nbsp; as the final command-line argument to `markdown-command&#39;. &nbsp;Note<br />
;; &nbsp; &nbsp; that in the latter case, you will only be able to run<br />
;; &nbsp; &nbsp; `markdown-command&#39; from buffers which are visiting a file.<br />
;;<br />
;; &nbsp; * `markdown-open-command&#39; - the command used for calling a standalone<br />
;; &nbsp; &nbsp; Markdown previewer which is capable of opening Markdown source files<br />
;; &nbsp; &nbsp; directly (default: `nil&#39;). &nbsp;This command will be called<br />
;; &nbsp; &nbsp; with a single argument, the filename of the current buffer.<br />
;; &nbsp; &nbsp; A representative program is the Mac app [Marked 2][], a<br />
;; &nbsp; &nbsp; live-updating Markdown previewer which can be [called from a<br />
;; &nbsp; &nbsp; simple shell script](https://jblevins.org/log/marked-2-command).<br />
;;<br />
;; &nbsp; * `markdown-hr-strings&#39; - list of strings to use when inserting<br />
;; &nbsp; &nbsp; horizontal rules. &nbsp;Different strings will not be distinguished<br />
;; &nbsp; &nbsp; when converted to HTML--they will all be converted to<br />
;; &nbsp; &nbsp; `&lt;hr/&gt;`--but they may add visual distinction and style to plain<br />
;; &nbsp; &nbsp; text documents. &nbsp;To maintain some notion of promotion and<br />
;; &nbsp; &nbsp; demotion, keep these sorted from largest to smallest.<br />
;;<br />
;; &nbsp; * `markdown-bold-underscore&#39; - set to a non-nil value to use two<br />
;; &nbsp; &nbsp; underscores when inserting bold text instead of two asterisks<br />
;; &nbsp; &nbsp; (default: `nil&#39;).<br />
;;<br />
;; &nbsp; * `markdown-italic-underscore&#39; - set to a non-nil value to use<br />
;; &nbsp; &nbsp; underscores when inserting italic text instead of asterisks<br />
;; &nbsp; &nbsp; (default: `nil&#39;).<br />
;;<br />
;; &nbsp; * `markdown-asymmetric-header&#39; - set to a non-nil value to use<br />
;; &nbsp; &nbsp; asymmetric header styling, placing header characters only on<br />
;; &nbsp; &nbsp; the left of headers (default: `nil&#39;).<br />
;;<br />
;; &nbsp; * `markdown-header-scaling&#39; - set to a non-nil value to use<br />
;; &nbsp; &nbsp; a variable-pitch font for headings where the size corresponds<br />
;; &nbsp; &nbsp; to the level of the heading (default: `nil&#39;).<br />
;;<br />
;; &nbsp; * `markdown-header-scaling-values&#39; - list of scaling values,<br />
;; &nbsp; &nbsp; relative to baseline, for headers of levels one through six,<br />
;; &nbsp; &nbsp; used when `markdown-header-scaling&#39; is non-nil<br />
;; &nbsp; &nbsp; (default: `(2.0 1.7 1.4 1.1 1.0 1.0)`).<br />
;;<br />
;; &nbsp; * `markdown-list-indent-width&#39; - depth of indentation for lists<br />
;; &nbsp; &nbsp; when inserting, promoting, and demoting list items (default: 4).<br />
;;<br />
;; &nbsp; * `markdown-indent-function&#39; - the function to use for automatic<br />
;; &nbsp; &nbsp; indentation (default: `markdown-indent-line&#39;).<br />
;;<br />
;; &nbsp; * `markdown-indent-on-enter&#39; - Set to a non-nil value to<br />
;; &nbsp; &nbsp; automatically indent new lines when `RET&#39; is pressed.<br />
;; &nbsp; &nbsp; Set to `indent-and-new-item&#39; to additionally continue lists<br />
;; &nbsp; &nbsp; when `RET&#39; is pressed (default: `t&#39;).<br />
;;<br />
;; &nbsp; * `markdown-enable-wiki-links&#39; - syntax highlighting for wiki<br />
;; &nbsp; &nbsp; links (default: `nil&#39;). &nbsp;Set this to a non-nil value to turn on<br />
;; &nbsp; &nbsp; wiki link support by default. &nbsp;Wiki link support can be toggled<br />
;; &nbsp; &nbsp; later using the function `markdown-toggle-wiki-links&#39;.&quot;<br />
;;<br />
;; &nbsp; * `markdown-wiki-link-alias-first&#39; - set to a non-nil value to<br />
;; &nbsp; &nbsp; treat aliased wiki links like `[[link text|PageName]]`<br />
;; &nbsp; &nbsp; (default: `t&#39;). &nbsp;When set to nil, they will be treated as<br />
;; &nbsp; &nbsp; `[[PageName|link text]]&#39;.<br />
;;<br />
;; &nbsp; * `markdown-uri-types&#39; - a list of protocol schemes (e.g., &quot;http&quot;)<br />
;; &nbsp; &nbsp; for URIs that `markdown-mode&#39; should highlight.<br />
;;<br />
;; &nbsp; * `markdown-enable-math&#39; - font lock for inline and display LaTeX<br />
;; &nbsp; &nbsp; math expressions (default: `nil&#39;). &nbsp;Set this to `t&#39; to turn on<br />
;; &nbsp; &nbsp; math support by default. &nbsp;Math support can be toggled<br />
;; &nbsp; &nbsp; interactively later using `C-c C-x C-e`<br />
;; &nbsp; &nbsp; (`markdown-toggle-math&#39;).<br />
;;<br />
;; &nbsp; * `markdown-css-paths&#39; - CSS files to link to in XHTML output<br />
;; &nbsp; &nbsp; (default: `nil`).<br />
;;<br />
;; &nbsp; * `markdown-content-type&#39; - when set to a nonempty string, an<br />
;; &nbsp; &nbsp; `http-equiv` attribute will be included in the XHTML `&lt;head&gt;`<br />
;; &nbsp; &nbsp; block (default: `&quot;&quot;`). &nbsp;If needed, the suggested values are<br />
;; &nbsp; &nbsp; `application/xhtml+xml` or `text/html`. &nbsp;See also:<br />
;; &nbsp; &nbsp; `markdown-coding-system&#39;.<br />
;;<br />
;; &nbsp; * `markdown-coding-system&#39; - used for specifying the character<br />
;; &nbsp; &nbsp; set identifier in the `http-equiv` attribute when included<br />
;; &nbsp; &nbsp; (default: `nil&#39;). &nbsp;See `markdown-content-type&#39;, which must<br />
;; &nbsp; &nbsp; be set before this variable has any effect. &nbsp;When set to `nil&#39;,<br />
;; &nbsp; &nbsp; `buffer-file-coding-system&#39; will be used to automatically<br />
;; &nbsp; &nbsp; determine the coding system string (falling back to<br />
;; &nbsp; &nbsp; `iso-8859-1&#39; when unavailable). &nbsp;Common settings are `utf-8&#39;<br />
;; &nbsp; &nbsp; and `iso-latin-1&#39;.<br />
;;<br />
;; &nbsp; * `markdown-xhtml-header-content&#39; - additional content to include<br />
;; &nbsp; &nbsp; in the XHTML `&lt;head&gt;` block (default: `&quot;&quot;`).<br />
;;<br />
;; &nbsp; * `markdown-xhtml-standalone-regexp&#39; - a regular expression which<br />
;; &nbsp; &nbsp; `markdown-mode&#39; uses to determine whether the output of<br />
;; &nbsp; &nbsp; `markdown-command&#39; is a standalone XHTML document or an XHTML<br />
;; &nbsp; &nbsp; fragment (default: `&quot;^\\(&lt;\\?xml\\|&lt;!DOCTYPE\\|&lt;html\\)&quot;`). &nbsp;If<br />
;; &nbsp; &nbsp; this regular expression not matched in the first five lines of<br />
;; &nbsp; &nbsp; output, `markdown-mode&#39; assumes the output is a fragment and<br />
;; &nbsp; &nbsp; adds a header and footer.<br />
;;<br />
;; &nbsp; * `markdown-link-space-sub-char&#39; - a character to replace spaces<br />
;; &nbsp; &nbsp; when mapping wiki links to filenames (default: `&quot;_&quot;`).<br />
;; &nbsp; &nbsp; For example, use an underscore for compatibility with the<br />
;; &nbsp; &nbsp; Python Markdown WikiLinks extension. &nbsp;In `gfm-mode&#39;, this is<br />
;; &nbsp; &nbsp; set to `&quot;-&quot;` to conform with GitHub wiki links.<br />
;;<br />
;; &nbsp; * `markdown-reference-location&#39; - where to insert reference<br />
;; &nbsp; &nbsp; definitions (default: `header`). &nbsp;The possible locations are<br />
;; &nbsp; &nbsp; the end of the document (`end`), after the current block<br />
;; &nbsp; &nbsp; (`immediately`), the end of the current subtree (`subtree&#39;),<br />
;; &nbsp; &nbsp; or before the next header (`header`).<br />
;;<br />
;; &nbsp; * `markdown-footnote-location&#39; - where to insert footnote text<br />
;; &nbsp; &nbsp; (default: `end`). &nbsp;The set of location options is the same as<br />
;; &nbsp; &nbsp; for `markdown-reference-location&#39;.<br />
;;<br />
;; &nbsp; * `markdown-nested-imenu-heading-index&#39; - Use nested imenu<br />
;; &nbsp; &nbsp; heading instead of a flat index (default: `t&#39;). &nbsp;A nested<br />
;; &nbsp; &nbsp; index may provide more natural browsing from the menu, but a<br />
;; &nbsp; &nbsp; flat list may allow for faster keyboard navigation via tab<br />
;; &nbsp; &nbsp; completion.<br />
;;<br />
;; &nbsp; * `comment-auto-fill-only-comments&#39; - variable is made<br />
;; &nbsp; &nbsp; buffer-local and set to `nil&#39; by default. &nbsp;In programming<br />
;; &nbsp; &nbsp; language modes, when this variable is non-nil, only comments<br />
;; &nbsp; &nbsp; will be filled by auto-fill-mode. &nbsp;However, comments in<br />
;; &nbsp; &nbsp; Markdown documents are rare and the most users probably intend<br />
;; &nbsp; &nbsp; for the actual content of the document to be filled. &nbsp;Making<br />
;; &nbsp; &nbsp; this variable buffer-local allows `markdown-mode&#39; to override<br />
;; &nbsp; &nbsp; the default behavior induced when the global variable is non-nil.<br />
;;<br />
;; &nbsp; * `markdown-gfm-additional-languages&#39;, - additional languages to<br />
;; &nbsp; &nbsp; make available, aside from those predefined in<br />
;; &nbsp; &nbsp; `markdown-gfm-recognized-languages&#39;, when inserting GFM code<br />
;; &nbsp; &nbsp; blocks (default: `nil`). Language strings must have be trimmed<br />
;; &nbsp; &nbsp; of whitespace and not contain any curly braces. They may be of<br />
;; &nbsp; &nbsp; arbitrary capitalization, though.<br />
;;<br />
;; &nbsp; * `markdown-gfm-use-electric-backquote&#39; - use<br />
;; &nbsp; &nbsp; `markdown-electric-backquote&#39; for interactive insertion of GFM<br />
;; &nbsp; &nbsp; code blocks when backquote is pressed three times (default: `t`).<br />
;;<br />
;; &nbsp; * `markdown-make-gfm-checkboxes-buttons&#39; - Whether GitHub<br />
;; &nbsp; &nbsp; Flavored Markdown style task lists (checkboxes) should be<br />
;; &nbsp; &nbsp; turned into buttons that can be toggled with mouse-1 or RET. If<br />
;; &nbsp; &nbsp; non-nil (default), then buttons are enabled. &nbsp;This works in<br />
;; &nbsp; &nbsp; `markdown-mode&#39; as well as `gfm-mode&#39;.<br />
;;<br />
;; &nbsp; * `markdown-hide-urls&#39; - Determines whether URL and reference<br />
;; &nbsp; &nbsp; labels are hidden for inline and reference links (default: `nil&#39;).<br />
;; &nbsp; &nbsp; When non-nil, inline links will appear in the buffer as<br />
;; &nbsp; &nbsp; `[link](鈭�)` instead of<br />
;; &nbsp; &nbsp; `[link](http://perhaps.a/very/long/url/)`. &nbsp;To change the<br />
;; &nbsp; &nbsp; placeholder (composition) character used, set the variable<br />
;; &nbsp; &nbsp; `markdown-url-compose-char&#39;. &nbsp;URL hiding can be toggled<br />
;; &nbsp; &nbsp; interactively using `C-c C-x C-l` (`markdown-toggle-url-hiding&#39;)<br />
;; &nbsp; &nbsp; or from the Markdown | Links &amp; Images menu.<br />
;;<br />
;; &nbsp; * `markdown-hide-markup&#39; - Determines whether all possible markup<br />
;; &nbsp; &nbsp; is hidden or otherwise beautified (default: `nil&#39;). &nbsp; The actual<br />
;; &nbsp; &nbsp; buffer text remains unchanged, but the display will be altered.<br />
;; &nbsp; &nbsp; Brackets and URLs for links will be hidden, asterisks and<br />
;; &nbsp; &nbsp; underscores for italic and bold text will be hidden, text<br />
;; &nbsp; &nbsp; bullets for unordered lists will be replaced by Unicode<br />
;; &nbsp; &nbsp; bullets, and so on. &nbsp;Since this includes URLs and reference<br />
;; &nbsp; &nbsp; labels, when non-nil this setting supersedes `markdown-hide-urls&#39;.<br />
;; &nbsp; &nbsp; Markup hiding can be toggled using `C-c C-x C-m`<br />
;; &nbsp; &nbsp; (`markdown-toggle-markup-hiding&#39;) or from the Markdown | Show &amp;<br />
;; &nbsp; &nbsp; Hide menu.<br />
;;<br />
;; &nbsp; &nbsp; Unicode bullets are used to replace ASCII list item markers.<br />
;; &nbsp; &nbsp; The list of characters used, in order of list level, can be<br />
;; &nbsp; &nbsp; specified by setting the variable `markdown-list-item-bullets&#39;.<br />
;; &nbsp; &nbsp; The placeholder characters used to replace other markup can<br />
;; &nbsp; &nbsp; be changed by customizing the corresponding variables:<br />
;; &nbsp; &nbsp; `markdown-blockquote-display-char&#39;,<br />
;; &nbsp; &nbsp; `markdown-hr-display-char&#39;, and<br />
;; &nbsp; &nbsp; `markdown-definition-display-char&#39;.<br />
;;<br />
;; &nbsp; * `markdown-fontify-code-blocks-natively&#39; - Whether to fontify<br />
;; &nbsp; &nbsp; code in code blocks using the native major mode. &nbsp;This only<br />
;; &nbsp; &nbsp; works for fenced code blocks where the language is specified<br />
;; &nbsp; &nbsp; where we can automatically determine the appropriate mode to<br />
;; &nbsp; &nbsp; use. &nbsp;The language to mode mapping may be customized by setting<br />
;; &nbsp; &nbsp; the variable `markdown-code-lang-modes&#39;. &nbsp;This can be toggled<br />
;; &nbsp; &nbsp; interactively by pressing `C-c C-x C-f`<br />
;; &nbsp; &nbsp; (`markdown-toggle-fontify-code-blocks-natively&#39;).<br />
;;<br />
;; &nbsp; * `markdown-gfm-uppercase-checkbox&#39; - When non-nil, complete GFM<br />
;; &nbsp; &nbsp; task list items with `[X]` instead of `[x]` (default: `nil&#39;).<br />
;; &nbsp; &nbsp; This is useful for compatibility with `org-mode&#39;, which doesn&#39;t<br />
;; &nbsp; &nbsp; recognize the lowercase variant.<br />
;;<br />
;; Additionally, the faces used for syntax highlighting can be modified to<br />
;; your liking by issuing `M-x customize-group RET markdown-faces`<br />
;; or by using the &quot;Markdown Faces&quot; link at the bottom of the mode<br />
;; customization screen.<br />
;;<br />
;; [Marked 2]: https://itunes.apple.com/us/app/marked-2/id890031187?mt=12&amp;uo=4&amp;at=11l5Vs&amp;ct=mm</p>

<p>;;; Extensions:</p>

<p>;; Besides supporting the basic Markdown syntax, Markdown Mode also<br />
;; includes syntax highlighting for `[[Wiki Links]]`. &nbsp;This can be<br />
;; enabled by setting `markdown-enable-wiki-links&#39; to a non-nil value.<br />
;; Wiki links may be followed by pressing `C-c C-o` when the point<br />
;; is at a wiki link. &nbsp;Use `M-p` and `M-n` to quickly jump to the<br />
;; previous and next links (including links of other types).<br />
;; Aliased or piped wiki links of the form `[[link text|PageName]]`<br />
;; are also supported. &nbsp;Since some wikis reverse these components, set<br />
;; `markdown-wiki-link-alias-first&#39; to nil to treat them as<br />
;; `[[PageName|link text]]`. &nbsp;If `markdown-wiki-link-fontify-missing&#39;<br />
;; is also non-nil, Markdown Mode will highlight wiki links with<br />
;; missing target file in a different color. &nbsp;By default, Markdown<br />
;; Mode only searches for target files in the current directory.<br />
;; Search in subdirectories can be enabled by setting<br />
;; `markdown-wiki-link-search-subdirectories&#39; to a non-nil value.<br />
;; Sequential parent directory search (as in [Ikiwiki][]) can be<br />
;; enabled by setting `markdown-wiki-link-search-parent-directories&#39;<br />
;; to a non-nil value.<br />
;;<br />
;; [Ikiwiki]: https://ikiwiki.info<br />
;;<br />
;; [SmartyPants][] support is possible by customizing `markdown-command&#39;.<br />
;; If you install `SmartyPants.pl` at, say, `/usr/local/bin/smartypants`,<br />
;; then you can set `markdown-command&#39; to `&quot;markdown | smartypants&quot;`.<br />
;; You can do this either by using `M-x customize-group markdown`<br />
;; or by placing the following in your `.emacs` file:<br />
;;<br />
;; ``` Lisp<br />
;; (setq markdown-command &quot;markdown | smartypants&quot;)<br />
;; ```<br />
;;<br />
;; [SmartyPants]: http://daringfireball.net/projects/smartypants/<br />
;;<br />
;; Syntax highlighting for mathematical expressions written<br />
;; in LaTeX (only expressions denoted by `$..$`, `$$..$$`, or `\[..\]`)<br />
;; can be enabled by setting `markdown-enable-math&#39; to a non-nil value,<br />
;; either via customize or by placing `(setq markdown-enable-math t)`<br />
;; in `.emacs`, and then restarting Emacs or calling<br />
;; `markdown-reload-extensions&#39;.</p>

<p>;;; GitHub Flavored Markdown (GFM):</p>

<p>;; A [GitHub Flavored Markdown][GFM] mode, `gfm-mode&#39;, is also<br />
;; available. &nbsp;The GitHub implementation differs slightly from<br />
;; standard Markdown in that it supports things like different<br />
;; behavior for underscores inside of words, automatic linking of<br />
;; URLs, strikethrough text, and fenced code blocks with an optional<br />
;; language keyword.<br />
;;<br />
;; The GFM-specific features above apply to `README.md` files, wiki<br />
;; pages, and other Markdown-formatted files in repositories on<br />
;; GitHub. &nbsp;GitHub also enables [additional features][GFM comments] for<br />
;; writing on the site (for issues, pull requests, messages, etc.)<br />
;; that are further extensions of GFM. &nbsp;These features include task<br />
;; lists (checkboxes), newlines corresponding to hard line breaks,<br />
;; auto-linked references to issues and commits, wiki links, and so<br />
;; on. &nbsp;To make matters more confusing, although task lists are not<br />
;; part of [GFM proper][GFM], [since 2014][] they are rendered (in a<br />
;; read-only fashion) in all Markdown documents in repositories on the<br />
;; site. &nbsp;These additional extensions are supported to varying degrees<br />
;; by `markdown-mode&#39; and `gfm-mode&#39; as described below.<br />
;;<br />
;; * **URL autolinking:** Both `markdown-mode&#39; and `gfm-mode&#39; support<br />
;; &nbsp; highlighting of URLs without angle brackets.<br />
;;<br />
;; * **Multiple underscores in words:** You must enable `gfm-mode&#39; to<br />
;; &nbsp; toggle support for underscores inside of words. In this mode<br />
;; &nbsp; variable names such as `a_test_variable` will not trigger<br />
;; &nbsp; emphasis (italics).<br />
;;<br />
;; * **Fenced code blocks:** Code blocks quoted with backquotes, with<br />
;; &nbsp; optional programming language keywords, are highlighted in<br />
;; &nbsp; both `markdown-mode&#39; and `gfm-mode&#39;. &nbsp;They can be inserted with<br />
;; &nbsp; `C-c C-s C`. &nbsp;If there is an active region, the text in the<br />
;; &nbsp; region will be placed inside the code block. &nbsp;You will be<br />
;; &nbsp; prompted for the name of the language, but may press enter to<br />
;; &nbsp; continue without naming a language.<br />
;;<br />
;; * **Strikethrough:** Strikethrough text is supported in both<br />
;; &nbsp; `markdown-mode&#39; and `gfm-mode&#39;. &nbsp;It can be inserted (and toggled)<br />
;; &nbsp; using `C-c C-s s`.<br />
;;<br />
;; * **Task lists:** GFM task lists will be rendered as checkboxes<br />
;; &nbsp; (Emacs buttons) in both `markdown-mode&#39; and `gfm-mode&#39; when<br />
;; &nbsp; `markdown-make-gfm-checkboxes-buttons&#39; is set to a non-nil value<br />
;; &nbsp; (and it is set to t by default). &nbsp;These checkboxes can be<br />
;; &nbsp; toggled by clicking `mouse-1`, pressing `RET` over the button,<br />
;; &nbsp; or by pressing `C-c C-d` (`markdown-do`) with the point anywhere<br />
;; &nbsp; in the task list item.<br />
;;<br />
;; * **Wiki links:** Generic wiki links are supported in<br />
;; &nbsp; `markdown-mode&#39;, but in `gfm-mode&#39; specifically they will be<br />
;; &nbsp; treated as they are on GitHub: spaces will be replaced by hyphens<br />
;; &nbsp; in filenames and the first letter of the filename will be<br />
;; &nbsp; capitalized. &nbsp;For example, `[[wiki link]]&#39; will map to a file<br />
;; &nbsp; named `Wiki-link` with the same extension as the current file.<br />
;; &nbsp; If a file with this name does not exist in the current directory,<br />
;; &nbsp; the first match in a subdirectory, if any, will be used instead.<br />
;;<br />
;; * **Newlines:** Neither `markdown-mode&#39; nor `gfm-mode&#39; do anything<br />
;; &nbsp; specifically with respect to newline behavior. &nbsp;If you use<br />
;; &nbsp; `gfm-mode&#39; mostly to write text for comments or issues on the<br />
;; &nbsp; GitHub site--where newlines are significant and correspond to<br />
;; &nbsp; hard line breaks--then you may want to enable `visual-line-mode&#39;<br />
;; &nbsp; for line wrapping in buffers. &nbsp;You can do this with a<br />
;; &nbsp; `gfm-mode-hook&#39; as follows:<br />
;;<br />
;; &nbsp; &nbsp; ``` Lisp<br />
;; &nbsp; &nbsp; ;; Use visual-line-mode in gfm-mode<br />
;; &nbsp; &nbsp; (defun my-gfm-mode-hook ()<br />
;; &nbsp; &nbsp; &nbsp; (visual-line-mode 1))<br />
;; &nbsp; &nbsp; (add-hook &#39;gfm-mode-hook &#39;my-gfm-mode-hook)<br />
;; &nbsp; &nbsp; ```<br />
;;<br />
;; * **Preview:** GFM-specific preview can be powered by setting<br />
;; &nbsp; `markdown-command&#39; to use [Docter][]. &nbsp;This may also be<br />
;; &nbsp; configured to work with [Marked 2][] for `markdown-open-command&#39;.<br />
;;<br />
;; [GFM]: http://github.github.com/github-flavored-markdown/<br />
;; [GFM comments]: https://help.github.com/articles/writing-on-github/<br />
;; [since 2014]: https://github.com/blog/1825-task-lists-in-all-markdown-documents<br />
;; [Docter]: https://github.com/alampros/Docter</p>

<p>;;; Acknowledgments:</p>

<p>;; markdown-mode has benefited greatly from the efforts of the many<br />
;; volunteers who have sent patches, test cases, bug reports,<br />
;; suggestions, helped with packaging, etc. &nbsp;Thank you for your<br />
;; contributions! &nbsp;See the [contributors graph][contrib] for details.<br />
;;<br />
;; &nbsp;[contrib]: https://github.com/jrblevin/markdown-mode/graphs/contributors</p>

<p>;;; Bugs:</p>

<p>;; markdown-mode is developed and tested primarily for compatibility<br />
;; with GNU Emacs 24.3 and later. &nbsp;If you find any bugs in<br />
;; markdown-mode, please construct a test case or a patch and open a<br />
;; ticket on the [GitHub issue tracker][issues]. &nbsp;See the<br />
;; contributing guidelines in `CONTRIBUTING.md` for details on<br />
;; creating pull requests.<br />
;;<br />
;; &nbsp;[issues]: https://github.com/jrblevin/markdown-mode/issues</p>

<p>;;; History:</p>

<p>;; markdown-mode was written and is maintained by Jason Blevins. &nbsp;The<br />
;; first version was released on May 24, 2007.<br />
;;<br />
;; &nbsp; * 2007-05-24: [Version 1.1][]<br />
;; &nbsp; * 2007-05-25: [Version 1.2][]<br />
;; &nbsp; * 2007-06-05: [Version 1.3][]<br />
;; &nbsp; * 2007-06-29: [Version 1.4][]<br />
;; &nbsp; * 2007-10-11: [Version 1.5][]<br />
;; &nbsp; * 2008-06-04: [Version 1.6][]<br />
;; &nbsp; * 2009-10-01: [Version 1.7][]<br />
;; &nbsp; * 2011-08-12: [Version 1.8][]<br />
;; &nbsp; * 2011-08-15: [Version 1.8.1][]<br />
;; &nbsp; * 2013-01-25: [Version 1.9][]<br />
;; &nbsp; * 2013-03-24: [Version 2.0][]<br />
;; &nbsp; * 2016-01-09: [Version 2.1][]<br />
;; &nbsp; * 2017-05-26: [Version 2.2][]<br />
;; &nbsp; * 2017-08-31: [Version 2.3][]<br />
;;<br />
;; [Version 1.1]: https://jblevins.org/projects/markdown-mode/rev-1-1<br />
;; [Version 1.2]: https://jblevins.org/projects/markdown-mode/rev-1-2<br />
;; [Version 1.3]: https://jblevins.org/projects/markdown-mode/rev-1-3<br />
;; [Version 1.4]: https://jblevins.org/projects/markdown-mode/rev-1-4<br />
;; [Version 1.5]: https://jblevins.org/projects/markdown-mode/rev-1-5<br />
;; [Version 1.6]: https://jblevins.org/projects/markdown-mode/rev-1-6<br />
;; [Version 1.7]: https://jblevins.org/projects/markdown-mode/rev-1-7<br />
;; [Version 1.8]: https://jblevins.org/projects/markdown-mode/rev-1-8<br />
;; [Version 1.8.1]: https://jblevins.org/projects/markdown-mode/rev-1-8-1<br />
;; [Version 1.9]: https://jblevins.org/projects/markdown-mode/rev-1-9<br />
;; [Version 2.0]: https://jblevins.org/projects/markdown-mode/rev-2-0<br />
;; [Version 2.1]: https://jblevins.org/projects/markdown-mode/rev-2-1<br />
;; [Version 2.2]: https://jblevins.org/projects/markdown-mode/rev-2-2<br />
;; [Version 2.3]: https://jblevins.org/projects/markdown-mode/rev-2-3</p>

<p><br />
;;; Code:</p>

<p>(require &#39;easymenu)<br />
(require &#39;outline)<br />
(require &#39;thingatpt)<br />
(require &#39;cl-lib)<br />
(require &#39;url-parse)<br />
(require &#39;button)<br />
(require &#39;color)</p>

<p>(defvar jit-lock-start)<br />
(defvar jit-lock-end)<br />
(defvar flyspell-generic-check-word-predicate)</p>

<p>(declare-function eww-open-file &quot;eww&quot;)<br />
(declare-function url-path-and-query &quot;url-parse&quot;)</p>

<p><br />
;;; Constants =================================================================</p>

<p>(defconst markdown-mode-version &quot;2.3&quot;<br />
&nbsp; &quot;Markdown mode version number.&quot;)</p>

<p>(defconst markdown-output-buffer-name &quot;*markdown-output*&quot;<br />
&nbsp; &quot;Name of temporary buffer for markdown command output.&quot;)</p>

<p>(defconst markdown-sub-superscript-display<br />
&nbsp; &#39;(((raise -0.3) (height 0.7)) &nbsp; &nbsp; &nbsp; &nbsp; ; subscript<br />
&nbsp; &nbsp; ((raise 0.3) (height 0.7))) &nbsp; &nbsp; &nbsp; &nbsp; ; superscript<br />
&nbsp; &quot;Parameters for sub- and superscript formatting.&quot;)</p>

<p><br />
;;; Global Variables ==========================================================</p>

<p>(defvar markdown-reference-label-history nil<br />
&nbsp; &quot;History of used reference labels.&quot;)</p>

<p>(defvar markdown-live-preview-mode nil<br />
&nbsp; &quot;Sentinel variable for command `markdown-live-preview-mode&#39;.&quot;)</p>

<p>(defvar markdown-gfm-language-history nil<br />
&nbsp; &quot;History list of languages used in the current buffer in GFM code blocks.&quot;)</p>

<p><br />
;;; Customizable Variables ====================================================</p>

<p>(defvar markdown-mode-hook nil<br />
&nbsp; &quot;Hook run when entering Markdown mode.&quot;)</p>

<p>(defvar markdown-before-export-hook nil<br />
&nbsp; &quot;Hook run before running Markdown to export XHTML output.<br />
The hook may modify the buffer, which will be restored to it&#39;s<br />
original state after exporting is complete.&quot;)</p>

<p>(defvar markdown-after-export-hook nil<br />
&nbsp; &quot;Hook run after XHTML output has been saved.<br />
Any changes to the output buffer made by this hook will be saved.&quot;)</p>

<p>(defgroup markdown nil<br />
&nbsp; &quot;Major mode for editing text files in Markdown format.&quot;<br />
&nbsp; :prefix &quot;markdown-&quot;<br />
&nbsp; :group &#39;wp<br />
&nbsp; :link &#39;(url-link &quot;https://jblevins.org/projects/markdown-mode/&quot;))</p>

<p>(defcustom markdown-command &quot;markdown&quot;<br />
&nbsp; &quot;Command to run markdown.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;string)</p>

<p>(defcustom markdown-command-needs-filename nil<br />
&nbsp; &quot;Set to non-nil if `markdown-command&#39; does not accept input from stdin.<br />
Instead, it will be passed a filename as the final command line<br />
option. &nbsp;As a result, you will only be able to run Markdown from<br />
buffers which are visiting a file.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean)</p>

<p>(defcustom markdown-open-command nil<br />
&nbsp; &quot;Command used for opening Markdown files directly.<br />
For example, a standalone Markdown previewer. &nbsp;This command will<br />
be called with a single argument: the filename of the current<br />
buffer.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;string)</p>

<p>(defcustom markdown-hr-strings<br />
&nbsp; &#39;(&quot;-------------------------------------------------------------------------------&quot;<br />
&nbsp; &nbsp; &quot;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *&quot;<br />
&nbsp; &nbsp; &quot;---------------------------------------&quot;<br />
&nbsp; &nbsp; &quot;* * * * * * * * * * * * * * * * * * * *&quot;<br />
&nbsp; &nbsp; &quot;---------&quot;<br />
&nbsp; &nbsp; &quot;* * * * *&quot;)<br />
&nbsp; &quot;Strings to use when inserting horizontal rules.<br />
The first string in the list will be the default when inserting a<br />
horizontal rule. &nbsp;Strings should be listed in decreasing order of<br />
prominence (as in headings from level one to six) for use with<br />
promotion and demotion functions.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;list)</p>

<p>(defcustom markdown-bold-underscore nil<br />
&nbsp; &quot;Use two underscores when inserting bold text instead of two asterisks.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean)</p>

<p>(defcustom markdown-italic-underscore nil<br />
&nbsp; &quot;Use underscores when inserting italic text instead of asterisks.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean)</p>

<p>(defcustom markdown-asymmetric-header nil<br />
&nbsp; &quot;Determines if atx header style will be asymmetric.<br />
Set to a non-nil value to use asymmetric header styling, placing<br />
header markup only at the beginning of the line. By default,<br />
balanced markup will be inserted at the beginning and end of the<br />
line around the header title.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean)</p>

<p>(defcustom markdown-indent-function &#39;markdown-indent-line<br />
&nbsp; &quot;Function to use to indent.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;function)</p>

<p>(defcustom markdown-indent-on-enter t<br />
&nbsp; &quot;Determines indentation behavior when pressing \\[newline].<br />
Possible settings are nil, t, and &#39;indent-and-new-item.</p>

<p>When non-nil, pressing \\[newline] will call `newline-and-indent&#39;<br />
to indent the following line according to the context using<br />
`markdown-indent-function&#39;. &nbsp;In this case, note that<br />
\\[electric-newline-and-maybe-indent] can still be used to insert<br />
a newline without indentation.</p>

<p>When set to &#39;indent-and-new-item and the point is in a list item<br />
when \\[newline] is pressed, the list will be continued on the next<br />
line, where a new item will be inserted.</p>

<p>When set to nil, simply call `newline&#39; as usual. &nbsp;In this case,<br />
you can still indent lines using \\[markdown-cycle] and continue<br />
lists with \\[markdown-insert-list-item].</p>

<p>Note that this assumes the variable `electric-indent-mode&#39; is<br />
non-nil (enabled). &nbsp;When it is *disabled*, the behavior of<br />
\\[newline] and `\\[electric-newline-and-maybe-indent]&#39; are<br />
reversed.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;(choice (const :tag &quot;Don&#39;t automatically indent&quot; nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(const :tag &quot;Automatically indent&quot; t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(const :tag &quot;Automatically indent and insert new list items&quot; indent-and-new-item)))</p>

<p>(defcustom markdown-enable-wiki-links nil<br />
&nbsp; &quot;Syntax highlighting for wiki links.<br />
Set this to a non-nil value to turn on wiki link support by default.<br />
Support can be toggled later using the `markdown-toggle-wiki-links&#39;<br />
function or \\[markdown-toggle-wiki-links].&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean<br />
&nbsp; :safe &#39;booleanp<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.2&quot;))</p>

<p>(defcustom markdown-wiki-link-alias-first t<br />
&nbsp; &quot;When non-nil, treat aliased wiki links like [[alias text|PageName]].<br />
Otherwise, they will be treated as [[PageName|alias text]].&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean<br />
&nbsp; :safe &#39;booleanp)</p>

<p>(defcustom markdown-wiki-link-search-subdirectories nil<br />
&nbsp; &quot;When non-nil, search for wiki link targets in subdirectories.<br />
This is the default search behavior for GitHub and is<br />
automatically set to t in `gfm-mode&#39;.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean<br />
&nbsp; :safe &#39;booleanp<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.2&quot;))</p>

<p>(defcustom markdown-wiki-link-search-parent-directories nil<br />
&nbsp; &quot;When non-nil, search for wiki link targets in parent directories.<br />
This is the default search behavior of Ikiwiki.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean<br />
&nbsp; :safe &#39;booleanp<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.2&quot;))</p>

<p>(defcustom markdown-wiki-link-fontify-missing nil<br />
&nbsp; &quot;When non-nil, change wiki link face according to existence of target files.<br />
This is expensive because it requires checking for the file each time the buffer<br />
changes or the user switches windows. &nbsp;It is disabled by default because it may<br />
cause lag when typing on slower machines.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean<br />
&nbsp; :safe &#39;booleanp<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.2&quot;))</p>

<p>(defcustom markdown-uri-types<br />
&nbsp; &#39;(&quot;acap&quot; &quot;cid&quot; &quot;data&quot; &quot;dav&quot; &quot;fax&quot; &quot;file&quot; &quot;ftp&quot;<br />
&nbsp; &nbsp; &quot;gopher&quot; &quot;http&quot; &quot;https&quot; &quot;imap&quot; &quot;ldap&quot; &quot;mailto&quot;<br />
&nbsp; &nbsp; &quot;mid&quot; &quot;message&quot; &quot;modem&quot; &quot;news&quot; &quot;nfs&quot; &quot;nntp&quot;<br />
&nbsp; &nbsp; &quot;pop&quot; &quot;prospero&quot; &quot;rtsp&quot; &quot;service&quot; &quot;sip&quot; &quot;tel&quot;<br />
&nbsp; &nbsp; &quot;telnet&quot; &quot;tip&quot; &quot;urn&quot; &quot;vemmi&quot; &quot;wais&quot;)<br />
&nbsp; &quot;Link types for syntax highlighting of URIs.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;list)</p>

<p>(defcustom markdown-url-compose-char<br />
&nbsp; (cond<br />
&nbsp; &nbsp;((char-displayable-p ?鈭�) ?鈭�)<br />
&nbsp; &nbsp;((char-displayable-p ?鈥�) ?鈥�)<br />
&nbsp; &nbsp;(t ?#))<br />
&nbsp; &quot;Placeholder character for hidden URLs.<br />
Depending on your font, some good choices are 鈥�, 鈰�, #, 鈭�, 鈽�, and 鈿�.&quot;<br />
&nbsp; :type &#39;character<br />
&nbsp; :safe &#39;characterp<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.3&quot;))</p>

<p>(defcustom markdown-blockquote-display-char<br />
&nbsp; (cond<br />
&nbsp; &nbsp;((char-displayable-p ?鈻�) &quot;鈻�&quot;)<br />
&nbsp; &nbsp;((char-displayable-p ?鈹�) &quot;鈹�&quot;)<br />
&nbsp; &nbsp;((char-displayable-p ?鈹�) &quot;鈹�&quot;)<br />
&nbsp; &nbsp;((char-displayable-p ?|) &quot;|&quot;)<br />
&nbsp; &nbsp;(t &quot;&gt;&quot;))<br />
&nbsp; &quot;Character for hiding blockquote markup.&quot;<br />
&nbsp; :type &#39;string<br />
&nbsp; :safe &#39;stringp<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.3&quot;))</p>

<p>(defcustom markdown-hr-display-char<br />
&nbsp; (cond ((char-displayable-p ?鈹&euro;) ?鈹&euro;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ((char-displayable-p ?鈹�) ?鈹�)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (t ?-))<br />
&nbsp; &quot;Character for hiding horizontal rule markup.&quot;<br />
&nbsp; :type &#39;character<br />
&nbsp; :safe &#39;characterp<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.3&quot;))</p>

<p>(defcustom markdown-definition-display-char<br />
&nbsp; (cond ((char-displayable-p ?鈦�) ?鈦�)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ((char-displayable-p ?鈦�) ?鈦�)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ((char-displayable-p ?鈮�) ?鈮�)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ((char-displayable-p ?鈱�) ?鈱�)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ((char-displayable-p ?鈼�) ?鈼�)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (t nil))<br />
&nbsp; &quot;Character for replacing definition list markup.&quot;<br />
&nbsp; :type &#39;character<br />
&nbsp; :safe &#39;characterp<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.3&quot;))</p>

<p>(defcustom markdown-enable-math nil<br />
&nbsp; &quot;Syntax highlighting for inline LaTeX and itex expressions.<br />
Set this to a non-nil value to turn on math support by default.<br />
Math support can be enabled, disabled, or toggled later using<br />
`markdown-toggle-math&#39; or \\[markdown-toggle-math].&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean<br />
&nbsp; :safe &#39;booleanp)<br />
(make-variable-buffer-local &#39;markdown-enable-math)</p>

<p>(defcustom markdown-css-paths nil<br />
&nbsp; &quot;URL of CSS file to link to in the output XHTML.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;list)</p>

<p>(defcustom markdown-content-type &quot;&quot;<br />
&nbsp; &quot;Content type string for the http-equiv header in XHTML output.<br />
When set to a non-empty string, insert the http-equiv attribute.<br />
Otherwise, this attribute is omitted.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;string)</p>

<p>(defcustom markdown-coding-system nil<br />
&nbsp; &quot;Character set string for the http-equiv header in XHTML output.<br />
Defaults to `buffer-file-coding-system&#39; (and falling back to<br />
`iso-8859-1&#39; when not available). &nbsp;Common settings are `utf-8&#39;<br />
and `iso-latin-1&#39;. &nbsp;Use `list-coding-systems&#39; for more choices.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;coding-system)</p>

<p>(defcustom markdown-xhtml-header-content &quot;&quot;<br />
&nbsp; &quot;Additional content to include in the XHTML &lt;head&gt; block.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;string)</p>

<p>(defcustom markdown-xhtml-standalone-regexp<br />
&nbsp; &quot;^\\(&lt;\\?xml\\|&lt;!DOCTYPE\\|&lt;html\\)&quot;<br />
&nbsp; &quot;Regexp indicating whether `markdown-command&#39; output is standalone XHTML.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;regexp)</p>

<p>(defcustom markdown-link-space-sub-char &quot;_&quot;<br />
&nbsp; &quot;Character to use instead of spaces when mapping wiki links to filenames.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;string)</p>

<p>(defcustom markdown-reference-location &#39;header<br />
&nbsp; &quot;Position where new reference definitions are inserted in the document.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;(choice (const :tag &quot;At the end of the document&quot; end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(const :tag &quot;Immediately after the current block&quot; immediately)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(const :tag &quot;At the end of the subtree&quot; subtree)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(const :tag &quot;Before next header&quot; header)))</p>

<p>(defcustom markdown-footnote-location &#39;end<br />
&nbsp; &quot;Position where new footnotes are inserted in the document.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;(choice (const :tag &quot;At the end of the document&quot; end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(const :tag &quot;Immediately after the current block&quot; immediately)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(const :tag &quot;At the end of the subtree&quot; subtree)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(const :tag &quot;Before next header&quot; header)))</p>

<p>(defcustom markdown-unordered-list-item-prefix &quot; &nbsp;* &quot;<br />
&nbsp; &quot;String inserted before unordered list items.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;string)</p>

<p>(defcustom markdown-nested-imenu-heading-index t<br />
&nbsp; &quot;Use nested or flat imenu heading index.<br />
A nested index may provide more natural browsing from the menu,<br />
but a flat list may allow for faster keyboard navigation via tab<br />
completion.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean<br />
&nbsp; :safe &#39;booleanp<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.2&quot;))</p>

<p>(defcustom markdown-make-gfm-checkboxes-buttons t<br />
&nbsp; &quot;When non-nil, make GFM checkboxes into buttons.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean)</p>

<p>(defcustom markdown-use-pandoc-style-yaml-metadata nil<br />
&nbsp; &quot;When non-nil, allow YAML metadata anywhere in the document.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean)</p>

<p>(defcustom markdown-split-window-direction &#39;any<br />
&nbsp; &quot;Preference for splitting windows for static and live preview.<br />
The default value is &#39;any, which instructs Emacs to use<br />
`split-window-sensibly&#39; to automatically choose how to split<br />
windows based on the values of `split-width-threshold&#39; and<br />
`split-height-threshold&#39; and the available windows. &nbsp;To force<br />
vertically split (left and right) windows, set this to &#39;vertical<br />
or &#39;right. &nbsp;To force horizontally split (top and bottom) windows,<br />
set this to &#39;horizontal or &#39;below.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;(choice (const :tag &quot;Automatic&quot; any)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(const :tag &quot;Right (vertical)&quot; right)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(const :tag &quot;Below (horizontal)&quot; below))<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.2&quot;))</p>

<p>(defcustom markdown-live-preview-window-function<br />
&nbsp; &#39;markdown-live-preview-window-eww<br />
&nbsp; &quot;Function to display preview of Markdown output within Emacs.<br />
Function must update the buffer containing the preview and return<br />
the buffer.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;function)</p>

<p>(defcustom markdown-live-preview-delete-export &#39;delete-on-destroy<br />
&nbsp; &quot;Delete exported HTML file when using `markdown-live-preview-export&#39;.<br />
If set to &#39;delete-on-export, delete on every export. When set to<br />
&#39;delete-on-destroy delete when quitting from command<br />
`markdown-live-preview-mode&#39;. Never delete if set to nil.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;(choice<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (const :tag &quot;Delete on every export&quot; delete-on-export)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (const :tag &quot;Delete when quitting live preview&quot; delete-on-destroy)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (const :tag &quot;Never delete&quot; nil)))</p>

<p>(defcustom markdown-list-indent-width 4<br />
&nbsp; &quot;Depth of indentation for markdown lists.<br />
Used in `markdown-demote-list-item&#39; and<br />
`markdown-promote-list-item&#39;.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;integer)</p>

<p>(defcustom markdown-enable-prefix-prompts t<br />
&nbsp; &quot;Display prompts for certain prefix commands.<br />
Set to nil to disable these prompts.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean<br />
&nbsp; :safe &#39;booleanp<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.3&quot;))</p>

<p>(defcustom markdown-gfm-additional-languages nil<br />
&nbsp; &quot;Extra languages made available when inserting GFM code blocks.<br />
Language strings must have be trimmed of whitespace and not<br />
contain any curly braces. They may be of arbitrary<br />
capitalization, though.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;(repeat (string :validate markdown-validate-language-string)))</p>

<p>(defcustom markdown-gfm-use-electric-backquote t<br />
&nbsp; &quot;Use `markdown-electric-backquote&#39; when backquote is hit three times.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean)</p>

<p>(defcustom markdown-gfm-downcase-languages t<br />
&nbsp; &quot;If non-nil, downcase suggested languages.<br />
This applies to insertions done with<br />
`markdown-electric-backquote&#39;.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean)</p>

<p>(defcustom markdown-gfm-uppercase-checkbox nil<br />
&nbsp; &quot;If non-nil, use [X] for completed checkboxes, [x] otherwise.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean<br />
&nbsp; :safe &#39;booleanp)</p>

<p>(defcustom markdown-hide-urls nil<br />
&nbsp; &quot;Hide URLs of inline links and reference tags of reference links.<br />
Such URLs will be replaced by a single customizable<br />
character (鈭�), or `markdown-url-compose-char&#39;, but are still part<br />
of the buffer. &nbsp;Links can be edited interactively with<br />
\\[markdown-insert-link] or, for example, by deleting the final<br />
parenthesis to remove the invisibility property. You can also<br />
hover your mouse pointer over the link text to see the URL.<br />
Set this to a non-nil value to turn this feature on by default.<br />
You can interactively set the value of this variable by calling<br />
`markdown-toggle-url-hiding&#39;, pressing \\[markdown-toggle-url-hiding],<br />
or from the menu Markdown &gt; Links &amp; Images menu.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean<br />
&nbsp; :safe &#39;booleanp<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.3&quot;))<br />
(make-variable-buffer-local &#39;markdown-hide-urls)</p>

<p><br />
;;; Regular Expressions =======================================================</p>

<p>(defconst markdown-regex-comment-start<br />
&nbsp; &quot;&lt;!--&quot;<br />
&nbsp; &quot;Regular expression matches HTML comment opening.&quot;)</p>

<p>(defconst markdown-regex-comment-end<br />
&nbsp; &quot;--[ \t]*&gt;&quot;<br />
&nbsp; &quot;Regular expression matches HTML comment closing.&quot;)</p>

<p>(defconst markdown-regex-link-inline<br />
&nbsp; &quot;\\(!\\)?\\(\\[\\)\\([^]^][^]]*\\|\\)\\(\\]\\)\\((\\)\\([^)]*?\\)\\(?:\\s-+\\(\&quot;[^\&quot;]*\&quot;\\)\\)?\\()\\)&quot;<br />
&nbsp; &quot;Regular expression for a [text](file) or an image link ![text](file).<br />
Group 1 matches the leading exclamation point (optional).<br />
Group 2 matches the opening square bracket.<br />
Group 3 matches the text inside the square brackets.<br />
Group 4 matches the closing square bracket.<br />
Group 5 matches the opening parenthesis.<br />
Group 6 matches the URL.<br />
Group 7 matches the title (optional).<br />
Group 8 matches the closing parenthesis.&quot;)</p>

<p>(defconst markdown-regex-link-reference<br />
&nbsp; &quot;\\(!\\)?\\(\\[\\)\\([^]^][^]]*\\|\\)\\(\\]\\)[ ]?\\(\\[\\)\\([^]]*?\\)\\(\\]\\)&quot;<br />
&nbsp; &quot;Regular expression for a reference link [text][id].<br />
Group 1 matches the leading exclamation point (optional).<br />
Group 2 matches the opening square bracket for the link text.<br />
Group 3 matches the text inside the square brackets.<br />
Group 4 matches the closing square bracket for the link text.<br />
Group 5 matches the opening square bracket for the reference label.<br />
Group 6 matches the reference label.<br />
Group 7 matches the closing square bracket for the reference label.&quot;)</p>

<p>(defconst markdown-regex-reference-definition<br />
&nbsp; &quot;^ \\{0,3\\}\\(\\[\\)\\([^]\n]+?\\)\\(\\]\\)\\(:\\)\\s *\\(.*?\\)\\s *\\( \&quot;[^\&quot;]*\&quot;$\\|$\\)&quot;<br />
&nbsp; &quot;Regular expression for a reference definition.<br />
Group 1 matches the opening square bracket.<br />
Group 2 matches the reference label.<br />
Group 3 matches the closing square bracket.<br />
Group 4 matches the colon.<br />
Group 5 matches the URL.<br />
Group 6 matches the title attribute (optional).&quot;)</p>

<p>(defconst markdown-regex-footnote<br />
&nbsp; &quot;\\(\\[\\^\\)\\(.+?\\)\\(\\]\\)&quot;<br />
&nbsp; &quot;Regular expression for a footnote marker [^fn].<br />
Group 1 matches the opening square bracket and carat.<br />
Group 2 matches only the label, without the surrounding markup.<br />
Group 3 matches the closing square bracket.&quot;)</p>

<p>(defconst markdown-regex-header<br />
&nbsp; &quot;^\\(?:\\([^\r\n\t -].*\\)\n\\(?:\\(=+\\)\\|\\(-+\\)\\)\\|\\(#+[ \t]+\\)\\(.*?\\)\\([ \t]*#*\\)\\)$&quot;<br />
&nbsp; &quot;Regexp identifying Markdown headings.<br />
Group 1 matches the text of a setext heading.<br />
Group 2 matches the underline of a level-1 setext heading.<br />
Group 3 matches the underline of a level-2 setext heading.<br />
Group 4 matches the opening hash marks of an atx heading and whitespace.<br />
Group 5 matches the text, without surrounding whitespace, of an atx heading.<br />
Group 6 matches the closing whitespace and hash marks of an atx heading.&quot;)</p>

<p>(defconst markdown-regex-header-setext<br />
&nbsp; &quot;^\\([^\r\n\t -].*\\)\n\\(=+\\|-+\\)$&quot;<br />
&nbsp; &quot;Regular expression for generic setext-style (underline) headers.&quot;)</p>

<p>(defconst markdown-regex-header-atx<br />
&nbsp; &quot;^\\(#+\\)[ \t]+\\(.*?\\)[ \t]*\\(#*\\)$&quot;<br />
&nbsp; &quot;Regular expression for generic atx-style (hash mark) headers.&quot;)</p>

<p>(defconst markdown-regex-hr<br />
&nbsp; &quot;^\\(\\*[ ]?\\*[ ]?\\*[ ]?[\\* ]*\\|-[ ]?-[ ]?-[--- ]*\\)$&quot;<br />
&nbsp; &quot;Regular expression for matching Markdown horizontal rules.&quot;)</p>

<p>(defconst markdown-regex-code<br />
&nbsp; &quot;\\(?:\\`\\|[^\\]\\)\\(\\(`+\\)\\(\\(?:.\\|\n[^\n]\\)*?[^`]\\)\\(\\2\\)\\)\\(?:[^`]\\|\\&#39;\\)&quot;<br />
&nbsp; &quot;Regular expression for matching inline code fragments.</p>

<p>Group 1 matches the entire code fragment including the backquotes.<br />
Group 2 matches the opening backquotes.<br />
Group 3 matches the code fragment itself, without backquotes.<br />
Group 4 matches the closing backquotes.</p>

<p>The leading, unnumbered group ensures that the leading backquote<br />
character is not escaped.<br />
The last group, also unnumbered, requires that the character<br />
following the code fragment is not a backquote.<br />
Note that \\(?:.\\|\n[^\n]\\) matches any character, including newlines,<br />
but not two newlines in a row.&quot;)</p>

<p>(defconst markdown-regex-kbd<br />
&nbsp; &quot;\\(&lt;kbd&gt;\\)\\(\\(?:.\\|\n[^\n]\\)*?\\)\\(&lt;/kbd&gt;\\)&quot;<br />
&nbsp; &quot;Regular expression for matching &lt;kbd&gt; tags.<br />
Groups 1 and 3 match the opening and closing tags.<br />
Group 2 matches the key sequence.&quot;)</p>

<p>(defconst markdown-regex-gfm-code-block-open<br />
&nbsp; &quot;^[[:blank:]]*\\(```\\)\\([[:blank:]]*{?[[:blank:]]*\\)\\([^[:space:]]+?\\)?\\(?:[[:blank:]]+\\(.+?\\)\\)?\\([[:blank:]]*}?[[:blank:]]*\\)$&quot;<br />
&nbsp; &quot;Regular expression matching opening of GFM code blocks.<br />
Group 1 matches the opening three backquotes and any following whitespace.<br />
Group 2 matches the opening brace (optional) and surrounding whitespace.<br />
Group 3 matches the language identifier (optional).<br />
Group 4 matches the info string (optional).<br />
Group 5 matches the closing brace (optional), whitespace, and newline.<br />
Groups need to agree with `markdown-regex-tilde-fence-begin&#39;.&quot;)</p>

<p>(defconst markdown-regex-gfm-code-block-close<br />
&nbsp;&quot;^[[:blank:]]*\\(```\\)\\(\\s *?\\)$&quot;<br />
&nbsp;&quot;Regular expression matching closing of GFM code blocks.<br />
Group 1 matches the closing three backquotes.<br />
Group 2 matches any whitespace and the final newline.&quot;)</p>

<p>(defconst markdown-regex-pre<br />
&nbsp; &quot;^\\( &nbsp; &nbsp;\\|\t\\).*$&quot;<br />
&nbsp; &quot;Regular expression for matching preformatted text sections.&quot;)</p>

<p>(defconst markdown-regex-list<br />
&nbsp; &quot;^\\([ \t]*\\)\\([0-9#]+\\.\\|[\\*\\+:-]\\)\\([ \t]+\\)&quot;<br />
&nbsp; &quot;Regular expression for matching list items.&quot;)</p>

<p>(defconst markdown-regex-bold<br />
&nbsp; &quot;\\(^\\|[^\\]\\)\\(\\([*_]\\{2\\}\\)\\([^ \n\t\\]\\|[^ \n\t]\\(?:.\\|\n[^\n]\\)*?[^\\ ]\\)\\(\\3\\)\\)&quot;<br />
&nbsp; &quot;Regular expression for matching bold text.<br />
Group 1 matches the character before the opening asterisk or<br />
underscore, if any, ensuring that it is not a backslash escape.<br />
Group 2 matches the entire expression, including delimiters.<br />
Groups 3 and 5 matches the opening and closing delimiters.<br />
Group 4 matches the text inside the delimiters.&quot;)</p>

<p>(defconst markdown-regex-italic<br />
&nbsp; &quot;\\(?:^\\|[^\\]\\)\\(\\([*_]\\)\\([^ \n\t\\]\\|[^ \n\t]\\(?:.\\|\n[^\n]\\)*?[^\\ ]\\)\\(\\2\\)\\)&quot;<br />
&nbsp; &quot;Regular expression for matching italic text.<br />
The leading unnumbered matches the character before the opening<br />
asterisk or underscore, if any, ensuring that it is not a<br />
backslash escape.<br />
Group 1 matches the entire expression, including delimiters.<br />
Groups 2 and 4 matches the opening and closing delimiters.<br />
Group 3 matches the text inside the delimiters.&quot;)</p>

<p>(defconst markdown-regex-strike-through<br />
&nbsp; &quot;\\(^\\|[^\\]\\)\\(\\(~~\\)\\([^ \n\t\\]\\|[^ \n\t]\\(?:.\\|\n[^\n]\\)*?[^\\ ]\\)\\(~~\\)\\)&quot;<br />
&nbsp; &quot;Regular expression for matching strike-through text.<br />
Group 1 matches the character before the opening tilde, if any,<br />
ensuring that it is not a backslash escape.<br />
Group 2 matches the entire expression, including delimiters.<br />
Groups 3 and 5 matches the opening and closing delimiters.<br />
Group 4 matches the text inside the delimiters.&quot;)</p>

<p>(defconst markdown-regex-gfm-italic<br />
&nbsp; &quot;\\(?:^\\|\\s-\\)\\(\\([*_]\\)\\([^ \\]\\2\\|[^ ]\\(?:.\\|\n[^\n]\\)*?[^\\ ]\\)\\(\\2\\)\\)&quot;<br />
&nbsp; &quot;Regular expression for matching italic text in GitHub Flavored Markdown.<br />
Underscores in words are not treated as special.<br />
Group 1 matches the entire expression, including delimiters.<br />
Groups 2 and 4 matches the opening and closing delimiters.<br />
Group 3 matches the text inside the delimiters.&quot;)</p>

<p>(defconst markdown-regex-blockquote<br />
&nbsp; &quot;^[ \t]*\\([A-Z]?&gt;\\)\\([ \t]*\\)\\(.*\\)$&quot;<br />
&nbsp; &quot;Regular expression for matching blockquote lines.<br />
Also accounts for a potential capital letter preceding the angle<br />
bracket, for use with Leanpub blocks (asides, warnings, info<br />
blocks, etc.).<br />
Group 1 matches the leading angle bracket.<br />
Group 2 matches the separating whitespace.<br />
Group 3 matches the text.&quot;)</p>

<p>(defconst markdown-regex-line-break<br />
&nbsp; &quot;[^ \n\t][ \t]*\\( &nbsp;\\)$&quot;<br />
&nbsp; &quot;Regular expression for matching line breaks.&quot;)</p>

<p>(defconst markdown-regex-wiki-link<br />
&nbsp; &quot;\\(?:^\\|[^\\]\\)\\(\\(\\[\\[\\)\\([^]|]+\\)\\(?:\\(|\\)\\([^]]+\\)\\)?\\(\\]\\]\\)\\)&quot;<br />
&nbsp; &quot;Regular expression for matching wiki links.<br />
This matches typical bracketed [[WikiLinks]] as well as &#39;aliased&#39;<br />
wiki links of the form [[PageName|link text]].<br />
The meanings of the first and second components depend<br />
on the value of `markdown-wiki-link-alias-first&#39;.</p>

<p>Group 1 matches the entire link.<br />
Group 2 matches the opening square brackets.<br />
Group 3 matches the first component of the wiki link.<br />
Group 4 matches the pipe separator, when present.<br />
Group 5 matches the second component of the wiki link, when present.<br />
Group 6 matches the closing square brackets.&quot;)</p>

<p>(defconst markdown-regex-uri<br />
&nbsp; (concat &quot;\\(&quot; (regexp-opt markdown-uri-types) &quot;:[^]\t\n\r&lt;&gt;,;() ]+\\)&quot;)<br />
&nbsp; &quot;Regular expression for matching inline URIs.&quot;)</p>

<p>(defconst markdown-regex-angle-uri<br />
&nbsp; (concat &quot;\\(&lt;\\)\\(&quot; (regexp-opt markdown-uri-types) &quot;:[^]\t\n\r&lt;&gt;,;()]+\\)\\(&gt;\\)&quot;)<br />
&nbsp; &quot;Regular expression for matching inline URIs in angle brackets.&quot;)</p>

<p>(defconst markdown-regex-email<br />
&nbsp; &quot;&lt;\\(\\(?:\\sw\\|\\s_\\|\\s.\\)+@\\(?:\\sw\\|\\s_\\|\\s.\\)+\\)&gt;&quot;<br />
&nbsp; &quot;Regular expression for matching inline email addresses.&quot;)</p>

<p>(defsubst markdown-make-regex-link-generic ()<br />
&nbsp; &quot;Make regular expression for matching any recognized link.&quot;<br />
&nbsp; (concat &quot;\\(?:&quot; markdown-regex-link-inline<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when markdown-enable-wiki-links<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (concat &quot;\\|&quot; markdown-regex-wiki-link))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;\\|&quot; markdown-regex-link-reference<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;\\|&quot; markdown-regex-angle-uri &quot;\\)&quot;))</p>

<p>(defconst markdown-regex-gfm-checkbox<br />
&nbsp; &quot; \\(\\[[ xX]\\]\\) &quot;<br />
&nbsp; &quot;Regular expression for matching GFM checkboxes.<br />
Group 1 matches the text to become a button.&quot;)</p>

<p>(defconst markdown-regex-block-separator<br />
&nbsp; &quot;\n[\n\t\f ]*\n&quot;<br />
&nbsp; &quot;Regular expression for matching block boundaries.&quot;)</p>

<p>(defconst markdown-regex-block-separator-noindent<br />
&nbsp; (concat &quot;\\(\\`\\|\\(&quot; markdown-regex-block-separator &quot;\\)[^\n\t\f ]\\)&quot;)<br />
&nbsp; &quot;Regexp for block separators before lines with no indentation.&quot;)</p>

<p>(defconst markdown-regex-math-inline-single<br />
&nbsp; &quot;\\(?:^\\|[^\\]\\)\\(\\$\\)\\(\\(?:[^\\$]\\|\\\\.\\)*\\)\\(\\$\\)&quot;<br />
&nbsp; &quot;Regular expression for itex $..$ math mode expressions.<br />
Groups 1 and 3 match the opening and closing dollar signs.<br />
Group 3 matches the mathematical expression contained within.&quot;)</p>

<p>(defconst markdown-regex-math-inline-double<br />
&nbsp; &quot;\\(?:^\\|[^\\]\\)\\(\\$\\$\\)\\(\\(?:[^\\$]\\|\\\\.\\)*\\)\\(\\$\\$\\)&quot;<br />
&nbsp; &quot;Regular expression for itex $$..$$ math mode expressions.<br />
Groups 1 and 3 match opening and closing dollar signs.<br />
Group 3 matches the mathematical expression contained within.&quot;)</p>

<p>(defconst markdown-regex-math-display<br />
&nbsp; &quot;^\\(\\\\\\[\\)\\(\\(?:.\\|\n\\)*?\\)?\\(\\\\\\]\\)$&quot;<br />
&nbsp; &quot;Regular expression for itex \[..\] display mode expressions.<br />
Groups 1 and 3 match the opening and closing delimiters.<br />
Group 2 matches the mathematical expression contained within.&quot;)</p>

<p>(defsubst markdown-make-tilde-fence-regex (num-tildes &amp;optional end-of-line)<br />
&nbsp; &quot;Return regexp matching a tilde code fence at least NUM-TILDES long.<br />
END-OF-LINE is the regexp construct to indicate end of line; $ if<br />
missing.&quot;<br />
&nbsp; (format &quot;%s%d%s%s&quot; &quot;^[[:blank:]]*\\([~]\\{&quot; num-tildes &quot;,\\}\\)&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (or end-of-line &quot;$&quot;)))</p>

<p>(defconst markdown-regex-tilde-fence-begin<br />
&nbsp; (markdown-make-tilde-fence-regex<br />
&nbsp; &nbsp;3 &quot;\\([[:blank:]]*{?\\)[[:blank:]]*\\([^[:space:]]+?\\)?\\(?:[[:blank:]]+\\(.+?\\)\\)?\\([[:blank:]]*}?[[:blank:]]*\\)$&quot;)<br />
&nbsp; &quot;Regular expression for matching tilde-fenced code blocks.<br />
Group 1 matches the opening tildes.<br />
Group 2 matches (optional) opening brace and surrounding whitespace.<br />
Group 3 matches the language identifier (optional).<br />
Group 4 matches the info string (optional).<br />
Group 5 matches the closing brace (optional) and any surrounding whitespace.<br />
Groups need to agree with `markdown-regex-gfm-code-block-open&#39;.&quot;)</p>

<p>(defconst markdown-regex-declarative-metadata<br />
&nbsp; &quot;^\\([[:alpha:]][[:alpha:] _-]*?\\)\\([:=][ \t]*\\)\\(.*\\)$&quot;<br />
&nbsp; &quot;Regular expression for matching declarative metadata statements.<br />
This matches MultiMarkdown metadata as well as YAML and TOML<br />
assignments such as the following:</p>

<p>&nbsp; &nbsp; variable: value</p>

<p>or</p>

<p>&nbsp; &nbsp; variable = value&quot;)</p>

<p>(defconst markdown-regex-pandoc-metadata<br />
&nbsp; &quot;^\\(%\\)\\([ \t]*\\)\\(.*\\(?:\n[ \t]+.*\\)*\\)&quot;<br />
&nbsp; &quot;Regular expression for matching Pandoc metadata.&quot;)</p>

<p>(defconst markdown-regex-yaml-metadata-border<br />
&nbsp; &quot;\\(-\\{3\\}\\)$&quot;<br />
&nbsp; &quot;Regular expression for matching YAML metadata.&quot;)</p>

<p>(defconst markdown-regex-yaml-pandoc-metadata-end-border<br />
&nbsp; &quot;^\\(\\.\\{3\\}\\|\\-\\{3\\}\\)$&quot;<br />
&nbsp; &quot;Regular expression for matching YAML metadata end borders.&quot;)</p>

<p>(defsubst markdown-get-yaml-metadata-start-border ()<br />
&nbsp; &quot;Return YAML metadata start border depending upon whether Pandoc is used.&quot;<br />
&nbsp; (concat<br />
&nbsp; &nbsp;(if markdown-use-pandoc-style-yaml-metadata &quot;^&quot; &quot;\\`&quot;)<br />
&nbsp; &nbsp;markdown-regex-yaml-metadata-border))</p>

<p>(defsubst markdown-get-yaml-metadata-end-border (_)<br />
&nbsp; &quot;Return YAML metadata end border depending upon whether Pandoc is used.&quot;<br />
&nbsp; (if markdown-use-pandoc-style-yaml-metadata<br />
&nbsp; &nbsp; &nbsp; markdown-regex-yaml-pandoc-metadata-end-border<br />
&nbsp; &nbsp; markdown-regex-yaml-metadata-border))</p>

<p>(defconst markdown-regex-inline-attributes<br />
&nbsp; &quot;[ \t]*\\({:?\\)[ \t]*\\(\\(#[[:alpha:]_.:-]+\\|\\.[[:alpha:]_.:-]+\\|\\w+=[&#39;\&quot;]?[^\n&#39;\&quot;]*[&#39;\&quot;]?\\),?[ \t]*\\)+\\(}\\)[ \t]*$&quot;<br />
&nbsp; &quot;Regular expression for matching inline identifiers or attribute lists.<br />
Compatible with Pandoc, Python Markdown, PHP Markdown Extra, and Leanpub.&quot;)</p>

<p>(defconst markdown-regex-leanpub-sections<br />
&nbsp; (concat<br />
&nbsp; &nbsp;&quot;^\\({\\)\\(&quot;<br />
&nbsp; &nbsp;(regexp-opt &#39;(&quot;frontmatter&quot; &quot;mainmatter&quot; &quot;backmatter&quot; &quot;appendix&quot; &quot;pagebreak&quot;))<br />
&nbsp; &nbsp;&quot;\\)\\(}\\)[ \t]*\n&quot;)<br />
&nbsp; &quot;Regular expression for Leanpub section markers and related syntax.&quot;)</p>

<p>(defconst markdown-regex-sub-superscript<br />
&nbsp; &quot;\\(?:^\\|[^\\~^]\\)\\(\\([~^]\\)\\([[:alnum:]]+\\)\\(\\2\\)\\)&quot;<br />
&nbsp; &quot;The regular expression matching a sub- or superscript.<br />
The leading un-numbered group matches the character before the<br />
opening tilde or carat, if any, ensuring that it is not a<br />
backslash escape, carat, or tilde.<br />
Group 1 matches the entire expression, including markup.<br />
Group 2 matches the opening markup--a tilde or carat.<br />
Group 3 matches the text inside the delimiters.<br />
Group 4 matches the closing markup--a tilde or carat.&quot;)</p>

<p>(defconst markdown-regex-include<br />
&nbsp; &quot;^\\(&lt;&lt;\\)\\(?:\\(\\[\\)\\(.*\\)\\(\\]\\)\\)?\\(?:\\((\\)\\(.*\\)\\()\\)\\)?\\(?:\\({\\)\\(.*\\)\\(}\\)\\)?$&quot;<br />
&nbsp; &quot;Regular expression matching common forms of include syntax.<br />
Marked 2, Leanpub, and other processors support some of these forms:</p>

<p>&lt;&lt;[sections/section1.md]<br />
&lt;&lt;(folder/filename)<br />
&lt;&lt;[Code title](folder/filename)<br />
&lt;&lt;{folder/raw_file.html}</p>

<p>Group 1 matches the opening two angle brackets.<br />
Groups 2-4 match the opening square bracket, the text inside,<br />
and the closing square bracket, respectively.<br />
Groups 5-7 match the opening parenthesis, the text inside, and<br />
the closing parenthesis.<br />
Groups 8-10 match the opening brace, the text inside, and the brace.&quot;)</p>

<p>(defconst markdown-regex-pandoc-inline-footnote<br />
&nbsp; &quot;\\(\\^\\)\\(\\[\\)\\(\\(?:.\\|\n[^\n]\\)*?\\)\\(\\]\\)&quot;<br />
&nbsp; &quot;Regular expression for Pandoc inline footnote^[footnote text].<br />
Group 1 matches the opening caret.<br />
Group 2 matches the opening square bracket.<br />
Group 3 matches the footnote text, without the surrounding markup.<br />
Group 4 matches the closing square bracket.&quot;)</p>

<p><br />
;;; Syntax ====================================================================</p>

<p>(defsubst markdown-in-comment-p (&amp;optional pos)<br />
&nbsp; &quot;Return non-nil if POS is in a comment.<br />
If POS is not given, use point instead.&quot;<br />
&nbsp; (nth 4 (syntax-ppss pos)))</p>

<p>(defun markdown-syntax-propertize-extend-region (start end)<br />
&nbsp; &quot;Extend START to END region to include an entire block of text.<br />
This helps improve syntax analysis for block constructs.<br />
Returns a cons (NEW-START . NEW-END) or nil if no adjustment should be made.<br />
Function is called repeatedly until it returns nil. For details, see<br />
`syntax-propertize-extend-region-functions&#39;.&quot;<br />
&nbsp; (save-match-data<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (let* ((new-start (progn (goto-char start)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(skip-chars-forward &quot;\n&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(if (re-search-backward &quot;\n\n&quot; nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(min start (match-end 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(point-min))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(new-end (progn (goto-char end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(skip-chars-backward &quot;\n&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(if (re-search-forward &quot;\n\n&quot; nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(max end (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(point-max))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(code-match (markdown-code-block-at-pos new-start))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(new-start (or (and code-match (cl-first code-match)) new-start))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(code-match (and (&lt; end (point-max)) (markdown-code-block-at-pos end)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(new-end (or (and code-match (cl-second code-match)) new-end)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (unless (and (eq new-start start) (eq new-end end))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cons new-start (min new-end (point-max))))))))</p>

<p>(defun markdown-font-lock-extend-region-function (start end _)<br />
&nbsp; &quot;Used in `jit-lock-after-change-extend-region-functions&#39;.<br />
Delegates to `markdown-syntax-propertize-extend-region&#39;. START<br />
and END are the previous region to refontify.&quot;<br />
&nbsp; (let ((res (markdown-syntax-propertize-extend-region start end)))<br />
&nbsp; &nbsp; (when res<br />
&nbsp; &nbsp; &nbsp; ;; syntax-propertize-function is not called when character at<br />
&nbsp; &nbsp; &nbsp; ;; (point-max) is deleted, but font-lock-extend-region-functions<br />
&nbsp; &nbsp; &nbsp; ;; are called. &nbsp;Force a syntax property update in that case.<br />
&nbsp; &nbsp; &nbsp; (when (= end (point-max))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; This function is called in a buffer modification hook.<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; `markdown-syntax-propertize&#39; doesn&#39;t save the match data,<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; so we have to do it here.<br />
&nbsp; &nbsp; &nbsp; &nbsp; (save-match-data<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-syntax-propertize (car res) (cdr res))))<br />
&nbsp; &nbsp; &nbsp; (setq jit-lock-start (car res)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; jit-lock-end (cdr res)))))</p>

<p>(defun markdown-syntax-propertize-pre-blocks (start end)<br />
&nbsp; &quot;Match preformatted text blocks from START to END.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char start)<br />
&nbsp; &nbsp; (let ((levels (markdown-calculate-list-levels))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; indent pre-regexp close-regexp open close)<br />
&nbsp; &nbsp; &nbsp; (while (and (&lt; (point) end) (not close))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Search for a region with sufficient indentation<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (null levels)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq indent 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq indent (1+ (length levels))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq pre-regexp (format &quot;^\\( &nbsp; &nbsp;\\|\t\\)\\{%d\\}&quot; indent))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq close-regexp (format &quot;^\\( &nbsp; &nbsp;\\|\t\\)\\{0,%d\\}\\([^ \t]\\)&quot; (1- indent)))</p>

<p>&nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; If not at the beginning of a line, move forward<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((not (bolp)) (forward-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Move past blank lines<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((markdown-cur-line-blank) (forward-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; At headers and horizontal rules, reset levels<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((markdown-new-baseline) (forward-line) (setq levels nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; If the current line has sufficient indentation, mark out pre block<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; The opening should be preceded by a blank line.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((and (looking-at pre-regexp)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-prev-line-blank-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq open (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (while (and (or (looking-at-p pre-regexp) (markdown-cur-line-blank))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (eobp)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (skip-syntax-backward &quot;-&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq close (point)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; If current line has a list marker, update levels, move to end of block<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((looking-at markdown-regex-list)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq levels (markdown-update-list-levels<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-string 2) (current-indentation) levels))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-end-of-text-block))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; If this is the end of the indentation level, adjust levels accordingly.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Only match end of indentation level if levels is not the empty list.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((and (car levels) (looking-at-p close-regexp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq levels (markdown-update-list-levels<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil (current-indentation) levels))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-end-of-text-block))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(t (markdown-end-of-text-block))))</p>

<p>&nbsp; &nbsp; &nbsp; (when (and open close)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Set text property data<br />
&nbsp; &nbsp; &nbsp; &nbsp; (put-text-property open close &#39;markdown-pre (list open close))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Recursively search again<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-syntax-propertize-pre-blocks (point) end)))))</p>

<p>(defconst markdown-fenced-block-pairs<br />
&nbsp; `(((,markdown-regex-tilde-fence-begin markdown-tilde-fence-begin)<br />
&nbsp; &nbsp; &nbsp;(markdown-make-tilde-fence-regex markdown-tilde-fence-end)<br />
&nbsp; &nbsp; &nbsp;markdown-fenced-code)<br />
&nbsp; &nbsp; ((markdown-get-yaml-metadata-start-border markdown-yaml-metadata-begin)<br />
&nbsp; &nbsp; &nbsp;(markdown-get-yaml-metadata-end-border markdown-yaml-metadata-end)<br />
&nbsp; &nbsp; &nbsp;markdown-yaml-metadata-section)<br />
&nbsp; &nbsp; ((,markdown-regex-gfm-code-block-open markdown-gfm-block-begin)<br />
&nbsp; &nbsp; &nbsp;(,markdown-regex-gfm-code-block-close markdown-gfm-block-end)<br />
&nbsp; &nbsp; &nbsp;markdown-gfm-code))<br />
&nbsp; &quot;Mapping of regular expressions to \&quot;fenced-block\&quot; constructs.<br />
These constructs are distinguished by having a distinctive start<br />
and end pattern, both of which take up an entire line of text,<br />
but no special pattern to identify text within the fenced<br />
blocks (unlike blockquotes and indented-code sections).</p>

<p>Each element within this list takes the form:</p>

<p>&nbsp; ((START-REGEX-OR-FUN START-PROPERTY)<br />
&nbsp; &nbsp;(END-REGEX-OR-FUN END-PROPERTY)<br />
&nbsp; &nbsp;MIDDLE-PROPERTY)</p>

<p>Each *-REGEX-OR-FUN element can be a regular expression as a string, or a<br />
function which evaluates to same. Functions for START-REGEX-OR-FUN accept no<br />
arguments, but functions for END-REGEX-OR-FUN accept a single numerical argument<br />
which is the length of the first group of the START-REGEX-OR-FUN match, which<br />
can be ignored if unnecessary. `markdown-maybe-funcall-regexp&#39; is used to<br />
evaluate these into \&quot;real\&quot; regexps.</p>

<p>The *-PROPERTY elements are the text properties applied to each part of the<br />
block construct when it is matched using<br />
`markdown-syntax-propertize-fenced-block-constructs&#39;. START-PROPERTY is applied<br />
to the text matching START-REGEX-OR-FUN, END-PROPERTY to END-REGEX-OR-FUN, and<br />
MIDDLE-PROPERTY to the text in between the two. The value of *-PROPERTY is the<br />
`match-data&#39; when the regexp was matched to the text. In the case of<br />
MIDDLE-PROPERTY, the value is a false match data of the form &#39;(begin end), with<br />
begin and end set to the edges of the \&quot;middle\&quot; text. This makes fontification<br />
easier.&quot;)</p>

<p>(defun markdown-text-property-at-point (prop)<br />
&nbsp; (get-text-property (point) prop))</p>

<p>(defsubst markdown-maybe-funcall-regexp (object &amp;optional arg)<br />
&nbsp; (cond ((functionp object)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(if arg (funcall object arg) (funcall object)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ((stringp object) object)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (t (error &quot;Object cannot be turned into regex&quot;))))</p>

<p>(defsubst markdown-get-start-fence-regexp ()<br />
&nbsp; &quot;Return regexp to find all \&quot;start\&quot; sections of fenced block constructs.<br />
Which construct is actually contained in the match must be found separately.&quot;<br />
&nbsp; (mapconcat<br />
&nbsp; &nbsp;#&#39;identity<br />
&nbsp; &nbsp;(mapcar (lambda (entry) (markdown-maybe-funcall-regexp (caar entry)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-fenced-block-pairs)<br />
&nbsp; &nbsp;&quot;\\|&quot;))</p>

<p>(defun markdown-get-fenced-block-begin-properties ()<br />
&nbsp; (cl-mapcar (lambda (entry) (cl-cadar entry)) markdown-fenced-block-pairs))</p>

<p>(defun markdown-get-fenced-block-end-properties ()<br />
&nbsp; (cl-mapcar (lambda (entry) (cl-cadadr entry)) markdown-fenced-block-pairs))</p>

<p>(defun markdown-get-fenced-block-middle-properties ()<br />
&nbsp; (cl-mapcar #&#39;cl-third markdown-fenced-block-pairs))</p>

<p>(defun markdown-find-previous-prop (prop &amp;optional lim)<br />
&nbsp; &quot;Find previous place where property PROP is non-nil, up to LIM.<br />
Return a cons of (pos . property). pos is point if point contains<br />
non-nil PROP.&quot;<br />
&nbsp; (let ((res<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(if (get-text-property (point) prop) (point)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(previous-single-property-change<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (point) prop nil (or lim (point-min))))))<br />
&nbsp; &nbsp; (when (and (not (get-text-property res prop))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(&gt; res (point-min))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(get-text-property (1- res) prop))<br />
&nbsp; &nbsp; &nbsp; (cl-decf res))<br />
&nbsp; &nbsp; (when (and res (get-text-property res prop)) (cons res prop))))</p>

<p>(defun markdown-find-next-prop (prop &amp;optional lim)<br />
&nbsp; &quot;Find next place where property PROP is non-nil, up to LIM.<br />
Return a cons of (POS . PROPERTY) where POS is point if point<br />
contains non-nil PROP.&quot;<br />
&nbsp; (let ((res<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(if (get-text-property (point) prop) (point)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(next-single-property-change<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (point) prop nil (or lim (point-max))))))<br />
&nbsp; &nbsp; (when (and res (get-text-property res prop)) (cons res prop))))</p>

<p>(defun markdown-min-of-seq (map-fn seq)<br />
&nbsp; &quot;Apply MAP-FN to SEQ and return element of SEQ with minimum value of MAP-FN.&quot;<br />
&nbsp; (cl-loop for el in seq<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;with min = 1.0e+INF &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;; infinity<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;with min-el = nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;do (let ((res (funcall map-fn el)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (&lt; res min)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq min res)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq min-el el)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;finally return min-el))</p>

<p>(defun markdown-max-of-seq (map-fn seq)<br />
&nbsp; &quot;Apply MAP-FN to SEQ and return element of SEQ with maximum value of MAP-FN.&quot;<br />
&nbsp; (cl-loop for el in seq<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;with max = -1.0e+INF &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;; negative infinity<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;with max-el = nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;do (let ((res (funcall map-fn el)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (and res (&gt; res max))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq max res)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq max-el el)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;finally return max-el))</p>

<p>(defun markdown-find-previous-block ()<br />
&nbsp; &quot;Find previous block.<br />
Detect whether `markdown-syntax-propertize-fenced-block-constructs&#39; was<br />
unable to propertize the entire block, but was able to propertize the beginning<br />
of the block. If so, return a cons of (pos . property) where the beginning of<br />
the block was propertized.&quot;<br />
&nbsp; (let ((start-pt (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (closest-open<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-max-of-seq<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;car<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-remove-if<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#&#39;null<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cl-mapcar<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown-find-previous-prop<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-get-fenced-block-begin-properties))))))<br />
&nbsp; &nbsp; (when closest-open<br />
&nbsp; &nbsp; &nbsp; (let* ((length-of-open-match<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((match-d<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(get-text-property (car closest-open) (cdr closest-open))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (- (cl-fourth match-d) (cl-third match-d))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(end-regexp<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-maybe-funcall-regexp<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cl-caadr<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-find-if<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(lambda (entry) (eq (cl-cadar entry) (cdr closest-open)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-fenced-block-pairs))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;length-of-open-match))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(end-prop-loc<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-match-data<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (car closest-open))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (and (re-search-forward end-regexp start-pt t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-beginning 0))))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (and (not end-prop-loc) closest-open)))))</p>

<p>(defun markdown-get-fenced-block-from-start (prop)<br />
&nbsp; &quot;Return limits of an enclosing fenced block from its start, using PROP.<br />
Return value is a list usable as `match-data&#39;.&quot;<br />
&nbsp; (catch &#39;no-rest-of-block<br />
&nbsp; &nbsp; (let* ((correct-entry<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-find-if<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(lambda (entry) (eq (cl-cadar entry) prop))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-fenced-block-pairs))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(begin-of-begin (cl-first (markdown-text-property-at-point prop)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(middle-prop (cl-third correct-entry))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(end-prop (cl-cadadr correct-entry))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(end-of-end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-end 0)) &nbsp; ; end of begin<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless (eobp) (forward-char))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((mid-prop-v (markdown-text-property-at-point middle-prop)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (not mid-prop-v) &nbsp; &nbsp;; no middle<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; try to find end by advancing one<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((end-prop-v<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-text-property-at-point end-prop)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if end-prop-v (cl-second end-prop-v)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (throw &#39;no-rest-of-block nil))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (set-match-data mid-prop-v)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-end 0)) &nbsp; ; end of middle<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (beginning-of-line) &nbsp; &nbsp; &nbsp; &nbsp; ; into end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-second (markdown-text-property-at-point end-prop)))))))<br />
&nbsp; &nbsp; &nbsp; (list begin-of-begin end-of-end))))</p>

<p>(defun markdown-get-fenced-block-from-middle (prop)<br />
&nbsp; &quot;Return limits of an enclosing fenced block from its middle, using PROP.<br />
Return value is a list usable as `match-data&#39;.&quot;<br />
&nbsp; (let* ((correct-entry<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-find-if<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(lambda (entry) (eq (cl-third entry) prop))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-fenced-block-pairs))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(begin-prop (cl-cadar correct-entry))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(begin-of-begin<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless (bobp) (forward-line -1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (beginning-of-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-first (markdown-text-property-at-point begin-prop))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(end-prop (cl-cadadr correct-entry))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(end-of-end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-end 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (beginning-of-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-second (markdown-text-property-at-point end-prop)))))<br />
&nbsp; &nbsp; (list begin-of-begin end-of-end)))</p>

<p>(defun markdown-get-fenced-block-from-end (prop)<br />
&nbsp; &quot;Return limits of an enclosing fenced block from its end, using PROP.<br />
Return value is a list usable as `match-data&#39;.&quot;<br />
&nbsp; (let* ((correct-entry<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-find-if<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(lambda (entry) (eq (cl-cadadr entry) prop))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-fenced-block-pairs))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(end-of-end (cl-second (markdown-text-property-at-point prop)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(middle-prop (cl-third correct-entry))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(begin-prop (cl-cadar correct-entry))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(begin-of-begin<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-beginning 0)) ; beginning of end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless (bobp) (backward-char)) ; into middle<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((mid-prop-v (markdown-text-property-at-point middle-prop)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (not mid-prop-v)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (beginning-of-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-first (markdown-text-property-at-point begin-prop)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (set-match-data mid-prop-v)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-beginning 0)) &nbsp; ; beginning of middle<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless (bobp) (forward-line -1)) ; into beginning<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (beginning-of-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-first (markdown-text-property-at-point begin-prop)))))))<br />
&nbsp; &nbsp; (list begin-of-begin end-of-end)))</p>

<p>(defun markdown-get-enclosing-fenced-block-construct (&amp;optional pos)<br />
&nbsp; &quot;Get \&quot;fake\&quot; match data for block enclosing POS.<br />
Returns fake match data which encloses the start, middle, and end<br />
of the block construct enclosing POS, if it exists. Used in<br />
`markdown-code-block-at-pos&#39;.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (when pos (goto-char pos))<br />
&nbsp; &nbsp; (beginning-of-line)<br />
&nbsp; &nbsp; (car<br />
&nbsp; &nbsp; &nbsp;(cl-remove-if<br />
&nbsp; &nbsp; &nbsp; #&#39;null<br />
&nbsp; &nbsp; &nbsp; (cl-mapcar<br />
&nbsp; &nbsp; &nbsp; &nbsp;(lambda (fun-and-prop)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cl-destructuring-bind (fun prop) fun-and-prop<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(when prop<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(save-match-data<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(set-match-data (markdown-text-property-at-point prop))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(funcall fun prop)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp;`((markdown-get-fenced-block-from-start<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,(cl-find-if<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown-text-property-at-point<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-get-fenced-block-begin-properties)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-get-fenced-block-from-middle<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,(cl-find-if<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown-text-property-at-point<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-get-fenced-block-middle-properties)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-get-fenced-block-from-end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,(cl-find-if<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown-text-property-at-point<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-get-fenced-block-end-properties)))))))))</p>

<p>(defun markdown-propertize-end-match (reg end fence-spec middle-begin)<br />
&nbsp; &quot;Get match for REG up to END, if exists, and propertize appropriately.<br />
FENCE-SPEC is an entry in `markdown-fenced-block-pairs&#39; and<br />
MIDDLE-BEGIN is the start of the \&quot;middle\&quot; section of the block.&quot;<br />
&nbsp; (when (re-search-forward reg end t)<br />
&nbsp; &nbsp; (let ((close-begin (match-beginning 0)) ; Start of closing line.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (close-end (match-end 0)) &nbsp; &nbsp; &nbsp; &nbsp; ; End of closing line.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (close-data (match-data t))) &nbsp; &nbsp; &nbsp;; Match data for closing line.<br />
&nbsp; &nbsp; &nbsp; ;; Propertize middle section of fenced block.<br />
&nbsp; &nbsp; &nbsp; (put-text-property middle-begin close-begin<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cl-third fence-spec)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(list middle-begin close-begin))<br />
&nbsp; &nbsp; &nbsp; ;; Propertize closing line of fenced block.<br />
&nbsp; &nbsp; &nbsp; (put-text-property close-begin close-end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cl-cadadr fence-spec) close-data))))</p>

<p>(defun markdown-syntax-propertize-fenced-block-constructs (start end)<br />
&nbsp; &quot;Propertize according to `markdown-fenced-block-pairs&#39; from START to END.<br />
If unable to propertize an entire block (if the start of a block is within START<br />
and END, but the end of the block is not), propertize the start section of a<br />
block, then in a subsequent call propertize both middle and end by finding the<br />
start which was previously propertized.&quot;<br />
&nbsp; (let ((start-reg (markdown-get-start-fence-regexp)))<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (goto-char start)<br />
&nbsp; &nbsp; &nbsp; ;; start from previous unclosed block, if exists<br />
&nbsp; &nbsp; &nbsp; (let ((prev-begin-block (markdown-find-previous-block)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when prev-begin-block<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let* ((correct-entry<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-find-if (lambda (entry)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (eq (cdr prev-begin-block) (cl-cadar entry)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; markdown-fenced-block-pairs))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(enclosed-text-start (1+ (car prev-begin-block)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(start-length<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (car prev-begin-block))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (string-match<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-maybe-funcall-regexp<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (caar correct-entry))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(buffer-substring<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (point-at-bol) (point-at-eol)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (- (match-end 1) (match-beginning 1))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(end-reg (markdown-maybe-funcall-regexp<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cl-caadr correct-entry) start-length)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-propertize-end-match<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;end-reg end correct-entry enclosed-text-start))))<br />
&nbsp; &nbsp; &nbsp; ;; find all new blocks within region<br />
&nbsp; &nbsp; &nbsp; (while (re-search-forward start-reg end t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; we assume the opening constructs take up (only) an entire line,<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; so we re-check the current line<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let* ((cur-line (buffer-substring (point-at-bol) (point-at-eol)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; find entry in `markdown-fenced-block-pairs&#39; corresponding<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; to regex which was matched<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(correct-entry<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-find-if<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(lambda (fenced-pair)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(string-match-p<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-maybe-funcall-regexp (caar fenced-pair))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; cur-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-fenced-block-pairs))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(enclosed-text-start<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-excursion (1+ (point-at-eol))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(end-reg<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-maybe-funcall-regexp<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cl-caadr correct-entry)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(if (and (match-beginning 1) (match-end 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(- (match-end 1) (match-beginning 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; get correct match data<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (beginning-of-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-forward<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-maybe-funcall-regexp (caar correct-entry))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(point-at-eol)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; mark starting, even if ending is outside of region<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (put-text-property (match-beginning 0) (match-end 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cl-cadar correct-entry) (match-data t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-propertize-end-match<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;end-reg end correct-entry enclosed-text-start))))))</p>

<p>(defun markdown-syntax-propertize-blockquotes (start end)<br />
&nbsp; &quot;Match blockquotes from START to END.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char start)<br />
&nbsp; &nbsp; (while (and (re-search-forward markdown-regex-blockquote end t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (markdown-code-block-at-pos (match-beginning 0))))<br />
&nbsp; &nbsp; &nbsp; (put-text-property (match-beginning 0) (match-end 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;markdown-blockquote<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-data t)))))</p>

<p>(defun markdown-syntax-propertize-hrs (start end)<br />
&nbsp; &quot;Match horizontal rules from START to END.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char start)<br />
&nbsp; &nbsp; (while (re-search-forward markdown-regex-hr end t)<br />
&nbsp; &nbsp; &nbsp; (unless (or (markdown-on-heading-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-code-block-at-point-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (put-text-property (match-beginning 0) (match-end 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;markdown-hr<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-data t))))))</p>

<p>(defun markdown-syntax-propertize-yaml-metadata (start end)<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char start)<br />
&nbsp; &nbsp; (cl-loop<br />
&nbsp; &nbsp; &nbsp;while (re-search-forward markdown-regex-declarative-metadata end t)<br />
&nbsp; &nbsp; &nbsp;do (when (get-text-property (match-beginning 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;markdown-yaml-metadata-section)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (put-text-property (match-beginning 1) (match-end 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;markdown-metadata-key (match-data t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (put-text-property (match-beginning 2) (match-end 2)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;markdown-metadata-markup (match-data t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (put-text-property (match-beginning 3) (match-end 3)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;markdown-metadata-value (match-data t))))))</p>

<p>(defun markdown-syntax-propertize-headings (start end)<br />
&nbsp; &quot;Match headings of type SYMBOL with REGEX from START to END.&quot;<br />
&nbsp; (goto-char start)<br />
&nbsp; (while (re-search-forward markdown-regex-header end t)<br />
&nbsp; &nbsp; (unless (markdown-code-block-at-pos (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; (put-text-property<br />
&nbsp; &nbsp; &nbsp; &nbsp;(match-beginning 0) (match-end 0) &#39;markdown-heading<br />
&nbsp; &nbsp; &nbsp; &nbsp;(match-data t))<br />
&nbsp; &nbsp; &nbsp; (put-text-property<br />
&nbsp; &nbsp; &nbsp; &nbsp;(match-beginning 0) (match-end 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp;(cond ((match-string-no-properties 2) &#39;markdown-heading-1-setext)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((match-string-no-properties 3) &#39;markdown-heading-2-setext)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(t (let ((atx-level (length (markdown-trim-whitespace<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-string-no-properties 4)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (intern (format &quot;markdown-heading-%d-atx&quot; atx-level)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp;(match-data t)))))</p>

<p>(defun markdown-syntax-propertize-comments (start end)<br />
&nbsp; &quot;Match HTML comments from the START to END.&quot;<br />
&nbsp; (let* ((in-comment (markdown-in-comment-p)))<br />
&nbsp; &nbsp; (goto-char start)<br />
&nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp;;; Comment start<br />
&nbsp; &nbsp; &nbsp;((and (not in-comment)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(re-search-forward markdown-regex-comment-start end t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (markdown-inline-code-at-point-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (markdown-code-block-at-point-p)))<br />
&nbsp; &nbsp; &nbsp; (let ((open-beg (match-beginning 0)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (put-text-property open-beg (1+ open-beg)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;syntax-table (string-to-syntax &quot;&lt;&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-syntax-propertize-comments<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(min (1+ (match-end 0)) end (point-max)) end)))<br />
&nbsp; &nbsp; &nbsp;;; Comment end<br />
&nbsp; &nbsp; &nbsp;((and in-comment<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(re-search-forward markdown-regex-comment-end end t))<br />
&nbsp; &nbsp; &nbsp; (put-text-property (1- (match-end 0)) (match-end 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;syntax-table (string-to-syntax &quot;&gt;&quot;))<br />
&nbsp; &nbsp; &nbsp; (markdown-syntax-propertize-comments<br />
&nbsp; &nbsp; &nbsp; &nbsp;(min (1+ (match-end 0)) end (point-max)) end))<br />
&nbsp; &nbsp; &nbsp;;; Nothing found<br />
&nbsp; &nbsp; &nbsp;(t nil))))</p>

<p>(defvar markdown--syntax-properties<br />
&nbsp; (list &#39;markdown-tilde-fence-begin nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-tilde-fence-end nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-fenced-code nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-yaml-metadata-begin nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-yaml-metadata-end nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-yaml-metadata-section nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-gfm-block-begin nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-gfm-block-end nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-gfm-code nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-pre nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-blockquote nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-hr nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-heading nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-heading-1-setext nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-heading-2-setext nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-heading-1-atx nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-heading-2-atx nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-heading-3-atx nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-heading-4-atx nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-heading-5-atx nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-heading-6-atx nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-metadata-key nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-metadata-value nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-metadata-markup nil)<br />
&nbsp; &quot;Property list of all Markdown syntactic properties.&quot;)</p>

<p>(defun markdown-syntax-propertize (start end)<br />
&nbsp; &quot;Function used as `syntax-propertize-function&#39;.<br />
START and END delimit region to propertize.&quot;<br />
&nbsp; (with-silent-modifications<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (remove-text-properties start end markdown--syntax-properties)<br />
&nbsp; &nbsp; &nbsp; (markdown-syntax-propertize-fenced-block-constructs start end)<br />
&nbsp; &nbsp; &nbsp; (markdown-syntax-propertize-yaml-metadata start end)<br />
&nbsp; &nbsp; &nbsp; (markdown-syntax-propertize-pre-blocks start end)<br />
&nbsp; &nbsp; &nbsp; (markdown-syntax-propertize-blockquotes start end)<br />
&nbsp; &nbsp; &nbsp; (markdown-syntax-propertize-headings start end)<br />
&nbsp; &nbsp; &nbsp; (markdown-syntax-propertize-hrs start end)<br />
&nbsp; &nbsp; &nbsp; (markdown-syntax-propertize-comments start end))))</p>

<p><br />
;;; Markup Hiding</p>

<p>(defconst markdown-markup-properties<br />
&nbsp; &#39;(face markdown-markup-face invisible markdown-markup)<br />
&nbsp; &quot;List of properties and values to apply to markup.&quot;)</p>

<p>(defconst markdown-language-keyword-properties<br />
&nbsp; &#39;(face markdown-language-keyword-face invisible markdown-markup)<br />
&nbsp; &quot;List of properties and values to apply to code block language names.&quot;)</p>

<p>(defconst markdown-language-info-properties<br />
&nbsp; &#39;(face markdown-language-info-face invisible markdown-markup)<br />
&nbsp; &quot;List of properties and values to apply to code block language info strings.&quot;)</p>

<p>(defconst markdown-include-title-properties<br />
&nbsp; &#39;(face markdown-link-title-face invisible markdown-markup)<br />
&nbsp; &quot;List of properties and values to apply to included code titles.&quot;)</p>

<p>(defconst markdown-inline-footnote-properties<br />
&nbsp; &#39;(face nil display ((raise 0.2) (height 0.8)))<br />
&nbsp; &quot;Properties to apply to footnote markers and inline footnotes.&quot;)</p>

<p>(defcustom markdown-hide-markup nil<br />
&nbsp; &quot;Determines whether markup in the buffer will be hidden.<br />
When set to nil, all markup is displayed in the buffer as it<br />
appears in the file. &nbsp;An exception is when `markdown-hide-urls&#39;<br />
is non-nil.<br />
Set this to a non-nil value to turn this feature on by default.<br />
You can interactively toggle the value of this variable with<br />
`markdown-toggle-markup-hiding&#39;, \\[markdown-toggle-markup-hiding],<br />
or from the Markdown &gt; Show &amp; Hide menu.</p>

<p>Markup hiding works by adding text properties to positions in the<br />
buffer---either the `invisible&#39; property or the `display&#39; property<br />
in cases where alternative glyphs are used (e.g., list bullets).<br />
This does not, however, affect printing or other output.<br />
Functions such as `htmlfontify-buffer&#39; and `ps-print-buffer&#39; will<br />
not honor these text properties. &nbsp;For printing, it would be better<br />
to first convert to HTML or PDF (e.g,. using Pandoc).&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean<br />
&nbsp; :safe &#39;booleanp<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.3&quot;))<br />
(make-variable-buffer-local &#39;markdown-hide-markup)</p>

<p>(defun markdown-toggle-markup-hiding (&amp;optional arg)<br />
&nbsp; &quot;Toggle the display or hiding of markup.<br />
With a prefix argument ARG, enable markup hiding if ARG is positive,<br />
and disable it otherwise.<br />
See `markdown-hide-markup&#39; for additional details.&quot;<br />
&nbsp; (interactive (list (or current-prefix-arg &#39;toggle)))<br />
&nbsp; (setq markdown-hide-markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (eq arg &#39;toggle)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not markdown-hide-markup)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&gt; (prefix-numeric-value arg) 0)))<br />
&nbsp; (if markdown-hide-markup<br />
&nbsp; &nbsp; &nbsp; (progn (add-to-invisibility-spec &#39;markdown-markup)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(message &quot;markdown-mode markup hiding enabled&quot;))<br />
&nbsp; &nbsp; (progn (remove-from-invisibility-spec &#39;markdown-markup)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(message &quot;markdown-mode markup hiding disabled&quot;)))<br />
&nbsp; (markdown-reload-extensions))</p>

<p><br />
;;; Font Lock =================================================================</p>

<p>(require &#39;font-lock)</p>

<p>(defvar markdown-italic-face &#39;markdown-italic-face<br />
&nbsp; &quot;Face name to use for italic text.&quot;)</p>

<p>(defvar markdown-bold-face &#39;markdown-bold-face<br />
&nbsp; &quot;Face name to use for bold text.&quot;)</p>

<p>(defvar markdown-strike-through-face &#39;markdown-strike-through-face<br />
&nbsp; &quot;Face name to use for strike-through text.&quot;)</p>

<p>(defvar markdown-header-delimiter-face &#39;markdown-header-delimiter-face<br />
&nbsp; &quot;Face name to use as a base for header delimiters.&quot;)</p>

<p>(defvar markdown-header-rule-face &#39;markdown-header-rule-face<br />
&nbsp; &quot;Face name to use as a base for header rules.&quot;)</p>

<p>(defvar markdown-header-face &#39;markdown-header-face<br />
&nbsp; &quot;Face name to use as a base for headers.&quot;)</p>

<p>(defvar markdown-header-face-1 &#39;markdown-header-face-1<br />
&nbsp; &quot;Face name to use for level-1 headers.&quot;)</p>

<p>(defvar markdown-header-face-2 &#39;markdown-header-face-2<br />
&nbsp; &quot;Face name to use for level-2 headers.&quot;)</p>

<p>(defvar markdown-header-face-3 &#39;markdown-header-face-3<br />
&nbsp; &quot;Face name to use for level-3 headers.&quot;)</p>

<p>(defvar markdown-header-face-4 &#39;markdown-header-face-4<br />
&nbsp; &quot;Face name to use for level-4 headers.&quot;)</p>

<p>(defvar markdown-header-face-5 &#39;markdown-header-face-5<br />
&nbsp; &quot;Face name to use for level-5 headers.&quot;)</p>

<p>(defvar markdown-header-face-6 &#39;markdown-header-face-6<br />
&nbsp; &quot;Face name to use for level-6 headers.&quot;)</p>

<p>(defvar markdown-inline-code-face &#39;markdown-inline-code-face<br />
&nbsp; &quot;Face name to use for inline code.&quot;)</p>

<p>(defvar markdown-list-face &#39;markdown-list-face<br />
&nbsp; &quot;Face name to use for list markers.&quot;)</p>

<p>(defvar markdown-blockquote-face &#39;markdown-blockquote-face<br />
&nbsp; &quot;Face name to use for blockquote.&quot;)</p>

<p>(defvar markdown-pre-face &#39;markdown-pre-face<br />
&nbsp; &quot;Face name to use for preformatted text.&quot;)</p>

<p>(defvar markdown-language-keyword-face &#39;markdown-language-keyword-face<br />
&nbsp; &quot;Face name to use for programming language identifiers.&quot;)</p>

<p>(defvar markdown-language-info-face &#39;markdown-language-info-face<br />
&nbsp; &quot;Face name to use for programming info strings.&quot;)</p>

<p>(defvar markdown-link-face &#39;markdown-link-face<br />
&nbsp; &quot;Face name to use for links.&quot;)</p>

<p>(defvar markdown-missing-link-face &#39;markdown-missing-link-face<br />
&nbsp; &quot;Face name to use for links where the linked file does not exist.&quot;)</p>

<p>(defvar markdown-reference-face &#39;markdown-reference-face<br />
&nbsp; &quot;Face name to use for reference.&quot;)</p>

<p>(defvar markdown-footnote-marker-face &#39;markdown-footnote-marker-face<br />
&nbsp; &quot;Face name to use for footnote markers.&quot;)</p>

<p>(defvar markdown-url-face &#39;markdown-url-face<br />
&nbsp; &quot;Face name to use for URLs.&quot;)</p>

<p>(defvar markdown-link-title-face &#39;markdown-link-title-face<br />
&nbsp; &quot;Face name to use for reference link titles.&quot;)</p>

<p>(defvar markdown-line-break-face &#39;markdown-line-break-face<br />
&nbsp; &quot;Face name to use for hard line breaks.&quot;)</p>

<p>(defvar markdown-comment-face &#39;markdown-comment-face<br />
&nbsp; &quot;Face name to use for HTML comments.&quot;)</p>

<p>(defvar markdown-math-face &#39;markdown-math-face<br />
&nbsp; &quot;Face name to use for LaTeX expressions.&quot;)</p>

<p>(defvar markdown-metadata-key-face &#39;markdown-metadata-key-face<br />
&nbsp; &quot;Face name to use for metadata keys.&quot;)</p>

<p>(defvar markdown-metadata-value-face &#39;markdown-metadata-value-face<br />
&nbsp; &quot;Face name to use for metadata values.&quot;)</p>

<p>(defvar markdown-gfm-checkbox-face &#39;markdown-gfm-checkbox-face<br />
&nbsp; &quot;Face name to use for GFM checkboxes.&quot;)</p>

<p>(defvar markdown-highlight-face &#39;markdown-highlight-face<br />
&nbsp; &quot;Face name to use for mouse highlighting.&quot;)</p>

<p>(defvar markdown-markup-face &#39;markdown-markup-face<br />
&nbsp; &quot;Face name to use for markup elements.&quot;)</p>

<p>(defgroup markdown-faces nil<br />
&nbsp; &quot;Faces used in Markdown Mode&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :group &#39;faces)</p>

<p>(defface markdown-italic-face<br />
&nbsp; &#39;((t (:inherit italic)))<br />
&nbsp; &quot;Face for italic text.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-bold-face<br />
&nbsp; &#39;((t (:inherit bold)))<br />
&nbsp; &quot;Face for bold text.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-strike-through-face<br />
&nbsp; &#39;((t (:strike-through t)))<br />
&nbsp; &quot;Face for strike-through text.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-markup-face<br />
&nbsp; &#39;((t (:inherit shadow :slant normal :weight normal)))<br />
&nbsp; &quot;Face for markup elements.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-header-rule-face<br />
&nbsp; &#39;((t (:inherit markdown-markup-face)))<br />
&nbsp; &quot;Base face for headers rules.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-header-delimiter-face<br />
&nbsp; &#39;((t (:inherit markdown-markup-face)))<br />
&nbsp; &quot;Base face for headers hash delimiter.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-list-face<br />
&nbsp; &#39;((t (:inherit markdown-markup-face)))<br />
&nbsp; &quot;Face for list item markers.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-blockquote-face<br />
&nbsp; &#39;((t (:inherit font-lock-doc-face)))<br />
&nbsp; &quot;Face for blockquote sections.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-code-face<br />
&nbsp; (let* ((default-bg (or (face-background &#39;default) &quot;unspecified-bg&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(light-bg (if (equal default-bg &quot;unspecified-bg&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;unspecified-bg&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(color-darken-name default-bg 3)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(dark-bg (if (equal default-bg &quot;unspecified-bg&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;unspecified-bg&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(color-lighten-name default-bg 3))))<br />
&nbsp; &nbsp; `((default :inherit fixed-pitch)<br />
&nbsp; &nbsp; &nbsp; (((type graphic) (class color) (background dark)) (:background ,dark-bg))<br />
&nbsp; &nbsp; &nbsp; (((type graphic) (class color) (background light)) (:background ,light-bg))))<br />
&nbsp; &quot;Face for inline code, pre blocks, and fenced code blocks.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-code-face<br />
&nbsp; `((t (:inherit fixed-pitch)))<br />
&nbsp; &quot;Face for inline code, pre blocks, and fenced code blocks.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-inline-code-face<br />
&nbsp; &#39;((t (:inherit markdown-code-face font-lock-constant-face)))<br />
&nbsp; &quot;Face for inline code.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-pre-face<br />
&nbsp; &#39;((t (:inherit (markdown-code-face font-lock-constant-face))))<br />
&nbsp; &quot;Face for preformatted text.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-language-keyword-face<br />
&nbsp; &#39;((t (:inherit font-lock-type-face)))<br />
&nbsp; &quot;Face for programming language identifiers.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-language-info-face<br />
&nbsp; &#39;((t (:inherit font-lock-string-face)))<br />
&nbsp; &quot;Face for programming language info strings.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-link-face<br />
&nbsp; &#39;((t (:inherit link)))<br />
&nbsp; &quot;Face for links.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-missing-link-face<br />
&nbsp; &#39;((t (:inherit font-lock-warning-face)))<br />
&nbsp; &quot;Face for missing links.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-reference-face<br />
&nbsp; &#39;((t (:inherit markdown-markup-face)))<br />
&nbsp; &quot;Face for link references.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(define-obsolete-face-alias &#39;markdown-footnote-face<br />
&nbsp; &#39;markdown-footnote-marker-face &quot;v2.3&quot;)</p>

<p>(defface markdown-footnote-marker-face<br />
&nbsp; &#39;((t (:inherit markdown-markup-face)))<br />
&nbsp; &quot;Face for footnote markers.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-footnote-text-face<br />
&nbsp; &#39;((t (:inherit font-lock-comment-face)))<br />
&nbsp; &quot;Face for footnote text.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-url-face<br />
&nbsp; &#39;((t (:inherit font-lock-string-face)))<br />
&nbsp; &quot;Face for URLs that are part of markup.<br />
For example, this applies to URLs in inline links:<br />
[link text](http://example.com/).&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-plain-url-face<br />
&nbsp; &#39;((t (:inherit markdown-link-face)))<br />
&nbsp; &quot;Face for URLs that are also links.<br />
For example, this applies to plain angle bracket URLs:<br />
&lt;http://example.com/&gt;.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-link-title-face<br />
&nbsp; &#39;((t (:inherit font-lock-comment-face)))<br />
&nbsp; &quot;Face for reference link titles.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-line-break-face<br />
&nbsp; &#39;((t (:inherit font-lock-constant-face :underline t)))<br />
&nbsp; &quot;Face for hard line breaks.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-comment-face<br />
&nbsp; &#39;((t (:inherit font-lock-comment-face)))<br />
&nbsp; &quot;Face for HTML comments.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-math-face<br />
&nbsp; &#39;((t (:inherit font-lock-string-face)))<br />
&nbsp; &quot;Face for LaTeX expressions.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-metadata-key-face<br />
&nbsp; &#39;((t (:inherit font-lock-variable-name-face)))<br />
&nbsp; &quot;Face for metadata keys.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-metadata-value-face<br />
&nbsp; &#39;((t (:inherit font-lock-string-face)))<br />
&nbsp; &quot;Face for metadata values.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-gfm-checkbox-face<br />
&nbsp; &#39;((t (:inherit font-lock-builtin-face)))<br />
&nbsp; &quot;Face for GFM checkboxes.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-highlight-face<br />
&nbsp; &#39;((t (:inherit highlight)))<br />
&nbsp; &quot;Face for mouse highlighting.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defface markdown-hr-face<br />
&nbsp; &#39;((t (:inherit markdown-markup-face)))<br />
&nbsp; &quot;Face for horizontal rules.&quot;<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defcustom markdown-header-scaling nil<br />
&nbsp; &quot;Whether to use variable-height faces for headers.<br />
When non-nil, `markdown-header-face&#39; will inherit from<br />
`variable-pitch&#39; and the scaling values in<br />
`markdown-header-scaling-values&#39; will be applied to<br />
headers of levels one through six respectively.&quot;<br />
&nbsp; :type &#39;boolean<br />
&nbsp; :initialize &#39;custom-initialize-default<br />
&nbsp; :set (lambda (symbol value)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(set-default symbol value)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-update-header-faces value))<br />
&nbsp; :group &#39;markdown-faces<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.2&quot;))</p>

<p>(defcustom markdown-header-scaling-values<br />
&nbsp; &#39;(2.0 1.7 1.4 1.1 1.0 1.0)<br />
&nbsp; &quot;List of scaling values for headers of level one through six.<br />
Used when `markdown-header-scaling&#39; is non-nil.&quot;<br />
&nbsp; :type &#39;list<br />
&nbsp; :initialize &#39;custom-initialize-default<br />
&nbsp; :set (lambda (symbol value)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(set-default symbol value)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-update-header-faces markdown-header-scaling value))<br />
&nbsp; :group &#39;markdown-faces)</p>

<p>(defun markdown-make-header-faces ()<br />
&nbsp; &quot;Build the faces used for Markdown headers.&quot;<br />
&nbsp; (let ((inherit-faces &#39;(font-lock-function-name-face)))<br />
&nbsp; &nbsp; (when markdown-header-scaling<br />
&nbsp; &nbsp; &nbsp; (setq inherit-faces (cons &#39;variable-pitch inherit-faces)))<br />
&nbsp; &nbsp; (defface markdown-header-face<br />
&nbsp; &nbsp; &nbsp; `((t (:inherit ,inherit-faces :weight bold)))<br />
&nbsp; &nbsp; &nbsp; &quot;Base face for headers.&quot;<br />
&nbsp; &nbsp; &nbsp; :group &#39;markdown-faces))<br />
&nbsp; (dotimes (num 6)<br />
&nbsp; &nbsp; (let* ((num1 (1+ num))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(face-name (intern (format &quot;markdown-header-face-%s&quot; num1)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(scale (if markdown-header-scaling<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (float (nth num markdown-header-scaling-values))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1.0)))<br />
&nbsp; &nbsp; &nbsp; (eval<br />
&nbsp; &nbsp; &nbsp; &nbsp;`(defface ,face-name<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;((t (:inherit markdown-header-face :height ,scale)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (format &quot;Face for level %s headers.<br />
You probably don&#39;t want to customize this face directly. Instead<br />
you can customize the base face `markdown-header-face&#39; or the<br />
variable-height variable `markdown-header-scaling&#39;.&quot; ,num1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; :group &#39;markdown-faces)))))</p>

<p>(markdown-make-header-faces)</p>

<p>(defun markdown-update-header-faces (&amp;optional scaling scaling-values)<br />
&nbsp; &quot;Update header faces, depending on if header SCALING is desired.<br />
If so, use given list of SCALING-VALUES relative to the baseline<br />
size of `markdown-header-face&#39;.&quot;<br />
&nbsp; (dotimes (num 6)<br />
&nbsp; &nbsp; (let* ((face-name (intern (format &quot;markdown-header-face-%s&quot; (1+ num))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(scale (cond ((not scaling) 1.0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (scaling-values (float (nth num scaling-values)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (t (float (nth num markdown-header-scaling-values))))))<br />
&nbsp; &nbsp; &nbsp; (unless (get face-name &#39;saved-face) ; Don&#39;t update customized faces<br />
&nbsp; &nbsp; &nbsp; &nbsp; (set-face-attribute face-name nil :height scale)))))</p>

<p>(defun markdown-syntactic-face (state)<br />
&nbsp; &quot;Return font-lock face for characters with given STATE.<br />
See `font-lock-syntactic-face-function&#39; for details.&quot;<br />
&nbsp; (let ((in-comment (nth 4 state)))<br />
&nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp;(in-comment &#39;markdown-comment-face)<br />
&nbsp; &nbsp; &nbsp;(t nil))))</p>

<p>(defcustom markdown-list-item-bullets<br />
&nbsp; &#39;(&quot;鈼�&quot; &quot;鈼�&quot; &quot;鈼�&quot; &quot;鈼�&quot; &quot;鈼�&quot; &quot;鈻�&quot; &quot;鈥�&quot;)<br />
&nbsp; &quot;List of bullets to use for unordered lists.<br />
It can contain any number of symbols, which will be repeated.<br />
Depending on your font, some reasonable choices are:<br />
鈾� 鈼� 鈼� 鉁� 鉁� 鈽� 鈼� 鈾� 鈾� 鈾� 鉂&euro; 鈼� 鈼� 鈻� 鈻� 鈥� 鈽� 鈻�.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;(repeat (string :tag &quot;Bullet character&quot;))<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.3&quot;))</p>

<p>(defvar markdown-mode-font-lock-keywords-basic<br />
&nbsp; `((markdown-match-yaml-metadata-begin . ((1 markdown-markup-face)))<br />
&nbsp; &nbsp; (markdown-match-yaml-metadata-end . ((1 markdown-markup-face)))<br />
&nbsp; &nbsp; (markdown-match-yaml-metadata-key . ((1 markdown-metadata-key-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(2 markdown-markup-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(3 markdown-metadata-value-face)))<br />
&nbsp; &nbsp; (markdown-match-gfm-open-code-blocks . ((1 markdown-markup-properties)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (2 markdown-markup-properties nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (3 markdown-language-keyword-properties nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (4 markdown-language-info-properties nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (5 markdown-markup-properties nil t)))<br />
&nbsp; &nbsp; (markdown-match-gfm-close-code-blocks . ((0 markdown-markup-properties)))<br />
&nbsp; &nbsp; (markdown-fontify-gfm-code-blocks)<br />
&nbsp; &nbsp; (markdown-match-fenced-start-code-block . ((1 markdown-markup-properties)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(2 markdown-markup-properties nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(3 markdown-language-keyword-properties nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(4 markdown-language-info-properties nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(5 markdown-markup-properties nil t)))<br />
&nbsp; &nbsp; (markdown-match-fenced-end-code-block . ((0 markdown-markup-properties)))<br />
&nbsp; &nbsp; (markdown-fontify-fenced-code-blocks)<br />
&nbsp; &nbsp; (markdown-match-pre-blocks . ((0 markdown-pre-face)))<br />
&nbsp; &nbsp; (markdown-fontify-headings)<br />
&nbsp; &nbsp; (markdown-match-declarative-metadata . ((1 markdown-metadata-key-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (2 markdown-markup-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (3 markdown-metadata-value-face)))<br />
&nbsp; &nbsp; (markdown-match-pandoc-metadata . ((1 markdown-markup-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(2 markdown-markup-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(3 markdown-metadata-value-face)))<br />
&nbsp; &nbsp; (markdown-fontify-hrs)<br />
&nbsp; &nbsp; (markdown-match-code . ((1 markdown-markup-properties prepend)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (2 markdown-inline-code-face prepend)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (3 markdown-markup-properties prepend)))<br />
&nbsp; &nbsp; (,markdown-regex-kbd . ((1 markdown-markup-properties)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (2 markdown-inline-code-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (3 markdown-markup-properties)))<br />
&nbsp; &nbsp; (markdown-fontify-angle-uris)<br />
&nbsp; &nbsp; (,markdown-regex-email . &#39;markdown-plain-url-face)<br />
&nbsp; &nbsp; (markdown-fontify-list-items)<br />
&nbsp; &nbsp; (,markdown-regex-footnote . ((0 markdown-inline-footnote-properties)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(1 markdown-markup-properties) &nbsp; &nbsp;; [^<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(2 markdown-footnote-marker-face) ; label<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(3 markdown-markup-properties))) &nbsp;; ]<br />
&nbsp; &nbsp; (,markdown-regex-pandoc-inline-footnote . ((0 markdown-inline-footnote-properties)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(1 markdown-markup-properties) &nbsp; ; ^<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(2 markdown-markup-properties) &nbsp; ; [<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(3 &#39;markdown-footnote-text-face) ; text<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(4 markdown-markup-properties))) ; ]<br />
&nbsp; &nbsp; (markdown-match-includes . ((1 markdown-markup-properties)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (2 markdown-markup-properties nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (3 markdown-include-title-properties nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (4 markdown-markup-properties nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (5 markdown-markup-properties)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (6 &#39;markdown-url-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (7 markdown-markup-properties)))<br />
&nbsp; &nbsp; (markdown-fontify-inline-links)<br />
&nbsp; &nbsp; (markdown-fontify-reference-links)<br />
&nbsp; &nbsp; (,markdown-regex-reference-definition . ((1 markdown-markup-face) ; [<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(2 markdown-reference-face) ; label<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(3 markdown-markup-face) &nbsp; &nbsp;; ]<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(4 markdown-markup-face) &nbsp; &nbsp;; :<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(5 markdown-url-face) &nbsp; &nbsp; &nbsp; ; url<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(6 markdown-link-title-face))) ; &quot;title&quot; (optional)<br />
&nbsp; &nbsp; (markdown-fontify-plain-uris)<br />
&nbsp; &nbsp; ;; Math mode $..$<br />
&nbsp; &nbsp; (markdown-match-math-single . ((1 markdown-markup-face prepend)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(2 markdown-math-face append)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(3 markdown-markup-face prepend)))<br />
&nbsp; &nbsp; ;; Math mode $$..$$<br />
&nbsp; &nbsp; (markdown-match-math-double . ((1 markdown-markup-face prepend)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(2 markdown-math-face append)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(3 markdown-markup-face prepend)))<br />
&nbsp; &nbsp; (markdown-match-bold . ((1 markdown-markup-properties prepend)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (2 markdown-bold-face append)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (3 markdown-markup-properties prepend)))<br />
&nbsp; &nbsp; (markdown-match-italic . ((1 markdown-markup-properties prepend)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (2 markdown-italic-face append)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (3 markdown-markup-properties prepend)))<br />
&nbsp; &nbsp; (,markdown-regex-strike-through . ((3 markdown-markup-properties)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(4 markdown-strike-through-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(5 markdown-markup-properties)))<br />
&nbsp; &nbsp; (,markdown-regex-line-break . (1 markdown-line-break-face prepend))<br />
&nbsp; &nbsp; (markdown-fontify-sub-superscripts)<br />
&nbsp; &nbsp; (markdown-match-inline-attributes . ((0 markdown-markup-properties prepend)))<br />
&nbsp; &nbsp; (markdown-match-leanpub-sections . ((0 markdown-markup-properties)))<br />
&nbsp; &nbsp; (markdown-fontify-blockquotes))<br />
&nbsp; &quot;Syntax highlighting for Markdown files.&quot;)</p>

<p>(defvar markdown-mode-font-lock-keywords nil<br />
&nbsp; &quot;Default highlighting expressions for Markdown mode.<br />
This variable is defined as a buffer-local variable for dynamic<br />
extension support.&quot;)</p>

<p>;; Footnotes<br />
(defvar markdown-footnote-counter 0<br />
&nbsp; &quot;Counter for footnote numbers.&quot;)<br />
(make-variable-buffer-local &#39;markdown-footnote-counter)</p>

<p>(defconst markdown-footnote-chars<br />
&nbsp; &quot;[[:alnum:]-]&quot;<br />
&nbsp; &quot;Regular expression matching any character that is allowed in a footnote identifier.&quot;)</p>

<p>(defconst markdown-regex-footnote-definition<br />
&nbsp; (concat &quot;^ \\{0,3\\}\\[\\(\\^&quot; markdown-footnote-chars &quot;*?\\)\\]:\\(?:[ \t]+\\|$\\)&quot;)<br />
&nbsp; &quot;Regular expression matching a footnote definition, capturing the label.&quot;)</p>

<p><br />
;;; Compatibility =============================================================</p>

<p>(defun markdown-replace-regexp-in-string (regexp rep string)<br />
&nbsp; &quot;Replace ocurrences of REGEXP with REP in STRING.<br />
This is a compatibility wrapper to provide `replace-regexp-in-string&#39;<br />
in XEmacs 21.&quot;<br />
&nbsp; (if (featurep &#39;xemacs)<br />
&nbsp; &nbsp; &nbsp; (replace-in-string string regexp rep)<br />
&nbsp; &nbsp; (replace-regexp-in-string regexp rep string)))</p>

<p>;; `markdown-use-region-p&#39; is a compatibility function which checks<br />
;; for an active region, with fallbacks for older Emacsen and XEmacs.<br />
(eval-and-compile<br />
&nbsp; (cond<br />
&nbsp; &nbsp;;; Emacs 24 and newer<br />
&nbsp; &nbsp;((fboundp &#39;use-region-p)<br />
&nbsp; &nbsp; (defalias &#39;markdown-use-region-p &#39;use-region-p))<br />
&nbsp; &nbsp;;; XEmacs<br />
&nbsp; &nbsp;((fboundp &#39;region-active-p)<br />
&nbsp; &nbsp; (defalias &#39;markdown-use-region-p &#39;region-active-p))))</p>

<p>;; Use new names for outline-mode functions in Emacs 25 and later.<br />
(eval-and-compile<br />
&nbsp; (defalias &#39;markdown-hide-sublevels<br />
&nbsp; &nbsp; (if (fboundp &#39;outline-hide-sublevels)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;outline-hide-sublevels<br />
&nbsp; &nbsp; &nbsp; &#39;hide-sublevels))<br />
&nbsp; (defalias &#39;markdown-show-all<br />
&nbsp; &nbsp; (if (fboundp &#39;outline-show-all)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;outline-show-all<br />
&nbsp; &nbsp; &nbsp; &#39;show-all))<br />
&nbsp; (defalias &#39;markdown-hide-body<br />
&nbsp; &nbsp; (if (fboundp &#39;outline-hide-body)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;outline-hide-body<br />
&nbsp; &nbsp; &nbsp; &#39;hide-body))<br />
&nbsp; (defalias &#39;markdown-show-children<br />
&nbsp; &nbsp; (if (fboundp &#39;outline-show-children)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;outline-show-children<br />
&nbsp; &nbsp; &nbsp; &#39;show-children))<br />
&nbsp; (defalias &#39;markdown-show-subtree<br />
&nbsp; &nbsp; (if (fboundp &#39;outline-show-subtree)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;outline-show-subtree<br />
&nbsp; &nbsp; &nbsp; &#39;show-subtree))<br />
&nbsp; (defalias &#39;markdown-hide-subtree<br />
&nbsp; &nbsp; (if (fboundp &#39;outline-hide-subtree)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &#39;outline-hide-subtree<br />
&nbsp; &nbsp; &nbsp; &#39;hide-subtree)))</p>

<p>;; Provide directory-name-p to Emacs 24<br />
(defsubst markdown-directory-name-p (name)<br />
&nbsp; &quot;Return non-nil if NAME ends with a directory separator character.<br />
Taken from `directory-name-p&#39; from Emacs 25 and provided here for<br />
backwards compatibility.&quot;<br />
&nbsp; (let ((len (length name))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (lastc ?.))<br />
&nbsp; &nbsp; (if (&gt; len 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq lastc (aref name (1- len))))<br />
&nbsp; &nbsp; (or (= lastc ?/)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (and (memq system-type &#39;(windows-nt ms-dos))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(= lastc ?\\)))))</p>

<p>;; Provide a function to find files recursively in Emacs 24.<br />
(defalias &#39;markdown-directory-files-recursively<br />
&nbsp; (if (fboundp &#39;directory-files-recursively)<br />
&nbsp; &nbsp; &nbsp; &#39;directory-files-recursively<br />
&nbsp; &nbsp; (lambda (dir regexp)<br />
&nbsp; &nbsp; &quot;Return list of all files under DIR that have file names matching REGEXP.<br />
This function works recursively. &nbsp;Files are returned in \&quot;depth first\&quot;<br />
order, and files from each directory are sorted in alphabetical order.<br />
Each file name appears in the returned list in its absolute form.<br />
Based on `directory-files-recursively&#39; from Emacs 25 and provided<br />
here for backwards compatibility.&quot;<br />
&nbsp; (let ((result nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (files nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; When DIR is &quot;/&quot;, remote file names like &quot;/method:&quot; could<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; also be offered. &nbsp;We shall suppress them.<br />
&nbsp; &nbsp; &nbsp; &nbsp; (tramp-mode (and tramp-mode (file-remote-p (expand-file-name dir)))))<br />
&nbsp; &nbsp; (dolist (file (sort (file-name-all-completions &quot;&quot; dir)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;string&lt;))<br />
&nbsp; &nbsp; &nbsp; (unless (member file &#39;(&quot;./&quot; &quot;../&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (markdown-directory-name-p file)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let* ((leaf (substring file 0 (1- (length file))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(full-file (expand-file-name leaf dir)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq result<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (nconc result (markdown-directory-files-recursively<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;full-file regexp))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (string-match-p regexp file)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (push (expand-file-name file dir) files)))))<br />
&nbsp; &nbsp; (nconc result (nreverse files))))))</p>

<p>(defun markdown-flyspell-check-word-p ()<br />
&nbsp; &quot;Return t if `flyspell&#39; should check word just before point.<br />
Used for `flyspell-generic-check-word-predicate&#39;.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char (1- (point)))<br />
&nbsp; &nbsp; (not (or (markdown-code-block-at-point-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-inline-code-at-point-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-in-comment-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(let ((faces (get-text-property (point) &#39;face)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(if (listp faces)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(or (memq &#39;markdown-reference-face faces)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(memq &#39;markdown-markup-face faces)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(memq &#39;markdown-plain-url-face faces)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(memq &#39;markdown-inline-code-face faces)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(memq &#39;markdown-url-face faces))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(memq faces &#39;(markdown-reference-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-markup-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-plain-url-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-inline-code-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-url-face))))))))</p>

<p>(defun markdown-font-lock-ensure ()<br />
&nbsp; &quot;Provide `font-lock-ensure&#39; in Emacs 24.&quot;<br />
&nbsp; (if (fboundp &#39;font-lock-ensure)<br />
&nbsp; &nbsp; &nbsp; (font-lock-ensure)<br />
&nbsp; &nbsp; (with-no-warnings<br />
&nbsp; &nbsp; &nbsp; ;; Suppress warning about non-interactive use of<br />
&nbsp; &nbsp; &nbsp; ;; `font-lock-fontify-buffer&#39; in Emacs 25.<br />
&nbsp; &nbsp; &nbsp; (font-lock-fontify-buffer))))</p>

<p><br />
;;; Markdown Parsing Functions ================================================</p>

<p>(defun markdown-cur-line-blank (&amp;optional predicate)<br />
&nbsp; &quot;Return t if the current line is blank and nil otherwise.<br />
When PREDICATE is non-nil, don&#39;t modify the match data.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (beginning-of-line)<br />
&nbsp; &nbsp; (let ((regexp &quot;^\\s *$&quot;))<br />
&nbsp; &nbsp; &nbsp; (if predicate<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (looking-at-p regexp)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (looking-at regexp)))))</p>

<p>(defun markdown-cur-line-blank-p ()<br />
&nbsp; &quot;Same as `markdown-cur-line-blank&#39;, but does not change the match data.&quot;<br />
&nbsp; (markdown-cur-line-blank t))</p>

<p>(defun markdown-prev-line-blank (&amp;optional predicate)<br />
&nbsp; &quot;Return t if the previous line is blank and nil otherwise.<br />
If we are at the first line, then consider the previous line to be blank.<br />
When PREDICATE is non-nil, don&#39;t modify the match data.&quot;<br />
&nbsp; (or (= (line-beginning-position) (point-min))<br />
&nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line -1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-cur-line-blank predicate))))</p>

<p>(defun markdown-prev-line-blank-p ()<br />
&nbsp; &quot;Same as `markdown-prev-line-blank&#39;, but does not change the match data.&quot;<br />
&nbsp; (markdown-prev-line-blank t))</p>

<p>(defun markdown-next-line-blank (&amp;optional predicate)<br />
&nbsp; &quot;Return t if the next line is blank and nil otherwise.<br />
If we are at the last line, then consider the next line to be blank.<br />
When PREDICATE is non-nil, don&#39;t modify the match data.&quot;<br />
&nbsp; (or (= (line-end-position) (point-max))<br />
&nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-cur-line-blank predicate))))</p>

<p>(defun markdown-next-line-blank-p ()<br />
&nbsp; &quot;Same as `markdown-next-line-blank&#39;, but does not change the match data.&quot;<br />
&nbsp; (markdown-next-line-blank t))</p>

<p>(defun markdown-prev-line-indent ()<br />
&nbsp; &quot;Return the number of leading whitespace characters in the previous line.<br />
Return 0 if the current line is the first line in the buffer.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (if (= (line-beginning-position) (point-min))<br />
&nbsp; &nbsp; &nbsp; &nbsp; 0<br />
&nbsp; &nbsp; &nbsp; (forward-line -1)<br />
&nbsp; &nbsp; &nbsp; (current-indentation))))</p>

<p>(defun markdown-next-line-indent ()<br />
&nbsp; &quot;Return the number of leading whitespace characters in the next line.<br />
Return 0 if line is the last line in the buffer.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (if (= (line-end-position) (point-max))<br />
&nbsp; &nbsp; &nbsp; &nbsp; 0<br />
&nbsp; &nbsp; &nbsp; (forward-line 1)<br />
&nbsp; &nbsp; &nbsp; (current-indentation))))</p>

<p>(defun markdown-cur-non-list-indent ()<br />
&nbsp; &quot;Return beginning position of list item text (not including the list marker).<br />
Return nil if the current line is not the beginning of a list item.&quot;<br />
&nbsp; (save-match-data<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (beginning-of-line)<br />
&nbsp; &nbsp; &nbsp; (when (re-search-forward markdown-regex-list (line-end-position) t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (current-column)))))</p>

<p>(defun markdown-prev-non-list-indent ()<br />
&nbsp; &quot;Return position of the first non-list-marker on the previous line.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (forward-line -1)<br />
&nbsp; &nbsp; (markdown-cur-non-list-indent)))</p>

<p>(defun markdown-new-baseline ()<br />
&nbsp; &quot;Determine if the current line begins a new baseline level.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (beginning-of-line)<br />
&nbsp; &nbsp; (or (looking-at markdown-regex-header)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (looking-at markdown-regex-hr)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (and (null (markdown-cur-non-list-indent))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(= (current-indentation) 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-prev-line-blank)))))</p>

<p>(defun markdown-search-backward-baseline ()<br />
&nbsp; &quot;Search backward baseline point with no indentation and not a list item.&quot;<br />
&nbsp; (end-of-line)<br />
&nbsp; (let (stop)<br />
&nbsp; &nbsp; (while (not (or stop (bobp)))<br />
&nbsp; &nbsp; &nbsp; (re-search-backward markdown-regex-block-separator-noindent nil t)<br />
&nbsp; &nbsp; &nbsp; (when (match-end 2)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-end 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((markdown-new-baseline)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq stop t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((looking-at-p markdown-regex-list)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq stop nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(t (setq stop t)))))))</p>

<p>(defun markdown-update-list-levels (marker indent levels)<br />
&nbsp; &quot;Update list levels given list MARKER, block INDENT, and current LEVELS.<br />
Here, MARKER is a string representing the type of list, INDENT is an integer<br />
giving the indentation, in spaces, of the current block, and LEVELS is a<br />
list of the indentation levels of parent list items. &nbsp;When LEVELS is nil,<br />
it means we are at baseline (not inside of a nested list).&quot;<br />
&nbsp; (cond<br />
&nbsp; &nbsp;;; New list item at baseline.<br />
&nbsp; &nbsp;((and marker (null levels))<br />
&nbsp; &nbsp; (setq levels (list indent)))<br />
&nbsp; &nbsp;;; List item with greater indentation (four or more spaces).<br />
&nbsp; &nbsp;;; Increase list level.<br />
&nbsp; &nbsp;((and marker (&gt;= indent (+ (car levels) 4)))<br />
&nbsp; &nbsp; (setq levels (cons indent levels)))<br />
&nbsp; &nbsp;;; List item with greater or equal indentation (less than four spaces).<br />
&nbsp; &nbsp;;; Do not increase list level.<br />
&nbsp; &nbsp;((and marker (&gt;= indent (car levels)))<br />
&nbsp; &nbsp; levels)<br />
&nbsp; &nbsp;;; Lesser indentation level.<br />
&nbsp; &nbsp;;; Pop appropriate number of elements off LEVELS list (e.g., lesser<br />
&nbsp; &nbsp;;; indentation could move back more than one list level). &nbsp;Note<br />
&nbsp; &nbsp;;; that this block need not be the beginning of list item.<br />
&nbsp; &nbsp;((&lt; indent (car levels))<br />
&nbsp; &nbsp; (while (and (&gt; (length levels) 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&lt; indent (+ (cadr levels) 4)))<br />
&nbsp; &nbsp; &nbsp; (setq levels (cdr levels)))<br />
&nbsp; &nbsp; levels)<br />
&nbsp; &nbsp;;; Otherwise, do nothing.<br />
&nbsp; &nbsp;(t levels)))</p>

<p>(defun markdown-calculate-list-levels ()<br />
&nbsp; &quot;Calculate list levels at point.<br />
Return a list of the form (n1 n2 n3 ...) where n1 is the<br />
indentation of the deepest nested list item in the branch of<br />
the list at the point, n2 is the indentation of the parent<br />
list item, and so on. &nbsp;The depth of the list item is therefore<br />
the length of the returned list. &nbsp;If the point is not at or<br />
immediately &nbsp;after a list item, return nil.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (let ((first (point)) levels indent pre-regexp)<br />
&nbsp; &nbsp; &nbsp; ;; Find a baseline point with zero list indentation<br />
&nbsp; &nbsp; &nbsp; (markdown-search-backward-baseline)<br />
&nbsp; &nbsp; &nbsp; ;; Search for all list items between baseline and LOC<br />
&nbsp; &nbsp; &nbsp; (while (and (&lt; (point) first)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-forward markdown-regex-list first t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq pre-regexp (format &quot;^\\( &nbsp; &nbsp;\\|\t\\)\\{%d\\}&quot; (1+ (length levels))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (beginning-of-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Make sure this is not a header or hr<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((markdown-new-baseline) (setq levels nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Make sure this is not a line from a pre block<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((looking-at-p pre-regexp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; If not, then update levels<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq indent (current-indentation))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq levels (markdown-update-list-levels (match-string 2)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; indent levels))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (end-of-line))<br />
&nbsp; &nbsp; &nbsp; levels)))</p>

<p>(defun markdown-prev-list-item (level)<br />
&nbsp; &quot;Search backward from point for a list item with indentation LEVEL.<br />
Set point to the beginning of the item, and return point, or nil<br />
upon failure.&quot;<br />
&nbsp; (let (bounds indent prev)<br />
&nbsp; &nbsp; (setq prev (point))<br />
&nbsp; &nbsp; (forward-line -1)<br />
&nbsp; &nbsp; (setq indent (current-indentation))<br />
&nbsp; &nbsp; (while<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; List item<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((and (looking-at-p markdown-regex-list)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(setq bounds (markdown-cur-list-item-bounds)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop and return point at item of equal indentation<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((= (nth 3 bounds) level)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq prev (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop and return nil at item with lesser indentation<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((&lt; (nth 3 bounds) level)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq prev nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop at beginning of buffer<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((bobp) (setq prev nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Continue at item with greater indentation<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((&gt; (nth 3 bounds) level) t)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop at beginning of buffer<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((bobp) (setq prev nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Continue if current line is blank<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((markdown-cur-line-blank-p) t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Continue while indentation is the same or greater<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((&gt;= indent level) t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop if current indentation is less than list item<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; and the next is blank<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((and (&lt; indent level)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-next-line-blank-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq prev nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop at a header<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((looking-at-p markdown-regex-header) (setq prev nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop at a horizontal rule<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((looking-at-p markdown-regex-hr) (setq prev nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Otherwise, continue.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(t t))<br />
&nbsp; &nbsp; &nbsp; (forward-line -1)<br />
&nbsp; &nbsp; &nbsp; (setq indent (current-indentation)))<br />
&nbsp; &nbsp; prev))</p>

<p>(defun markdown-next-list-item (level)<br />
&nbsp; &quot;Search forward from point for the next list item with indentation LEVEL.<br />
Set point to the beginning of the item, and return point, or nil<br />
upon failure.&quot;<br />
&nbsp; (let (bounds indent next)<br />
&nbsp; &nbsp; (setq next (point))<br />
&nbsp; &nbsp; (if (looking-at markdown-regex-header-setext)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-end 0)))<br />
&nbsp; &nbsp; (forward-line)<br />
&nbsp; &nbsp; (setq indent (current-indentation))<br />
&nbsp; &nbsp; (while<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop at end of the buffer.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((eobp) nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Continue if the current line is blank<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((markdown-cur-line-blank-p) t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; List item<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((and (looking-at-p markdown-regex-list)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(setq bounds (markdown-cur-list-item-bounds)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Continue at item with greater indentation<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((&gt; (nth 3 bounds) level) t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop and return point at item of equal indentation<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((= (nth 3 bounds) level)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq next (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop and return nil at item with lesser indentation<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((&lt; (nth 3 bounds) level)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq next nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Continue while indentation is the same or greater<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((&gt;= indent level) t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop if current indentation is less than list item<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; and the previous line was blank.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((and (&lt; indent level)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-prev-line-blank-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq next nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop at a header<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((looking-at-p markdown-regex-header) (setq next nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop at a horizontal rule<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((looking-at-p markdown-regex-hr) (setq next nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Otherwise, continue.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(t t))<br />
&nbsp; &nbsp; &nbsp; (forward-line)<br />
&nbsp; &nbsp; &nbsp; (setq indent (current-indentation)))<br />
&nbsp; &nbsp; next))</p>

<p>(defun markdown-cur-list-item-end (level)<br />
&nbsp; &quot;Move to the end of the current list item with nonlist indentation LEVEL.<br />
If the point is not in a list item, do nothing.&quot;<br />
&nbsp; (let (indent)<br />
&nbsp; &nbsp; (forward-line)<br />
&nbsp; &nbsp; (setq indent (current-indentation))<br />
&nbsp; &nbsp; (while<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop at end of the buffer.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((eobp) nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Continue if the current line is blank<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((markdown-cur-line-blank-p) t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Continue while indentation is the same or greater<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((&gt;= indent level) t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop if current indentation is less than list item<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; and the previous line was blank.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((and (&lt; indent level)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-prev-line-blank-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop at a new list item of the same or lesser indentation<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((looking-at-p markdown-regex-list) nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop at a header<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((looking-at-p markdown-regex-header) nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Stop at a horizontal rule<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((looking-at-p markdown-regex-hr) nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Otherwise, continue.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(t t))<br />
&nbsp; &nbsp; &nbsp; (forward-line)<br />
&nbsp; &nbsp; &nbsp; (setq indent (current-indentation)))<br />
&nbsp; &nbsp; ;; Don&#39;t skip over whitespace for empty list items (marker and<br />
&nbsp; &nbsp; ;; whitespace only), just move to end of whitespace.<br />
&nbsp; &nbsp; (if (looking-back (concat markdown-regex-list &quot;\\s-*&quot;) nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-end 3))<br />
&nbsp; &nbsp; &nbsp; (skip-syntax-backward &quot;-&quot;))))</p>

<p>(defun markdown-cur-list-item-bounds ()<br />
&nbsp; &quot;Return bounds and indentation of the current list item.<br />
Return a list of the following form:</p>

<p>&nbsp; &nbsp; (begin end indent nonlist-indent marker checkbox)</p>

<p>The named components are:</p>

<p>&nbsp; - begin: Position of beginning of list item, including leading indentation.<br />
&nbsp; - end: Position of the end of the list item, including list item text.<br />
&nbsp; - indent: Number of characters of indentation before list marker (an integer).<br />
&nbsp; - nonlist-indent: Number characters of indentation, list<br />
&nbsp; &nbsp; marker, and whitespace following list marker (an integer).<br />
&nbsp; - marker: String containing the list marker and following whitespace<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (e.g., \&quot;- \&quot; or \&quot;* \&quot;).<br />
&nbsp; - checkbox: String containing the GFM checkbox portion, if any,<br />
&nbsp; &nbsp; including any trailing whitespace before the text<br />
&nbsp; &nbsp; begins (e.g., \&quot;[x] \&quot;).</p>

<p>As an example, for the following unordered list item</p>

<p>&nbsp; &nbsp;- item</p>

<p>the returned list would be</p>

<p>&nbsp; &nbsp; (1 14 3 5 \&quot;- \&quot; nil)</p>

<p>If the point is not inside a list item, return nil.<br />
Leave match data intact for `markdown-regex-list&#39;.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (let ((cur (point)))<br />
&nbsp; &nbsp; &nbsp; (end-of-line)<br />
&nbsp; &nbsp; &nbsp; (when (re-search-backward markdown-regex-list nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let* ((begin (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(indent (length (match-string-no-properties 1)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(nonlist-indent (length (match-string 0)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(marker (concat (match-string-no-properties 2)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-string-no-properties 3)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(checkbox (progn (goto-char (match-end 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (looking-at &quot;\\[[xX ]\\]\\s-*&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-string-no-properties 0))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(end (save-match-data<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-cur-list-item-end nonlist-indent)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (point))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (and (&gt;= cur begin) (&lt;= cur end) nonlist-indent)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (list begin end indent nonlist-indent marker checkbox)))))))</p>

<p>(defun markdown-list-item-at-point-p ()<br />
&nbsp; &quot;Return t if there is a list item at the point and nil otherwise.&quot;<br />
&nbsp; (save-match-data (markdown-cur-list-item-bounds)))</p>

<p>(defun markdown-prev-list-item-bounds ()<br />
&nbsp; &quot;Return bounds of previous item in the same list of any level.<br />
The return value has the same form as that of<br />
`markdown-cur-list-item-bounds&#39;.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (let ((cur-bounds (markdown-cur-list-item-bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (beginning-of-list (save-excursion (markdown-beginning-of-list)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; stop)<br />
&nbsp; &nbsp; &nbsp; (when cur-bounds<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (nth 0 cur-bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (while (and (not stop) (not (bobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-backward markdown-regex-list<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; beginning-of-list t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless (or (looking-at markdown-regex-hr)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-code-block-at-point-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq stop (point))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-cur-list-item-bounds)))))</p>

<p>(defun markdown-next-list-item-bounds ()<br />
&nbsp; &quot;Return bounds of next item in the same list of any level.<br />
The return value has the same form as that of<br />
`markdown-cur-list-item-bounds&#39;.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (let ((cur-bounds (markdown-cur-list-item-bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (end-of-list (save-excursion (markdown-end-of-list)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; stop)<br />
&nbsp; &nbsp; &nbsp; (when cur-bounds<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (nth 0 cur-bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (end-of-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (while (and (not stop) (not (eobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-forward markdown-regex-list<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;end-of-list t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless (or (looking-at markdown-regex-hr)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-code-block-at-point-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq stop (point))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when stop<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-cur-list-item-bounds))))))</p>

<p>(defun markdown-beginning-of-list ()<br />
&nbsp; &quot;Move point to beginning of list at point, if any.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((orig-point (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (list-begin (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-search-backward-baseline)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Stop at next list item, regardless of the indentation.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-next-list-item (point-max))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (looking-at markdown-regex-list)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (point)))))<br />
&nbsp; &nbsp; (when (and list-begin (&lt;= list-begin orig-point))<br />
&nbsp; &nbsp; &nbsp; (goto-char list-begin))))</p>

<p>(defun markdown-end-of-list ()<br />
&nbsp; &quot;Move point to end of list at point, if any.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((start (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (end (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(when (markdown-beginning-of-list)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Items can&#39;t have nonlist-indent &lt;= 1, so this<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; moves past all list items.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-next-list-item 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(skip-syntax-backward &quot;-&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(unless (eobp) (forward-char 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(point)))))<br />
&nbsp; &nbsp; (when (and end (&gt;= end start))<br />
&nbsp; &nbsp; &nbsp; (goto-char end))))</p>

<p>(defun markdown-up-list ()<br />
&nbsp; &quot;Move point to beginning of parent list item.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((cur-bounds (markdown-cur-list-item-bounds)))<br />
&nbsp; &nbsp; (when cur-bounds<br />
&nbsp; &nbsp; &nbsp; (markdown-prev-list-item (1- (nth 3 cur-bounds)))<br />
&nbsp; &nbsp; &nbsp; (let ((up-bounds (markdown-cur-list-item-bounds)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (and up-bounds (&lt; (nth 3 up-bounds) (nth 3 cur-bounds)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (point))))))</p>

<p>(defun markdown-bounds-of-thing-at-point (thing)<br />
&nbsp; &quot;Call `bounds-of-thing-at-point&#39; for THING with slight modifications.<br />
Does not include trailing newlines when THING is &#39;line. &nbsp;Handles the<br />
end of buffer case by setting both endpoints equal to the value of<br />
`point-max&#39;, since an empty region will trigger empty markup insertion.<br />
Return bounds of form (beg . end) if THING is found, or nil otherwise.&quot;<br />
&nbsp; (let* ((bounds (bounds-of-thing-at-point thing))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(a (car bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(b (cdr bounds)))<br />
&nbsp; &nbsp; (when bounds<br />
&nbsp; &nbsp; &nbsp; (when (eq thing &#39;line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cond ((and (eobp) (markdown-cur-line-blank-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(setq a b))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((char-equal (char-before b) ?\^J)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(setq b (1- b)))))<br />
&nbsp; &nbsp; &nbsp; (cons a b))))</p>

<p>(defun markdown-reference-definition (reference)<br />
&nbsp; &quot;Find out whether Markdown REFERENCE is defined.<br />
REFERENCE should not include the square brackets.<br />
When REFERENCE is defined, return a list of the form (text start end)<br />
containing the definition text itself followed by the start and end<br />
locations of the text. &nbsp;Otherwise, return nil.<br />
Leave match data for `markdown-regex-reference-definition&#39;<br />
intact additional processing.&quot;<br />
&nbsp; (let ((reference (downcase reference)))<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; &nbsp; (catch &#39;found<br />
&nbsp; &nbsp; &nbsp; &nbsp; (while (re-search-forward markdown-regex-reference-definition nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (string= reference (downcase (match-string-no-properties 2)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (throw &#39;found<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(list (match-string-no-properties 5)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-beginning 5) (match-end 5)))))))))</p>

<p>(defun markdown-get-defined-references ()<br />
&nbsp; &quot;Return a list of all defined reference labels (not including square brackets).&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; (let (refs)<br />
&nbsp; &nbsp; &nbsp; (while (re-search-forward markdown-regex-reference-definition nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let ((target (match-string-no-properties 2)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-pushnew target refs :test #&#39;equal)))<br />
&nbsp; &nbsp; &nbsp; (reverse refs))))</p>

<p>(defun markdown-get-used-uris ()<br />
&nbsp; &quot;Return a list of all used URIs in the buffer.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; (let (uris)<br />
&nbsp; &nbsp; &nbsp; (while (re-search-forward<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (concat &quot;\\(?:&quot; markdown-regex-link-inline<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;\\|&quot; markdown-regex-angle-uri<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;\\|&quot; markdown-regex-uri<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;\\|&quot; markdown-regex-email<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;\\)&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (unless (or (markdown-inline-code-at-point-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-code-block-at-point-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-pushnew (or (match-string-no-properties 6)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-string-no-properties 10)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-string-no-properties 12)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-string-no-properties 13))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; uris :test #&#39;equal)))<br />
&nbsp; &nbsp; &nbsp; (reverse uris))))</p>

<p>(defun markdown-inline-code-at-pos (pos)<br />
&nbsp; &quot;Return non-nil if there is an inline code fragment at POS.<br />
Return nil otherwise. &nbsp;Set match data according to<br />
`markdown-match-code&#39; upon success.<br />
This function searches the block for a code fragment that<br />
contains the point using `markdown-match-code&#39;. &nbsp;We do this<br />
because `thing-at-point-looking-at&#39; does not work reliably with<br />
`markdown-regex-code&#39;.</p>

<p>The match data is set as follows:<br />
Group 1 matches the opening backquotes.<br />
Group 2 matches the code fragment itself, without backquotes.<br />
Group 3 matches the closing backquotes.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char pos)<br />
&nbsp; &nbsp; (let ((old-point (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (end-of-block (progn (markdown-end-of-text-block) (point)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; found)<br />
&nbsp; &nbsp; &nbsp; (markdown-beginning-of-text-block)<br />
&nbsp; &nbsp; &nbsp; (while (and (markdown-match-code end-of-block)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq found t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&lt; (match-end 0) old-point)))<br />
&nbsp; &nbsp; &nbsp; (and found &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;; matched something<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(&lt;= (match-beginning 0) old-point) ; match contains old-point<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(&gt;= (match-end 0) old-point)))))</p>

<p>(defun markdown-inline-code-at-pos-p (pos)<br />
&nbsp; &quot;Return non-nil if there is an inline code fragment at POS.<br />
Like `markdown-inline-code-at-pos`, but preserves match data.&quot;<br />
&nbsp; (save-match-data (markdown-inline-code-at-pos pos)))</p>

<p>(defun markdown-inline-code-at-point ()<br />
&nbsp; &quot;Return non-nil if the point is at an inline code fragment.<br />
See `markdown-inline-code-at-pos&#39; for details.&quot;<br />
&nbsp; (markdown-inline-code-at-pos (point)))</p>

<p>(defun markdown-inline-code-at-point-p ()<br />
&nbsp; &quot;Return non-nil if there is inline code at the point.<br />
This is a predicate function counterpart to<br />
`markdown-inline-code-at-point&#39; which does not modify the match<br />
data. &nbsp;See `markdown-code-block-at-point-p&#39; for code blocks.&quot;<br />
&nbsp; (save-match-data (markdown-inline-code-at-pos (point))))</p>

<p>(make-obsolete &#39;markdown-code-at-point-p &#39;markdown-inline-code-at-point-p &quot;v2.2&quot;)</p>

<p>(defun markdown-code-block-at-pos (pos)<br />
&nbsp; &quot;Return match data list if there is a code block at POS.<br />
Uses text properties at the beginning of the line position.<br />
This includes pre blocks, tilde-fenced code blocks, and GFM<br />
quoted code blocks. &nbsp;Return nil otherwise.&quot;<br />
&nbsp; (setq pos (save-excursion (goto-char pos) (point-at-bol)))<br />
&nbsp; (or (get-text-property pos &#39;markdown-pre)<br />
&nbsp; &nbsp; &nbsp; (markdown-get-enclosing-fenced-block-construct pos)<br />
&nbsp; &nbsp; &nbsp; ;; polymode removes text properties set by markdown-mode, so<br />
&nbsp; &nbsp; &nbsp; ;; check if `poly-markdown-mode&#39; is active and whether the<br />
&nbsp; &nbsp; &nbsp; ;; `chunkmode&#39; property is non-nil at POS.<br />
&nbsp; &nbsp; &nbsp; (and (bound-and-true-p poly-markdown-mode)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(get-text-property pos &#39;chunkmode))))</p>

<p>;; Function was renamed to emphasize that it does not modify match-data.<br />
(defalias &#39;markdown-code-block-at-point &#39;markdown-code-block-at-point-p)</p>

<p>(defun markdown-code-block-at-point-p ()<br />
&nbsp; &quot;Return non-nil if there is a code block at the point.<br />
This includes pre blocks, tilde-fenced code blocks, and GFM<br />
quoted code blocks. &nbsp;This function does not modify the match<br />
data. &nbsp;See `markdown-inline-code-at-point-p&#39; for inline code.&quot;<br />
&nbsp; (save-match-data (markdown-code-block-at-pos (point))))</p>

<p>(defun markdown-heading-at-point ()<br />
&nbsp; &quot;Return non-nil if there is a heading at the point.<br />
Set match data for `markdown-regex-header&#39;.&quot;<br />
&nbsp; (let ((match-data (get-text-property (point) &#39;markdown-heading)))<br />
&nbsp; &nbsp; (when match-data<br />
&nbsp; &nbsp; &nbsp; (set-match-data match-data)<br />
&nbsp; &nbsp; &nbsp; t)))</p>

<p>(defun markdown-pipe-at-bol-p ()<br />
&nbsp; &quot;Return non-nil if the line begins with a pipe symbol.<br />
This may be useful for tables and Pandoc&#39;s line_blocks extension.&quot;<br />
&nbsp; (char-equal (char-after (point-at-bol)) ?|))</p>

<p><br />
;;; Markdown Font Lock Matching Functions =====================================</p>

<p>(defun markdown-range-property-any (begin end prop prop-values)<br />
&nbsp; &quot;Return t if PROP from BEGIN to END is equal to one of the given PROP-VALUES.<br />
Also returns t if PROP is a list containing one of the PROP-VALUES.<br />
Return nil otherwise.&quot;<br />
&nbsp; (let (props)<br />
&nbsp; &nbsp; (catch &#39;found<br />
&nbsp; &nbsp; &nbsp; (dolist (loc (number-sequence begin end))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (setq props (get-text-property loc prop))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cond ((listp props)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; props is a list, check for membership<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(dolist (val prop-values)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(when (memq val props) (throw &#39;found loc))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; props is a scalar, check for equality<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(dolist (val prop-values)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(when (eq val props) (throw &#39;found loc))))))))))</p>

<p>(defun markdown-range-properties-exist (begin end props)<br />
&nbsp; (cl-loop<br />
&nbsp; &nbsp;for loc in (number-sequence begin end)<br />
&nbsp; &nbsp;with result = nil<br />
&nbsp; &nbsp;while (not<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq result<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-some (lambda (prop) (get-text-property loc prop)) props)))<br />
&nbsp; &nbsp;finally return result))</p>

<p>(defun markdown-match-inline-generic (regex last &amp;optional faceless)<br />
&nbsp; &quot;Match inline REGEX from the point to LAST.<br />
When FACELESS is non-nil, do not return matches where faces have been applied.&quot;<br />
&nbsp; (when (re-search-forward regex last t)<br />
&nbsp; &nbsp; (let ((bounds (markdown-code-block-at-pos (match-beginning 1)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (face (and faceless (text-property-not-all<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-beginning 0) (match-end 0) &#39;face nil))))<br />
&nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; In code block: move past it and recursively search again<br />
&nbsp; &nbsp; &nbsp; &nbsp;(bounds<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (&lt; (goto-char (cl-second bounds)) last)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-match-inline-generic regex last faceless)))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; When faces are found in the match range, skip over the match and<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; recursively search again.<br />
&nbsp; &nbsp; &nbsp; &nbsp;(face<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (&lt; (goto-char (match-end 0)) last)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-match-inline-generic regex last faceless)))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Keep match data and return t when in bounds.<br />
&nbsp; &nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; &nbsp; (&lt;= (match-end 0) last))))))</p>

<p>(defun markdown-match-code (last)<br />
&nbsp; &quot;Match inline code fragments from point to LAST.&quot;<br />
&nbsp; (unless (bobp)<br />
&nbsp; &nbsp; (backward-char 1))<br />
&nbsp; (when (markdown-match-inline-generic markdown-regex-code last)<br />
&nbsp; &nbsp; (let ((begin (match-beginning 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (end (match-end 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (open-begin (match-beginning 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (open-end (match-end 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (code-begin (match-beginning 3))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (code-end (match-end 3))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (close-begin (match-beginning 4))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (close-end (match-end 4)))<br />
&nbsp; &nbsp; &nbsp; (if (or (markdown-in-comment-p begin)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-in-comment-p end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-code-block-at-pos begin))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn (goto-char (min (1+ begin) last))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(when (&lt; (point) last)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-match-code last)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (set-match-data (list begin end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; open-begin open-end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; code-begin code-end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; close-begin close-end))<br />
&nbsp; &nbsp; &nbsp; &nbsp; t))))</p>

<p>(defun markdown-match-bold (last)<br />
&nbsp; &quot;Match inline bold from the point to LAST.&quot;<br />
&nbsp; (when (markdown-match-inline-generic markdown-regex-bold last)<br />
&nbsp; &nbsp; (let ((begin (match-beginning 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (end (match-end 2)))<br />
&nbsp; &nbsp; &nbsp; (if (or (markdown-inline-code-at-pos-p begin)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-inline-code-at-pos-p end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-in-comment-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-range-property-any<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;begin begin &#39;face &#39;(markdown-url-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-plain-url-face))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-range-property-any<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;begin end &#39;face &#39;(markdown-inline-code-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-math-face)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn (goto-char (min (1+ begin) last))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(when (&lt; (point) last)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-match-italic last)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (set-match-data (list (match-beginning 2) (match-end 2)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 3) (match-end 3)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 4) (match-end 4)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 5) (match-end 5)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; t))))</p>

<p>(defun markdown-match-italic (last)<br />
&nbsp; &quot;Match inline italics from the point to LAST.&quot;<br />
&nbsp; (let ((regex (if (eq major-mode &#39;gfm-mode)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-regex-gfm-italic markdown-regex-italic)))<br />
&nbsp; &nbsp; (when (markdown-match-inline-generic regex last)<br />
&nbsp; &nbsp; &nbsp; (let ((begin (match-beginning 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (end (match-end 1)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (or (markdown-inline-code-at-pos-p begin)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-inline-code-at-pos-p end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-in-comment-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-range-property-any<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;begin begin &#39;face &#39;(markdown-url-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-plain-url-face))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-range-property-any<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;begin end &#39;face &#39;(markdown-inline-code-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-bold-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-list-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-math-face)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn (goto-char (min (1+ begin) last))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(when (&lt; (point) last)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-match-italic last)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (set-match-data (list (match-beginning 1) (match-end 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 2) (match-end 2)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 3) (match-end 3)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 4) (match-end 4)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; t)))))</p>

<p>(defun markdown-match-math-generic (regex last)<br />
&nbsp; &quot;Match REGEX from point to LAST.<br />
REGEX is either `markdown-regex-math-inline-single&#39; for matching<br />
$..$ or `markdown-regex-math-inline-double&#39; for matching $$..$$.&quot;<br />
&nbsp; (when (and markdown-enable-math (markdown-match-inline-generic regex last))<br />
&nbsp; &nbsp; (let ((begin (match-beginning 1)) (end (match-end 1)))<br />
&nbsp; &nbsp; &nbsp; (prog1<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (or (markdown-range-property-any<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;begin end &#39;face (list markdown-inline-code-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-bold-face))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-range-properties-exist<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;begin end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-get-fenced-block-middle-properties)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-match-math-generic regex last)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (1+ (match-end 0)))))))</p>

<p>(defun markdown-match-list-items (last)<br />
&nbsp; &quot;Match list items from point to LAST.&quot;<br />
&nbsp; (when (markdown-match-inline-generic markdown-regex-list last)<br />
&nbsp; &nbsp; (let ((begin (match-beginning 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (end (match-end 2)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (or (markdown-range-property-any<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;begin end &#39;face (list markdown-inline-code-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-bold-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-math-face))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-range-properties-exist begin end &#39;(markdown-hr))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-in-comment-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn (goto-char (min (1+ (match-end 0)) last))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-match-list-items last))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (set-match-data (list (match-beginning 0) (match-end 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 1) (match-end 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 2) (match-end 2)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (1+ (match-end 0)))))))</p>

<p>(defun markdown-match-math-single (last)<br />
&nbsp; &quot;Match single quoted $..$ math from point to LAST.&quot;<br />
&nbsp; (markdown-match-math-generic markdown-regex-math-inline-single last))</p>

<p>(defun markdown-match-math-double (last)<br />
&nbsp; &quot;Match double quoted $$..$$ math from point to LAST.&quot;<br />
&nbsp; (markdown-match-math-generic markdown-regex-math-inline-double last))</p>

<p>(defun markdown-match-propertized-text (property last)<br />
&nbsp; &quot;Match text with PROPERTY from point to LAST.<br />
Restore match data previously stored in PROPERTY.&quot;<br />
&nbsp; (let ((saved (get-text-property (point) property))<br />
&nbsp; &nbsp; &nbsp; &nbsp; pos)<br />
&nbsp; &nbsp; (unless saved<br />
&nbsp; &nbsp; &nbsp; (setq pos (next-single-char-property-change (point) property nil last))<br />
&nbsp; &nbsp; &nbsp; (setq saved (get-text-property pos property)))<br />
&nbsp; &nbsp; (when saved<br />
&nbsp; &nbsp; &nbsp; (set-match-data saved)<br />
&nbsp; &nbsp; &nbsp; ;; Step at least one character beyond point. Otherwise<br />
&nbsp; &nbsp; &nbsp; ;; `font-lock-fontify-keywords-region&#39; infloops.<br />
&nbsp; &nbsp; &nbsp; (goto-char (min (1+ (max (match-end 0) (point)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (point-max)))<br />
&nbsp; &nbsp; &nbsp; saved)))</p>

<p>(defun markdown-match-pre-blocks (last)<br />
&nbsp; &quot;Match preformatted blocks from point to LAST.<br />
Use data stored in &#39;markdown-pre text property during syntax<br />
analysis.&quot;<br />
&nbsp; (markdown-match-propertized-text &#39;markdown-pre last))</p>

<p>(defun markdown-match-gfm-code-blocks (last)<br />
&nbsp; &quot;Match GFM quoted code blocks from point to LAST.<br />
Use data stored in &#39;markdown-gfm-code text property during syntax<br />
analysis.&quot;<br />
&nbsp; (markdown-match-propertized-text &#39;markdown-gfm-code last))</p>

<p>(defun markdown-match-gfm-open-code-blocks (last)<br />
&nbsp; (markdown-match-propertized-text &#39;markdown-gfm-block-begin last))</p>

<p>(defun markdown-match-gfm-close-code-blocks (last)<br />
&nbsp; (markdown-match-propertized-text &#39;markdown-gfm-block-end last))</p>

<p>(defun markdown-match-fenced-code-blocks (last)<br />
&nbsp; &quot;Match fenced code blocks from the point to LAST.&quot;<br />
&nbsp; (markdown-match-propertized-text &#39;markdown-fenced-code last))</p>

<p>(defun markdown-match-fenced-start-code-block (last)<br />
&nbsp; (markdown-match-propertized-text &#39;markdown-tilde-fence-begin last))</p>

<p>(defun markdown-match-fenced-end-code-block (last)<br />
&nbsp; (markdown-match-propertized-text &#39;markdown-tilde-fence-end last))</p>

<p>(defun markdown-match-blockquotes (last)<br />
&nbsp; &quot;Match blockquotes from point to LAST.<br />
Use data stored in &#39;markdown-blockquote text property during syntax<br />
analysis.&quot;<br />
&nbsp; (markdown-match-propertized-text &#39;markdown-blockquote last))</p>

<p>(defun markdown-match-hr (last)<br />
&nbsp; &quot;Match horizontal rules comments from the point to LAST.&quot;<br />
&nbsp; (markdown-match-propertized-text &#39;markdown-hr last))</p>

<p>(defun markdown-match-comments (last)<br />
&nbsp; &quot;Match HTML comments from the point to LAST.&quot;<br />
&nbsp; (when (and (skip-syntax-forward &quot;^&lt;&quot; last))<br />
&nbsp; &nbsp; (let ((beg (point)))<br />
&nbsp; &nbsp; &nbsp; (when (and (skip-syntax-forward &quot;^&gt;&quot; last) (&lt; (point) last))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-char)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (set-match-data (list beg (point)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; t))))</p>

<p>(defun markdown-match-generic-links (last ref)<br />
&nbsp; &quot;Match inline links from point to LAST.<br />
When REF is non-nil, match reference links instead of standard<br />
links with URLs.&quot;<br />
&nbsp; ;; Search for the next potential link (not in a code block).<br />
&nbsp; (while (and (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Clear match data to test for a match after functions returns.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (set-match-data nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-forward &quot;\\(!\\)?\\(\\[\\)&quot; last &#39;limit))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Keep searching if this is in a code block, inline<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; code, or a comment, or if it is include syntax.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (or (markdown-code-block-at-point-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-inline-code-at-pos-p (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-inline-code-at-pos-p (match-end 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-in-comment-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (and (char-equal (char-after (point-at-bol)) ?&lt;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(char-equal (char-after (1+ (point-at-bol))) ?&lt;)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&lt; (point) last)))<br />
&nbsp; ;; Match opening exclamation point (optional) and left bracket.<br />
&nbsp; (when (match-beginning 2)<br />
&nbsp; &nbsp; (let* ((bang (match-beginning 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(first-begin (match-beginning 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Find end of block to prevent matching across blocks.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(end-of-block (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(goto-char (match-beginning 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-end-of-text-block)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(point))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Move over balanced expressions to closing right bracket.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Catch unbalanced expression errors and return nil.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(first-end (condition-case nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(and (goto-char first-begin)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (scan-sexps (point) 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(error nil)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Continue with point at CONT-POINT upon failure.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cont-point (min (1+ first-begin) last))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;second-begin second-end url-begin url-end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;title-begin title-end)<br />
&nbsp; &nbsp; &nbsp; ;; When bracket found, in range, and followed by a left paren/bracket...<br />
&nbsp; &nbsp; &nbsp; (when (and first-end (&lt; first-end end-of-block) (goto-char first-end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(char-equal (char-after (point)) (if ref ?\[ ?\()))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Scan across balanced expressions for closing parenthesis/bracket.<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq second-begin (point)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; second-end (condition-case nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (scan-sexps (point) 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (error nil)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Check that closing parenthesis/bracket is in range.<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (and second-end (&lt;= second-end end-of-block) (&lt;= second-end last))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Search for (optional) title inside closing parenthesis<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (and (not ref) (search-forward &quot;\&quot;&quot; second-end t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq title-begin (1- (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; title-end (and (goto-char second-end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(search-backward &quot;\&quot;&quot; (1+ title-begin) t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; title-end (and title-end (1+ title-end))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Store URL/reference range<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq url-begin (1+ second-begin)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; url-end (1- (or title-begin second-end)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Set match data, move point beyond link, and return<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (set-match-data<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(list (or bang first-begin) second-end &nbsp;; 0 - all<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bang (and bang (1+ bang)) &nbsp; &nbsp; &nbsp; &nbsp; ; 1 - bang<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;first-begin (1+ first-begin) &nbsp; &nbsp; &nbsp;; 2 - markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(1+ first-begin) (1- first-end) &nbsp; ; 3 - link text<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(1- first-end) first-end &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;; 4 - markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;second-begin (1+ second-begin) &nbsp; &nbsp;; 5 - markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;url-begin url-end &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ; 6 - url/reference<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;title-begin title-end &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ; 7 - title<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(1- second-end) second-end)) &nbsp; &nbsp; &nbsp;; 8 - markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Nullify cont-point and leave point at end and<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq cont-point nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char second-end))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; If no closing parenthesis in range, update continuation point<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq cont-point (min end-of-block second-begin))))<br />
&nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; On failure, continue searching at cont-point<br />
&nbsp; &nbsp; &nbsp; &nbsp;((and cont-point (&lt; cont-point last))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char cont-point)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-match-generic-links last ref))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; No more text, return nil<br />
&nbsp; &nbsp; &nbsp; &nbsp;((and cont-point (= cont-point last))<br />
&nbsp; &nbsp; &nbsp; &nbsp; nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Return t if a match occurred<br />
&nbsp; &nbsp; &nbsp; &nbsp;(t t)))))</p>

<p>(defun markdown-match-inline-links (last)<br />
&nbsp; &quot;Match standard inline links from point to LAST.&quot;<br />
&nbsp; (markdown-match-generic-links last nil))</p>

<p>(defun markdown-match-reference-links (last)<br />
&nbsp; &quot;Match inline reference links from point to LAST.&quot;<br />
&nbsp; (markdown-match-generic-links last t))</p>

<p>(defun markdown-match-angle-uris (last)<br />
&nbsp; &quot;Match angle bracket URIs from point to LAST.&quot;<br />
&nbsp; (when (markdown-match-inline-generic markdown-regex-angle-uri last)<br />
&nbsp; &nbsp; (goto-char (1+ (match-end 0)))))</p>

<p>(defun markdown-match-plain-uris (last)<br />
&nbsp; &quot;Match plain URIs from point to LAST.&quot;<br />
&nbsp; (when (markdown-match-inline-generic markdown-regex-uri last t)<br />
&nbsp; &nbsp; (goto-char (1+ (match-end 0)))))</p>

<p>(defun markdown-get-match-boundaries (start-header end-header last &amp;optional pos)<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char (or pos (point-min)))<br />
&nbsp; &nbsp; (cl-loop<br />
&nbsp; &nbsp; &nbsp;with cur-result = nil<br />
&nbsp; &nbsp; &nbsp;and st-hdr = (or start-header &quot;\\`&quot;)<br />
&nbsp; &nbsp; &nbsp;and end-hdr = (or end-header &quot;\n\n\\|\n\\&#39;\\|\\&#39;&quot;)<br />
&nbsp; &nbsp; &nbsp;while (and (&lt; (point) last)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-forward st-hdr last t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq cur-result (match-data))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-forward end-hdr nil t)))<br />
&nbsp; &nbsp; &nbsp;collect (list cur-result (match-data)))))</p>

<p>(defvar markdown-conditional-search-function #&#39;re-search-forward<br />
&nbsp; &quot;Conditional search function used in `markdown-search-until-condition&#39;.<br />
Made into a variable to allow for dynamic let-binding.&quot;)</p>

<p>(defun markdown-search-until-condition (condition &amp;rest args)<br />
&nbsp; (let (ret)<br />
&nbsp; &nbsp; (while (and (not ret) (apply markdown-conditional-search-function args))<br />
&nbsp; &nbsp; &nbsp; (setq ret (funcall condition)))<br />
&nbsp; &nbsp; ret))</p>

<p>(defun markdown-match-generic-metadata<br />
&nbsp; &nbsp; (regexp last &amp;optional start-header end-header)<br />
&nbsp; &quot;Match generic metadata specified by REGEXP from the point to LAST.<br />
If START-HEADER is nil, we assume metadata can only occur at the<br />
very top of a file (\&quot;\\`\&quot;). If END-HEADER is nil, we assume it<br />
is \&quot;\n\n\&quot;&quot;<br />
&nbsp; (let* ((header-bounds<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-get-match-boundaries start-header end-header last))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(enclosing-header<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-find-if &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ; just take first if multiple<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(lambda (match-bounds)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cl-destructuring-bind (begin end) (cl-second match-bounds)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(and (&lt; (point) begin)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-excursion (re-search-forward regexp end t)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;header-bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(header-begin<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when enclosing-header (cl-second (cl-first enclosing-header))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(header-end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when enclosing-header (cl-first (cl-second enclosing-header)))))<br />
&nbsp; &nbsp; (cond ((null enclosing-header)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Don&#39;t match anything outside of a header.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((markdown-search-until-condition<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (lambda () (&gt; (point) header-begin)) regexp (min last header-end) t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; If a metadata item is found, it may span several lines.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(let ((key-beginning (match-beginning 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(key-end (match-end 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markup-begin (match-beginning 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markup-end (match-end 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(value-beginning (match-beginning 3)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(set-match-data (list key-beginning (point) ; complete metadata<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;key-beginning key-end ; key<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markup-begin markup-end ; markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;value-beginning (point))) ; value<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (t nil))))</p>

<p>(defun markdown-match-declarative-metadata (last)<br />
&nbsp; &quot;Match declarative metadata from the point to LAST.&quot;<br />
&nbsp; (markdown-match-generic-metadata markdown-regex-declarative-metadata last))</p>

<p>(defun markdown-match-pandoc-metadata (last)<br />
&nbsp; &quot;Match Pandoc metadata from the point to LAST.&quot;<br />
&nbsp; (markdown-match-generic-metadata markdown-regex-pandoc-metadata last))</p>

<p>(defun markdown-match-yaml-metadata-begin (last)<br />
&nbsp; (markdown-match-propertized-text &#39;markdown-yaml-metadata-begin last))</p>

<p>(defun markdown-match-yaml-metadata-end (last)<br />
&nbsp; (markdown-match-propertized-text &#39;markdown-yaml-metadata-end last))</p>

<p>(defun markdown-match-yaml-metadata-key (last)<br />
&nbsp; (markdown-match-propertized-text &#39;markdown-metadata-key last))</p>

<p>(defun markdown-match-inline-attributes (last)<br />
&nbsp; &quot;Match inline attributes from point to LAST.&quot;<br />
&nbsp; (when (markdown-match-inline-generic markdown-regex-inline-attributes last)<br />
&nbsp; &nbsp; (unless (or (markdown-inline-code-at-pos-p (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-inline-code-at-pos-p (match-end 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-in-comment-p))<br />
&nbsp; &nbsp; &nbsp; t)))</p>

<p>(defun markdown-match-leanpub-sections (last)<br />
&nbsp; &quot;Match Leanpub section markers from point to LAST.&quot;<br />
&nbsp; (when (markdown-match-inline-generic markdown-regex-leanpub-sections last)<br />
&nbsp; &nbsp; (unless (or (markdown-inline-code-at-pos-p (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-inline-code-at-pos-p (match-end 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-in-comment-p))<br />
&nbsp; &nbsp; &nbsp; t)))</p>

<p>(defun markdown-match-includes (last)<br />
&nbsp; &quot;Match include statements from point to LAST.<br />
Sets match data for the following seven groups:<br />
Group 1: opening two angle brackets<br />
Group 2: opening title delimiter (optional)<br />
Group 3: title text (optional)<br />
Group 4: closing title delimiter (optional)<br />
Group 5: opening filename delimiter<br />
Group 6: filename<br />
Group 7: closing filename delimiter&quot;<br />
&nbsp; (when (markdown-match-inline-generic markdown-regex-include last)<br />
&nbsp; &nbsp; (let ((valid (not (or (markdown-in-comment-p (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-in-comment-p (match-end 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-code-block-at-pos (match-beginning 0))))))<br />
&nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Parentheses and maybe square brackets, but no curly braces:<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; match optional title in square brackets and file in parentheses.<br />
&nbsp; &nbsp; &nbsp; &nbsp;((and valid (match-beginning 5)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (match-beginning 8)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (set-match-data (list (match-beginning 1) (match-end 7)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 1) (match-end 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 2) (match-end 2)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 3) (match-end 3)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 4) (match-end 4)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 5) (match-end 5)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 6) (match-end 6)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 7) (match-end 7))))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Only square brackets present: match file in square brackets.<br />
&nbsp; &nbsp; &nbsp; &nbsp;((and valid (match-beginning 2)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (match-beginning 5))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (match-beginning 7)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (set-match-data (list (match-beginning 1) (match-end 4)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 1) (match-end 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 2) (match-end 2)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 3) (match-end 3)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 4) (match-end 4))))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Only curly braces present: match file in curly braces.<br />
&nbsp; &nbsp; &nbsp; &nbsp;((and valid (match-beginning 8)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (match-beginning 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (match-beginning 5)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (set-match-data (list (match-beginning 1) (match-end 10)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 1) (match-end 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 8) (match-end 8)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 9) (match-end 9)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 10) (match-end 10))))<br />
&nbsp; &nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Not a valid match, move to next line and search again.<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (&lt; (point) last)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq valid (markdown-match-includes last)))))<br />
&nbsp; &nbsp; &nbsp; valid)))</p>

<p><br />
;;; Markdown Font Fontification Functions =====================================</p>

<p>(defun markdown-fontify-headings (last)<br />
&nbsp; &quot;Add text properties to headings from point to LAST.&quot;<br />
&nbsp; (when (markdown-match-propertized-text &#39;markdown-heading last)<br />
&nbsp; &nbsp; (let* ((level (markdown-outline-level))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(heading-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (intern (format &quot;markdown-header-face-%d&quot; level)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(heading-props `(face ,heading-face))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markup-props `(face markdown-header-delimiter-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,@(when markdown-hide-markup `(display &quot;&quot;))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(rule-props `(face markdown-header-rule-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,@(when markdown-hide-markup `(display &quot;&quot;)))))<br />
&nbsp; &nbsp; &nbsp; (if (match-end 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Setext heading<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn (add-text-properties<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 1) (match-end 1) heading-props)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(if (= level 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(add-text-properties<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 2) (match-end 2) rule-props)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(add-text-properties<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-beginning 3) (match-end 3) rule-props)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; atx heading<br />
&nbsp; &nbsp; &nbsp; &nbsp; (add-text-properties<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-beginning 4) (match-end 4) markup-props)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (add-text-properties<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-beginning 5) (match-end 5) heading-props)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (match-end 6)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (add-text-properties<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-beginning 6) (match-end 6) markup-props))))<br />
&nbsp; &nbsp; t))</p>

<p>(defun markdown-fontify-blockquotes (last)<br />
&nbsp; &quot;Apply font-lock properties to blockquotes from point to LAST.&quot;<br />
&nbsp; (when (markdown-match-blockquotes last)<br />
&nbsp; &nbsp; (add-text-properties<br />
&nbsp; &nbsp; &nbsp;(match-beginning 1) (match-end 1)<br />
&nbsp; &nbsp; &nbsp;(if markdown-hide-markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;`(face markdown-blockquote-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; display ,markdown-blockquote-display-char)<br />
&nbsp; &nbsp; &nbsp; &nbsp;`(face markdown-markup-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,@(when markdown-hide-markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; `(display ,markdown-blockquote-display-char)))))<br />
&nbsp; &nbsp; (font-lock-append-text-property<br />
&nbsp; &nbsp; &nbsp;(match-beginning 0) (match-end 0) &#39;face &#39;markdown-blockquote-face)<br />
&nbsp; &nbsp; t))</p>

<p>(defun markdown-fontify-list-items (last)<br />
&nbsp; &quot;Apply font-lock properties to list markers from point to LAST.&quot;<br />
&nbsp; (when (markdown-match-list-items last)<br />
&nbsp; &nbsp; (let* ((indent (length (match-string-no-properties 1)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(level (/ indent 4)) ;; level = 0, 1, 2, ...<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(bullet (nth (mod level (length markdown-list-item-bullets))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; markdown-list-item-bullets)))<br />
&nbsp; &nbsp; &nbsp; (add-text-properties<br />
&nbsp; &nbsp; &nbsp; &nbsp;(match-beginning 2) (match-end 2) &#39;(face markdown-list-face))<br />
&nbsp; &nbsp; &nbsp; (when markdown-hide-markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Unordered lists<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((string-match-p &quot;[\\*\\+-]&quot; (match-string 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (add-text-properties<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-beginning 2) (match-end 2) `(display ,bullet)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Definition lists<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((string-equal &quot;:&quot; (match-string 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (add-text-properties<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-beginning 2) (match-end 2)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;`(display ,(char-to-string markdown-definition-display-char)))))))<br />
&nbsp; &nbsp; t))</p>

<p>(defun markdown-fontify-hrs (last)<br />
&nbsp; &quot;Add text properties to horizontal rules from point to LAST.&quot;<br />
&nbsp; (when (markdown-match-hr last)<br />
&nbsp; &nbsp; (add-text-properties<br />
&nbsp; &nbsp; &nbsp;(match-beginning 0) (match-end 0)<br />
&nbsp; &nbsp; &nbsp;`(face markdown-hr-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; font-lock-multiline t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,@(when markdown-hide-markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; `(display ,(make-string<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (window-body-width) markdown-hr-display-char)))))<br />
&nbsp; &nbsp; &nbsp;t))</p>

<p>(defun markdown-fontify-sub-superscripts (last)<br />
&nbsp; &quot;Apply text properties to sub- and superscripts from point to LAST.&quot;<br />
&nbsp; (when (markdown-search-until-condition<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(lambda () (and (not (markdown-code-block-at-point-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (markdown-inline-code-at-point-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (markdown-in-comment-p))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-regex-sub-superscript last t)<br />
&nbsp; &nbsp; (let* ((subscript-p (string= (match-string 2) &quot;~&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(index (if subscript-p 0 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(mp (list &#39;face &#39;markdown-markup-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;invisible &#39;markdown-markup)))<br />
&nbsp; &nbsp; &nbsp; (when markdown-hide-markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; (put-text-property (match-beginning 3) (match-end 3)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;display<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(nth index markdown-sub-superscript-display)))<br />
&nbsp; &nbsp; &nbsp; (add-text-properties (match-beginning 2) (match-end 2) mp)<br />
&nbsp; &nbsp; &nbsp; (add-text-properties (match-beginning 4) (match-end 4) mp)<br />
&nbsp; &nbsp; &nbsp; t)))</p>

<p><br />
;;; Syntax Table ==============================================================</p>

<p>(defvar markdown-mode-syntax-table<br />
&nbsp; (let ((tab (make-syntax-table text-mode-syntax-table)))<br />
&nbsp; &nbsp; (modify-syntax-entry ?\&quot; &quot;.&quot; tab)<br />
&nbsp; &nbsp; tab)<br />
&nbsp; &quot;Syntax table for `markdown-mode&#39;.&quot;)</p>

<p><br />
;;; Element Insertion =========================================================</p>

<p>(defun markdown-ensure-blank-line-before ()<br />
&nbsp; &quot;If previous line is not already blank, insert a blank line before point.&quot;<br />
&nbsp; (unless (bolp) (insert &quot;\n&quot;))<br />
&nbsp; (unless (or (bobp) (looking-back &quot;\n\\s-*\n&quot; nil)) (insert &quot;\n&quot;)))</p>

<p>(defun markdown-ensure-blank-line-after ()<br />
&nbsp; &quot;If following line is not already blank, insert a blank line after point.<br />
Return the point where it was originally.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (unless (eolp) (insert &quot;\n&quot;))<br />
&nbsp; &nbsp; (unless (or (eobp) (looking-at-p &quot;\n\\s-*\n&quot;)) (insert &quot;\n&quot;))))</p>

<p>(defun markdown-wrap-or-insert (s1 s2 &amp;optional thing beg end)<br />
&nbsp; &quot;Insert the strings S1 and S2, wrapping around region or THING.<br />
If a region is specified by the optional BEG and END arguments,<br />
wrap the strings S1 and S2 around that region.<br />
If there is an active region, wrap the strings S1 and S2 around<br />
the region. &nbsp;If there is not an active region but the point is at<br />
THING, wrap that thing (which defaults to word). &nbsp;Otherwise, just<br />
insert S1 and S2 and place the cursor in between. &nbsp;Return the<br />
bounds of the entire wrapped string, or nil if nothing was wrapped<br />
and S1 and S2 were only inserted.&quot;<br />
&nbsp; (let (a b bounds new-point)<br />
&nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp;;; Given region<br />
&nbsp; &nbsp; &nbsp;((and beg end)<br />
&nbsp; &nbsp; &nbsp; (setq a beg<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; b end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; new-point (+ (point) (length s1))))<br />
&nbsp; &nbsp; &nbsp;;; Active region<br />
&nbsp; &nbsp; &nbsp;((markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; (setq a (region-beginning)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; b (region-end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; new-point (+ (point) (length s1))))<br />
&nbsp; &nbsp; &nbsp;;; Thing (word) at point<br />
&nbsp; &nbsp; &nbsp;((setq bounds (markdown-bounds-of-thing-at-point (or thing &#39;word)))<br />
&nbsp; &nbsp; &nbsp; (setq a (car bounds)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; b (cdr bounds)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; new-point (+ (point) (length s1))))<br />
&nbsp; &nbsp; &nbsp;;; No active region and no word<br />
&nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; (setq a (point)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; b (point))))<br />
&nbsp; &nbsp; (goto-char b)<br />
&nbsp; &nbsp; (insert s2)<br />
&nbsp; &nbsp; (goto-char a)<br />
&nbsp; &nbsp; (insert s1)<br />
&nbsp; &nbsp; (when new-point (goto-char new-point))<br />
&nbsp; &nbsp; (if (= a b)<br />
&nbsp; &nbsp; &nbsp; &nbsp; nil<br />
&nbsp; &nbsp; &nbsp; (setq b (+ b (length s1) (length s2)))<br />
&nbsp; &nbsp; &nbsp; (cons a b))))</p>

<p>(defun markdown-point-after-unwrap (cur prefix suffix)<br />
&nbsp; &quot;Return desired position of point after an unwrapping operation.<br />
CUR gives the position of the point before the operation.<br />
Additionally, two cons cells must be provided. &nbsp;PREFIX gives the<br />
bounds of the prefix string and SUFFIX gives the bounds of the<br />
suffix string.&quot;<br />
&nbsp; (cond ((&lt; cur (cdr prefix)) (car prefix))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ((&lt; cur (car suffix)) (- cur (- (cdr prefix) (car prefix))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ((&lt;= cur (cdr suffix))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(- cur (+ (- (cdr prefix) (car prefix))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(- cur (car suffix)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (t cur)))</p>

<p>(defun markdown-unwrap-thing-at-point (regexp all text)<br />
&nbsp; &quot;Remove prefix and suffix of thing at point and reposition the point.<br />
When the thing at point matches REGEXP, replace the subexpression<br />
ALL with the string in subexpression TEXT. &nbsp;Reposition the point<br />
in an appropriate location accounting for the removal of prefix<br />
and suffix strings. &nbsp;Return new bounds of string from group TEXT.<br />
When REGEXP is nil, assumes match data is already set.&quot;<br />
&nbsp; (when (or (null regexp)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (thing-at-point-looking-at regexp))<br />
&nbsp; &nbsp; (let ((cur (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (prefix (cons (match-beginning all) (match-beginning text)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (suffix (cons (match-end text) (match-end all)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (bounds (cons (match-beginning text) (match-end text))))<br />
&nbsp; &nbsp; &nbsp; ;; Replace the thing at point<br />
&nbsp; &nbsp; &nbsp; (replace-match (match-string text) t t nil all)<br />
&nbsp; &nbsp; &nbsp; ;; Reposition the point<br />
&nbsp; &nbsp; &nbsp; (goto-char (markdown-point-after-unwrap cur prefix suffix))<br />
&nbsp; &nbsp; &nbsp; ;; Adjust bounds<br />
&nbsp; &nbsp; &nbsp; (setq bounds (cons (car prefix)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(- (cdr bounds) (- (cdr prefix) (car prefix))))))))</p>

<p>(defun markdown-unwrap-things-in-region (beg end regexp all text)<br />
&nbsp; &quot;Remove prefix and suffix of all things in region from BEG to END.<br />
When a thing in the region matches REGEXP, replace the<br />
subexpression ALL with the string in subexpression TEXT.<br />
Return a cons cell containing updated bounds for the region.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char beg)<br />
&nbsp; &nbsp; (let ((removed 0) len-all len-text)<br />
&nbsp; &nbsp; &nbsp; (while (re-search-forward regexp (- end removed) t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq len-all (length (match-string-no-properties all)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq len-text (length (match-string-no-properties text)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq removed (+ removed (- len-all len-text)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (replace-match (match-string text) t t nil all))<br />
&nbsp; &nbsp; &nbsp; (cons beg (- end removed)))))</p>

<p>(defun markdown-insert-hr (arg)<br />
&nbsp; &quot;Insert or replace a horizonal rule.<br />
By default, use the first element of `markdown-hr-strings&#39;. &nbsp;When<br />
ARG is non-nil, as when given a prefix, select a different<br />
element as follows. &nbsp;When prefixed with \\[universal-argument],<br />
use the last element of `markdown-hr-strings&#39; instead. &nbsp;When<br />
prefixed with an integer from 1 to the length of<br />
`markdown-hr-strings&#39;, use the element in that position instead.&quot;<br />
&nbsp; (interactive &quot;*P&quot;)<br />
&nbsp; (when (thing-at-point-looking-at markdown-regex-hr)<br />
&nbsp; &nbsp; (delete-region (match-beginning 0) (match-end 0)))<br />
&nbsp; (markdown-ensure-blank-line-before)<br />
&nbsp; (cond ((equal arg &#39;(4))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(insert (car (reverse markdown-hr-strings))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ((and (integerp arg) (&gt; arg 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&lt;= arg (length markdown-hr-strings)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(insert (nth (1- arg) markdown-hr-strings)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(insert (car markdown-hr-strings))))<br />
&nbsp; (markdown-ensure-blank-line-after))</p>

<p>(defun markdown-insert-bold ()<br />
&nbsp; &quot;Insert markup to make a region or word bold.<br />
If there is an active region, make the region bold. &nbsp;If the point<br />
is at a non-bold word, make the word bold. &nbsp;If the point is at a<br />
bold word or phrase, remove the bold markup. &nbsp;Otherwise, simply<br />
insert bold delimiters and place the cursor in between them.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((delim (if markdown-bold-underscore &quot;__&quot; &quot;**&quot;)))<br />
&nbsp; &nbsp; (if (markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Active region<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let ((bounds (markdown-unwrap-things-in-region<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(region-beginning) (region-end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-regex-bold 2 4)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-wrap-or-insert delim delim nil (car bounds) (cdr bounds)))<br />
&nbsp; &nbsp; &nbsp; ;; Bold markup removal, bold word at point, or empty markup insertion<br />
&nbsp; &nbsp; &nbsp; (if (thing-at-point-looking-at markdown-regex-bold)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-unwrap-thing-at-point nil 2 4)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-wrap-or-insert delim delim &#39;word nil nil)))))</p>

<p>(defun markdown-insert-italic ()<br />
&nbsp; &quot;Insert markup to make a region or word italic.<br />
If there is an active region, make the region italic. &nbsp;If the point<br />
is at a non-italic word, make the word italic. &nbsp;If the point is at an<br />
italic word or phrase, remove the italic markup. &nbsp;Otherwise, simply<br />
insert italic delimiters and place the cursor in between them.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((delim (if markdown-italic-underscore &quot;_&quot; &quot;*&quot;)))<br />
&nbsp; &nbsp; (if (markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Active region<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let ((bounds (markdown-unwrap-things-in-region<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(region-beginning) (region-end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-regex-italic 1 3)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-wrap-or-insert delim delim nil (car bounds) (cdr bounds)))<br />
&nbsp; &nbsp; &nbsp; ;; Italic markup removal, italic word at point, or empty markup insertion<br />
&nbsp; &nbsp; &nbsp; (if (thing-at-point-looking-at markdown-regex-italic)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-unwrap-thing-at-point nil 1 3)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-wrap-or-insert delim delim &#39;word nil nil)))))</p>

<p>(defun markdown-insert-strike-through ()<br />
&nbsp; &quot;Insert markup to make a region or word strikethrough.<br />
If there is an active region, make the region strikethrough. &nbsp;If the point<br />
is at a non-bold word, make the word strikethrough. &nbsp;If the point is at a<br />
strikethrough word or phrase, remove the strikethrough markup. &nbsp;Otherwise,<br />
simply insert bold delimiters and place the cursor in between them.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((delim &quot;~~&quot;))<br />
&nbsp; &nbsp; (if (markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Active region<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let ((bounds (markdown-unwrap-things-in-region<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(region-beginning) (region-end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-regex-strike-through 2 4)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-wrap-or-insert delim delim nil (car bounds) (cdr bounds)))<br />
&nbsp; &nbsp; &nbsp; ;; Strikethrough markup removal, strikethrough word at point, or empty markup insertion<br />
&nbsp; &nbsp; &nbsp; (if (thing-at-point-looking-at markdown-regex-strike-through)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-unwrap-thing-at-point nil 2 4)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-wrap-or-insert delim delim &#39;word nil nil)))))</p>

<p>(defun markdown-insert-code ()<br />
&nbsp; &quot;Insert markup to make a region or word an inline code fragment.<br />
If there is an active region, make the region an inline code<br />
fragment. &nbsp;If the point is at a word, make the word an inline<br />
code fragment. &nbsp;Otherwise, simply insert code delimiters and<br />
place the cursor in between them.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (if (markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; ;; Active region<br />
&nbsp; &nbsp; &nbsp; (let ((bounds (markdown-unwrap-things-in-region<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(region-beginning) (region-end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-regex-code 1 3)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-wrap-or-insert &quot;`&quot; &quot;`&quot; nil (car bounds) (cdr bounds)))<br />
&nbsp; &nbsp; ;; Code markup removal, code markup for word, or empty markup insertion<br />
&nbsp; &nbsp; (if (markdown-inline-code-at-point)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-unwrap-thing-at-point nil 0 2)<br />
&nbsp; &nbsp; &nbsp; (markdown-wrap-or-insert &quot;`&quot; &quot;`&quot; &#39;word nil nil))))</p>

<p>(defun markdown-insert-kbd ()<br />
&nbsp; &quot;Insert markup to wrap region or word in &lt;kbd&gt; tags.<br />
If there is an active region, use the region. &nbsp;If the point is at<br />
a word, use the word. &nbsp;Otherwise, simply insert &lt;kbd&gt; tags and<br />
place the cursor in between them.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (if (markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; ;; Active region<br />
&nbsp; &nbsp; &nbsp; (let ((bounds (markdown-unwrap-things-in-region<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(region-beginning) (region-end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-regex-kbd 0 2)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-wrap-or-insert &quot;&lt;kbd&gt;&quot; &quot;&lt;/kbd&gt;&quot; nil (car bounds) (cdr bounds)))<br />
&nbsp; &nbsp; ;; Markup removal, markup for word, or empty markup insertion<br />
&nbsp; &nbsp; (if (thing-at-point-looking-at markdown-regex-kbd)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-unwrap-thing-at-point nil 0 2)<br />
&nbsp; &nbsp; &nbsp; (markdown-wrap-or-insert &quot;&lt;kbd&gt;&quot; &quot;&lt;/kbd&gt;&quot; &#39;word nil nil))))</p>

<p>(defun markdown-insert-inline-link (text url &amp;optional title)<br />
&nbsp; &quot;Insert an inline link with TEXT pointing to URL.<br />
Optionally, the user can provide a TITLE.&quot;<br />
&nbsp; (let ((cur (point)))<br />
&nbsp; &nbsp; (setq title (and title (concat &quot; \&quot;&quot; title &quot;\&quot;&quot;)))<br />
&nbsp; &nbsp; (insert (concat &quot;[&quot; text &quot;](&quot; url title &quot;)&quot;))<br />
&nbsp; &nbsp; (cond ((not text) (goto-char (+ 1 cur)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((not url) (goto-char (+ 3 (length text) cur))))))</p>

<p>(defun markdown-insert-inline-image (text url &amp;optional title)<br />
&nbsp; &quot;Insert an inline link with alt TEXT pointing to URL.<br />
Optionally, also provide a TITLE.&quot;<br />
&nbsp; (let ((cur (point)))<br />
&nbsp; &nbsp; (setq title (and title (concat &quot; \&quot;&quot; title &quot;\&quot;&quot;)))<br />
&nbsp; &nbsp; (insert (concat &quot;![&quot; text &quot;](&quot; url title &quot;)&quot;))<br />
&nbsp; &nbsp; (cond ((not text) (goto-char (+ 2 cur)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((not url) (goto-char (+ 4 (length text) cur))))))</p>

<p>(defun markdown-insert-reference-link (text label &amp;optional url title)<br />
&nbsp; &quot;Insert a reference link and, optionally, a reference definition.<br />
The link TEXT will be inserted followed by the optional LABEL.<br />
If a URL is given, also insert a definition for the reference<br />
LABEL according to `markdown-reference-location&#39;. &nbsp;If a TITLE is<br />
given, it will be added to the end of the reference definition<br />
and will be used to populate the title attribute when converted<br />
to XHTML. &nbsp;If URL is nil, insert only the link portion (for<br />
example, when a reference label is already defined).&quot;<br />
&nbsp; (insert (concat &quot;[&quot; text &quot;][&quot; label &quot;]&quot;))<br />
&nbsp; (when url<br />
&nbsp; &nbsp; (markdown-insert-reference-definition<br />
&nbsp; &nbsp; &nbsp;(if (string-equal label &quot;&quot;) text label)<br />
&nbsp; &nbsp; &nbsp;url title)))</p>

<p>(defun markdown-insert-reference-image (text label &amp;optional url title)<br />
&nbsp; &quot;Insert a reference image and, optionally, a reference definition.<br />
The alt TEXT will be inserted followed by the optional LABEL.<br />
If a URL is given, also insert a definition for the reference<br />
LABEL according to `markdown-reference-location&#39;. &nbsp;If a TITLE is<br />
given, it will be added to the end of the reference definition<br />
and will be used to populate the title attribute when converted<br />
to XHTML. &nbsp;If URL is nil, insert only the link portion (for<br />
example, when a reference label is already defined).&quot;<br />
&nbsp; (insert (concat &quot;![&quot; text &quot;][&quot; label &quot;]&quot;))<br />
&nbsp; (when url<br />
&nbsp; &nbsp; (markdown-insert-reference-definition<br />
&nbsp; &nbsp; &nbsp;(if (string-equal label &quot;&quot;) text label)<br />
&nbsp; &nbsp; &nbsp;url title)))</p>

<p>(defun markdown-insert-reference-definition (label &amp;optional url title)<br />
&nbsp; &quot;Add definition for reference LABEL with URL and TITLE.<br />
LABEL is a Markdown reference label without square brackets.<br />
URL and TITLE are optional. &nbsp;When given, the TITLE will<br />
be used to populate the title attribute when converted to XHTML.&quot;<br />
&nbsp; ;; END specifies where to leave the point upon return<br />
&nbsp; (let ((end (point)))<br />
&nbsp; &nbsp; (cl-case markdown-reference-location<br />
&nbsp; &nbsp; &nbsp; (end &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (point-max)))<br />
&nbsp; &nbsp; &nbsp; (immediately (markdown-end-of-text-block))<br />
&nbsp; &nbsp; &nbsp; (subtree &nbsp; &nbsp; (markdown-end-of-subtree))<br />
&nbsp; &nbsp; &nbsp; (header &nbsp; &nbsp; &nbsp;(markdown-end-of-defun)))<br />
&nbsp; &nbsp; (unless (or (markdown-cur-line-blank-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (thing-at-point-looking-at markdown-regex-reference-definition))<br />
&nbsp; &nbsp; &nbsp; (insert &quot;\n&quot;))<br />
&nbsp; &nbsp; (insert &quot;\n[&quot; label &quot;]: &quot;)<br />
&nbsp; &nbsp; (if url<br />
&nbsp; &nbsp; &nbsp; &nbsp; (insert url)<br />
&nbsp; &nbsp; &nbsp; ;; When no URL is given, leave cursor at END following the colon<br />
&nbsp; &nbsp; &nbsp; (setq end (point)))<br />
&nbsp; &nbsp; (when (&gt; (length title) 0)<br />
&nbsp; &nbsp; &nbsp; (insert &quot; \&quot;&quot; title &quot;\&quot;&quot;))<br />
&nbsp; &nbsp; (unless (looking-at-p &quot;\n&quot;)<br />
&nbsp; &nbsp; &nbsp; (insert &quot;\n&quot;))<br />
&nbsp; &nbsp; (goto-char end)<br />
&nbsp; &nbsp; (when url<br />
&nbsp; &nbsp; &nbsp; (message<br />
&nbsp; &nbsp; &nbsp; &nbsp;(markdown--substitute-command-keys<br />
&nbsp; &nbsp; &nbsp; &nbsp; &quot;Reference [%s] was defined, press \\[markdown-do] to jump there&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp;label))))</p>

<p>(define-obsolete-function-alias<br />
&nbsp; &#39;markdown-insert-inline-link-dwim &#39;markdown-insert-link &quot;v2.3&quot;)<br />
(define-obsolete-function-alias<br />
&nbsp; &#39;markdown-insert-reference-link-dwim &#39;markdown-insert-link &quot;v2.3&quot;)</p>

<p>(defun markdown--insert-link-or-image (image)<br />
&nbsp; &quot;Interactively insert new or update an existing link or image.<br />
When IMAGE is non-nil, insert an image. &nbsp;Otherwise, insert a link.<br />
This is an internal function called by<br />
`markdown-insert-link&#39; and `markdown-insert-image&#39;.&quot;<br />
&nbsp; (cl-multiple-value-bind (begin end text uri ref title)<br />
&nbsp; &nbsp; &nbsp; (if (markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Use region as either link text or URL as appropriate.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((region (buffer-substring-no-properties<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(region-beginning) (region-end))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (string-match markdown-regex-uri region)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Region contains a URL; use it as such.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (list (region-beginning) (region-end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil (match-string 0 region) nil nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Region doesn&#39;t contain a URL, so use it as text.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (list (region-beginning) (region-end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; region nil nil nil)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Extract and use properties of existing link, if any.<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-link-at-pos (point)))<br />
&nbsp; &nbsp; (let* ((ref (when ref (concat &quot;[&quot; ref &quot;]&quot;)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(defined-refs (append<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (mapcar (lambda (ref) (concat &quot;[&quot; ref &quot;]&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-get-defined-references))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(used-uris (markdown-get-used-uris))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(uri-or-ref (completing-read<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;URL or [reference]: &quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (append defined-refs used-uris)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil nil (or uri ref)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(ref (cond ((string-match &quot;\\`\\[\\(.*\\)\\]\\&#39;&quot; uri-or-ref)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-string 1 uri-or-ref))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((string-equal &quot;&quot; uri-or-ref)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;&quot;)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(uri (unless ref uri-or-ref))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(text-prompt (if image<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;Alt text: &quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if ref<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;Link text: &quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;Link text (blank for plain URL): &quot;)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(text (read-string text-prompt text))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(text (if (= (length text) 0) nil text))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(plainp (and uri (not text)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(implicitp (string-equal ref &quot;&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(ref (if implicitp text ref))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(definedp (and ref (markdown-reference-definition ref)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(ref-url (unless (or uri definedp)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (completing-read &quot;Reference URL: &quot; used-uris)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(title (unless (or plainp definedp)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (read-string &quot;Title (tooltip text, optional): &quot; title)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(title (if (= (length title) 0) nil title)))<br />
&nbsp; &nbsp; &nbsp; (when (and image implicitp)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (user-error &quot;Reference required: implicit image references are invalid&quot;))<br />
&nbsp; &nbsp; &nbsp; (when (and begin end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (delete-region begin end))<br />
&nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp;((and (not image) uri text)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-insert-inline-link text uri title))<br />
&nbsp; &nbsp; &nbsp; &nbsp;((and image uri text)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-insert-inline-image text uri title))<br />
&nbsp; &nbsp; &nbsp; &nbsp;((and ref text)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if image<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-insert-reference-image text (unless implicitp ref) nil title)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-insert-reference-link text (unless implicitp ref) nil title))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (unless definedp<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-insert-reference-definition ref ref-url title)))<br />
&nbsp; &nbsp; &nbsp; &nbsp;((and (not image) uri)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-insert-uri uri))))))</p>

<p>(defun markdown-insert-link ()<br />
&nbsp; &quot;Insert new or update an existing link, with interactive prompts.<br />
If the point is at an existing link or URL, update the link text,<br />
URL, reference label, and/or title. &nbsp;Otherwise, insert a new link.<br />
The type of link inserted (inline, reference, or plain URL)<br />
depends on which values are provided:</p>

<p>* &nbsp; If a URL and TEXT are given, insert an inline link: [TEXT](URL).<br />
* &nbsp; If [REF] and TEXT are given, insert a reference link: [TEXT][REF].<br />
* &nbsp; If only TEXT is given, insert an implicit reference link: [TEXT][].<br />
* &nbsp; If only a URL is given, insert a plain link: &lt;URL&gt;.</p>

<p>In other words, to create an implicit reference link, leave the<br />
URL prompt empty and to create a plain URL link, leave the link<br />
text empty.</p>

<p>If there is an active region, use the text as the default URL, if<br />
it seems to be a URL, or link text value otherwise.</p>

<p>If a given reference is not defined, this function will<br />
additionally prompt for the URL and optional title. &nbsp;In this case,<br />
the reference definition is placed at the location determined by<br />
`markdown-reference-location&#39;.</p>

<p>Through updating the link, this function can be used to convert a<br />
link of one type (inline, reference, or plain) to another type by<br />
selectively adding or removing information via the prompts.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (markdown--insert-link-or-image nil))</p>

<p>(defun markdown-insert-image ()<br />
&nbsp; &quot;Insert new or update an existing image, with interactive prompts.<br />
If the point is at an existing image, update the alt text, URL,<br />
reference label, and/or title. Otherwise, insert a new image.<br />
The type of image inserted (inline or reference) depends on which<br />
values are provided:</p>

<p>* &nbsp; If a URL and ALT-TEXT are given, insert an inline image:<br />
&nbsp; &nbsp; ![ALT-TEXT](URL).<br />
* &nbsp; If [REF] and ALT-TEXT are given, insert a reference image:<br />
&nbsp; &nbsp; ![ALT-TEXT][REF].</p>

<p>If there is an active region, use the text as the default URL, if<br />
it seems to be a URL, or alt text value otherwise.</p>

<p>If a given reference is not defined, this function will<br />
additionally prompt for the URL and optional title. &nbsp;In this case,<br />
the reference definition is placed at the location determined by<br />
`markdown-reference-location&#39;.</p>

<p>Through updating the image, this function can be used to convert an<br />
image of one type (inline or reference) to another type by<br />
selectively adding or removing information via the prompts.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (markdown--insert-link-or-image t))</p>

<p>(defun markdown-insert-uri (&amp;optional uri)<br />
&nbsp; &quot;Insert markup for an inline URI.<br />
If there is an active region, use it as the URI. &nbsp;If the point is<br />
at a URI, wrap it with angle brackets. &nbsp;If the point is at an<br />
inline URI, remove the angle brackets. &nbsp;Otherwise, simply insert<br />
angle brackets place the point between them.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (if (markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; ;; Active region<br />
&nbsp; &nbsp; &nbsp; (let ((bounds (markdown-unwrap-things-in-region<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(region-beginning) (region-end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-regex-angle-uri 0 2)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-wrap-or-insert &quot;&lt;&quot; &quot;&gt;&quot; nil (car bounds) (cdr bounds)))<br />
&nbsp; &nbsp; ;; Markup removal, URI at point, new URI, or empty markup insertion<br />
&nbsp; &nbsp; (if (thing-at-point-looking-at markdown-regex-angle-uri)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-unwrap-thing-at-point nil 0 2)<br />
&nbsp; &nbsp; &nbsp; (if uri<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (insert &quot;&lt;&quot; uri &quot;&gt;&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-wrap-or-insert &quot;&lt;&quot; &quot;&gt;&quot; &#39;url nil nil)))))</p>

<p>(defun markdown-insert-wiki-link ()<br />
&nbsp; &quot;Insert a wiki link of the form [[WikiLink]].<br />
If there is an active region, use the region as the link text.<br />
If the point is at a word, use the word as the link text. &nbsp;If<br />
there is no active region and the point is not at word, simply<br />
insert link markup.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (if (markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; ;; Active region<br />
&nbsp; &nbsp; &nbsp; (markdown-wrap-or-insert &quot;[[&quot; &quot;]]&quot; nil (region-beginning) (region-end))<br />
&nbsp; &nbsp; ;; Markup removal, wiki link at at point, or empty markup insertion<br />
&nbsp; &nbsp; (if (thing-at-point-looking-at markdown-regex-wiki-link)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (or markdown-wiki-link-alias-first<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (null (match-string 5)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-unwrap-thing-at-point nil 1 3)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-unwrap-thing-at-point nil 1 5))<br />
&nbsp; &nbsp; &nbsp; (markdown-wrap-or-insert &quot;[[&quot; &quot;]]&quot;))))</p>

<p>(defun markdown-remove-header ()<br />
&nbsp; &quot;Remove header markup if point is at a header.<br />
Return bounds of remaining header text if a header was removed<br />
and nil otherwise.&quot;<br />
&nbsp; (interactive &quot;*&quot;)<br />
&nbsp; (or (markdown-unwrap-thing-at-point markdown-regex-header-atx 0 2)<br />
&nbsp; &nbsp; &nbsp; (markdown-unwrap-thing-at-point markdown-regex-header-setext 0 1)))</p>

<p>(defun markdown-insert-header (&amp;optional level text setext)<br />
&nbsp; &quot;Insert or replace header markup.<br />
The level of the header is specified by LEVEL and header text is<br />
given by TEXT. &nbsp;LEVEL must be an integer from 1 and 6, and the<br />
default value is 1.<br />
When TEXT is nil, the header text is obtained as follows.<br />
If there is an active region, it is used as the header text.<br />
Otherwise, the current line will be used as the header text.<br />
If there is not an active region and the point is at a header,<br />
remove the header markup and replace with level N header.<br />
Otherwise, insert empty header markup and place the cursor in<br />
between.<br />
The style of the header will be atx (hash marks) unless<br />
SETEXT is non-nil, in which case a setext-style (underlined)<br />
header will be inserted.&quot;<br />
&nbsp; (interactive &quot;p\nsHeader text: &quot;)<br />
&nbsp; (setq level (min (max (or level 1) 1) (if setext 2 6)))<br />
&nbsp; ;; Determine header text if not given<br />
&nbsp; (when (null text)<br />
&nbsp; &nbsp; (if (markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Active region<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq text (delete-and-extract-region (region-beginning) (region-end)))<br />
&nbsp; &nbsp; &nbsp; ;; No active region<br />
&nbsp; &nbsp; &nbsp; (markdown-remove-header)<br />
&nbsp; &nbsp; &nbsp; (setq text (delete-and-extract-region<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (line-beginning-position) (line-end-position)))<br />
&nbsp; &nbsp; &nbsp; (when (and setext (string-match-p &quot;^[ \t]*$&quot; text))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq text (read-string &quot;Header text: &quot;))))<br />
&nbsp; &nbsp; (setq text (markdown-compress-whitespace-string text)))<br />
&nbsp; ;; Insertion with given text<br />
&nbsp; (markdown-ensure-blank-line-before)<br />
&nbsp; (let (hdr)<br />
&nbsp; &nbsp; (cond (setext<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(setq hdr (make-string (string-width text) (if (= level 2) ?- ?=)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(insert text &quot;\n&quot; hdr))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(setq hdr (make-string level ?#))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(insert hdr &quot; &quot; text)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(when (null markdown-asymmetric-header) (insert &quot; &quot; hdr)))))<br />
&nbsp; (markdown-ensure-blank-line-after)<br />
&nbsp; ;; Leave point at end of text<br />
&nbsp; (cond (setext<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(backward-char (1+ (string-width text))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ((null markdown-asymmetric-header)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(backward-char (1+ level)))))</p>

<p>(defun markdown-insert-header-dwim (&amp;optional arg setext)<br />
&nbsp; &quot;Insert or replace header markup.<br />
The level and type of the header are determined automatically by<br />
the type and level of the previous header, unless a prefix<br />
argument is given via ARG.<br />
With a numeric prefix valued 1 to 6, insert a header of the given<br />
level, with the type being determined automatically (note that<br />
only level 1 or 2 setext headers are possible).</p>

<p>With a \\[universal-argument] prefix (i.e., when ARG is (4)),<br />
promote the heading by one level.<br />
With two \\[universal-argument] prefixes (i.e., when ARG is (16)),<br />
demote the heading by one level.<br />
When SETEXT is non-nil, prefer setext-style headers when<br />
possible (levels one and two).</p>

<p>When there is an active region, use it for the header text. &nbsp;When<br />
the point is at an existing header, change the type and level<br />
according to the rules above.<br />
Otherwise, if the line is not empty, create a header using the<br />
text on the current line as the header text.<br />
Finally, if the point is on a blank line, insert empty header<br />
markup (atx) or prompt for text (setext).<br />
See `markdown-insert-header&#39; for more details about how the<br />
header text is determined.&quot;<br />
&nbsp; (interactive &quot;*P&quot;)<br />
&nbsp; (let (level)<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (when (or (thing-at-point-looking-at markdown-regex-header)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-backward markdown-regex-header nil t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; level of current or previous header<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq level (markdown-outline-level))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; match group 1 indicates a setext header<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq setext (match-end 1))))<br />
&nbsp; &nbsp; ;; check prefix argument<br />
&nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp;((and (equal arg &#39;(4)) level (&gt; level 1)) ;; C-u<br />
&nbsp; &nbsp; &nbsp; (cl-decf level))<br />
&nbsp; &nbsp; &nbsp;((and (equal arg &#39;(16)) level (&lt; level 6)) ;; C-u C-u<br />
&nbsp; &nbsp; &nbsp; (cl-incf level))<br />
&nbsp; &nbsp; &nbsp;(arg ;; numeric prefix<br />
&nbsp; &nbsp; &nbsp; (setq level (prefix-numeric-value arg))))<br />
&nbsp; &nbsp; ;; setext headers must be level one or two<br />
&nbsp; &nbsp; (and level (setq setext (and setext (&lt;= level 2))))<br />
&nbsp; &nbsp; ;; insert the heading<br />
&nbsp; &nbsp; (markdown-insert-header level nil setext)))</p>

<p>(defun markdown-insert-header-setext-dwim (&amp;optional arg)<br />
&nbsp; &quot;Insert or replace header markup, with preference for setext.<br />
See `markdown-insert-header-dwim&#39; for details, including how ARG is handled.&quot;<br />
&nbsp; (interactive &quot;*P&quot;)<br />
&nbsp; (markdown-insert-header-dwim arg t))</p>

<p>(defun markdown-insert-header-atx-1 ()<br />
&nbsp; &quot;Insert a first level atx-style (hash mark) header.<br />
See `markdown-insert-header&#39;.&quot;<br />
&nbsp; (interactive &quot;*&quot;)<br />
&nbsp; (markdown-insert-header 1 nil nil))</p>

<p>(defun markdown-insert-header-atx-2 ()<br />
&nbsp; &quot;Insert a level two atx-style (hash mark) header.<br />
See `markdown-insert-header&#39;.&quot;<br />
&nbsp; (interactive &quot;*&quot;)<br />
&nbsp; (markdown-insert-header 2 nil nil))</p>

<p>(defun markdown-insert-header-atx-3 ()<br />
&nbsp; &quot;Insert a level three atx-style (hash mark) header.<br />
See `markdown-insert-header&#39;.&quot;<br />
&nbsp; (interactive &quot;*&quot;)<br />
&nbsp; (markdown-insert-header 3 nil nil))</p>

<p>(defun markdown-insert-header-atx-4 ()<br />
&nbsp; &quot;Insert a level four atx-style (hash mark) header.<br />
See `markdown-insert-header&#39;.&quot;<br />
&nbsp; (interactive &quot;*&quot;)<br />
&nbsp; (markdown-insert-header 4 nil nil))</p>

<p>(defun markdown-insert-header-atx-5 ()<br />
&nbsp; &quot;Insert a level five atx-style (hash mark) header.<br />
See `markdown-insert-header&#39;.&quot;<br />
&nbsp; (interactive &quot;*&quot;)<br />
&nbsp; (markdown-insert-header 5 nil nil))</p>

<p>(defun markdown-insert-header-atx-6 ()<br />
&nbsp; &quot;Insert a sixth level atx-style (hash mark) header.<br />
See `markdown-insert-header&#39;.&quot;<br />
&nbsp; (interactive &quot;*&quot;)<br />
&nbsp; (markdown-insert-header 6 nil nil))</p>

<p>(defun markdown-insert-header-setext-1 ()<br />
&nbsp; &quot;Insert a setext-style (underlined) first-level header.<br />
See `markdown-insert-header&#39;.&quot;<br />
&nbsp; (interactive &quot;*&quot;)<br />
&nbsp; (markdown-insert-header 1 nil t))</p>

<p>(defun markdown-insert-header-setext-2 ()<br />
&nbsp; &quot;Insert a setext-style (underlined) second-level header.<br />
See `markdown-insert-header&#39;.&quot;<br />
&nbsp; (interactive &quot;*&quot;)<br />
&nbsp; (markdown-insert-header 2 nil t))</p>

<p>(defun markdown-blockquote-indentation (loc)<br />
&nbsp; &quot;Return string containing necessary indentation for a blockquote at LOC.<br />
Also see `markdown-pre-indentation&#39;.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char loc)<br />
&nbsp; &nbsp; (let* ((list-level (length (markdown-calculate-list-levels)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(indent &quot;&quot;))<br />
&nbsp; &nbsp; &nbsp; (dotimes (_ list-level indent)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq indent (concat indent &quot; &nbsp; &nbsp;&quot;))))))</p>

<p>(defun markdown-insert-blockquote ()<br />
&nbsp; &quot;Start a blockquote section (or blockquote the region).<br />
If Transient Mark mode is on and a region is active, it is used as<br />
the blockquote text.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (if (markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; (markdown-blockquote-region (region-beginning) (region-end))<br />
&nbsp; &nbsp; (markdown-ensure-blank-line-before)<br />
&nbsp; &nbsp; (insert (markdown-blockquote-indentation (point)) &quot;&gt; &quot;)<br />
&nbsp; &nbsp; (markdown-ensure-blank-line-after)))</p>

<p>(defun markdown-block-region (beg end prefix)<br />
&nbsp; &quot;Format the region using a block prefix.<br />
Arguments BEG and END specify the beginning and end of the<br />
region. &nbsp;The characters PREFIX will appear at the beginning<br />
of each line.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (let* ((end-marker (make-marker))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(beg-marker (make-marker)))<br />
&nbsp; &nbsp; &nbsp; ;; Ensure blank line after and remove extra whitespace<br />
&nbsp; &nbsp; &nbsp; (goto-char end)<br />
&nbsp; &nbsp; &nbsp; (skip-syntax-backward &quot;-&quot;)<br />
&nbsp; &nbsp; &nbsp; (set-marker end-marker (point))<br />
&nbsp; &nbsp; &nbsp; (delete-horizontal-space)<br />
&nbsp; &nbsp; &nbsp; (markdown-ensure-blank-line-after)<br />
&nbsp; &nbsp; &nbsp; ;; Ensure blank line before and remove extra whitespace<br />
&nbsp; &nbsp; &nbsp; (goto-char beg)<br />
&nbsp; &nbsp; &nbsp; (skip-syntax-forward &quot;-&quot;)<br />
&nbsp; &nbsp; &nbsp; (delete-horizontal-space)<br />
&nbsp; &nbsp; &nbsp; (markdown-ensure-blank-line-before)<br />
&nbsp; &nbsp; &nbsp; (set-marker beg-marker (point))<br />
&nbsp; &nbsp; &nbsp; ;; Insert PREFIX before each line<br />
&nbsp; &nbsp; &nbsp; (goto-char beg-marker)<br />
&nbsp; &nbsp; &nbsp; (while (and (&lt; (line-beginning-position) end-marker)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (eobp)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (insert prefix)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line)))))</p>

<p>(defun markdown-blockquote-region (beg end)<br />
&nbsp; &quot;Blockquote the region.<br />
Arguments BEG and END specify the beginning and end of the region.&quot;<br />
&nbsp; (interactive &quot;*r&quot;)<br />
&nbsp; (markdown-block-region<br />
&nbsp; &nbsp;beg end (concat (markdown-blockquote-indentation<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (max (point-min) (1- beg))) &quot;&gt; &quot;)))</p>

<p>(defun markdown-pre-indentation (loc)<br />
&nbsp; &quot;Return string containing necessary whitespace for a pre block at LOC.<br />
Also see `markdown-blockquote-indentation&#39;.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char loc)<br />
&nbsp; &nbsp; (let* ((list-level (length (markdown-calculate-list-levels)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;indent)<br />
&nbsp; &nbsp; &nbsp; (dotimes (_ (1+ list-level) indent)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq indent (concat indent &quot; &nbsp; &nbsp;&quot;))))))</p>

<p>(defun markdown-insert-pre ()<br />
&nbsp; &quot;Start a preformatted section (or apply to the region).<br />
If Transient Mark mode is on and a region is active, it is marked<br />
as preformatted text.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (if (markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; (markdown-pre-region (region-beginning) (region-end))<br />
&nbsp; &nbsp; (markdown-ensure-blank-line-before)<br />
&nbsp; &nbsp; (insert (markdown-pre-indentation (point)))<br />
&nbsp; &nbsp; (markdown-ensure-blank-line-after)))</p>

<p>(defun markdown-pre-region (beg end)<br />
&nbsp; &quot;Format the region as preformatted text.<br />
Arguments BEG and END specify the beginning and end of the region.&quot;<br />
&nbsp; (interactive &quot;*r&quot;)<br />
&nbsp; (let ((indent (markdown-pre-indentation (max (point-min) (1- beg)))))<br />
&nbsp; &nbsp; (markdown-block-region beg end indent)))</p>

<p>(defun markdown-electric-backquote (arg)<br />
&nbsp; &quot;Insert a backquote.<br />
The numeric prefix argument ARG says how many times to repeat the insertion.<br />
Call `markdown-insert-gfm-code-block&#39; interactively<br />
if three backquotes inserted at the beginning of line.&quot;<br />
&nbsp; (interactive &quot;*P&quot;)<br />
&nbsp; (self-insert-command (prefix-numeric-value arg))<br />
&nbsp; (when (and markdown-gfm-use-electric-backquote (looking-back &quot;^```&quot; nil))<br />
&nbsp; &nbsp; (replace-match &quot;&quot;)<br />
&nbsp; &nbsp; (call-interactively #&#39;markdown-insert-gfm-code-block)))</p>

<p>(defconst markdown-gfm-recognized-languages<br />
&nbsp; ;; To reproduce/update, evaluate the let-form in<br />
&nbsp; ;; scripts/get-recognized-gfm-languages.el. that produces a single long sexp,<br />
&nbsp; ;; but with appropriate use of a keyboard macro, indenting and filling it<br />
&nbsp; ;; properly is pretty fast.<br />
&nbsp; &#39;(&quot;1C-Enterprise&quot; &quot;ABAP&quot; &quot;ABNF&quot; &quot;AGS-Script&quot; &quot;AMPL&quot; &quot;ANTLR&quot;<br />
&nbsp; &nbsp; &quot;API-Blueprint&quot; &quot;APL&quot; &quot;ASN.1&quot; &quot;ASP&quot; &quot;ATS&quot; &quot;ActionScript&quot; &quot;Ada&quot; &quot;Agda&quot;<br />
&nbsp; &nbsp; &quot;Alloy&quot; &quot;Alpine-Abuild&quot; &quot;Ant-Build-System&quot; &quot;ApacheConf&quot; &quot;Apex&quot;<br />
&nbsp; &nbsp; &quot;Apollo-Guidance-Computer&quot; &quot;AppleScript&quot; &quot;Arc&quot; &quot;Arduino&quot; &quot;AsciiDoc&quot;<br />
&nbsp; &nbsp; &quot;AspectJ&quot; &quot;Assembly&quot; &quot;Augeas&quot; &quot;AutoHotkey&quot; &quot;AutoIt&quot; &quot;Awk&quot; &quot;Batchfile&quot;<br />
&nbsp; &nbsp; &quot;Befunge&quot; &quot;Bison&quot; &quot;BitBake&quot; &quot;Blade&quot; &quot;BlitzBasic&quot; &quot;BlitzMax&quot; &quot;Bluespec&quot;<br />
&nbsp; &nbsp; &quot;Boo&quot; &quot;Brainfuck&quot; &quot;Brightscript&quot; &quot;Bro&quot; &quot;C#&quot; &quot;C++&quot; &quot;C-ObjDump&quot;<br />
&nbsp; &nbsp; &quot;C2hs-Haskell&quot; &quot;CLIPS&quot; &quot;CMake&quot; &quot;COBOL&quot; &quot;COLLADA&quot; &quot;CSON&quot; &quot;CSS&quot; &quot;CSV&quot;<br />
&nbsp; &nbsp; &quot;CWeb&quot; &quot;Cap&#39;n-Proto&quot; &quot;CartoCSS&quot; &quot;Ceylon&quot; &quot;Chapel&quot; &quot;Charity&quot; &quot;ChucK&quot;<br />
&nbsp; &nbsp; &quot;Cirru&quot; &quot;Clarion&quot; &quot;Clean&quot; &quot;Click&quot; &quot;Clojure&quot; &quot;Closure-Templates&quot;<br />
&nbsp; &nbsp; &quot;CoffeeScript&quot; &quot;ColdFusion&quot; &quot;ColdFusion-CFC&quot; &quot;Common-Lisp&quot;<br />
&nbsp; &nbsp; &quot;Component-Pascal&quot; &quot;Cool&quot; &quot;Coq&quot; &quot;Cpp-ObjDump&quot; &quot;Creole&quot; &quot;Crystal&quot;<br />
&nbsp; &nbsp; &quot;Csound&quot; &quot;Csound-Document&quot; &quot;Csound-Score&quot; &quot;Cuda&quot; &quot;Cycript&quot; &quot;Cython&quot;<br />
&nbsp; &nbsp; &quot;D-ObjDump&quot; &quot;DIGITAL-Command-Language&quot; &quot;DM&quot; &quot;DNS-Zone&quot; &quot;DTrace&quot;<br />
&nbsp; &nbsp; &quot;Darcs-Patch&quot; &quot;Dart&quot; &quot;Diff&quot; &quot;Dockerfile&quot; &quot;Dogescript&quot; &quot;Dylan&quot; &quot;EBNF&quot;<br />
&nbsp; &nbsp; &quot;ECL&quot; &quot;ECLiPSe&quot; &quot;EJS&quot; &quot;EQ&quot; &quot;Eagle&quot; &quot;Ecere-Projects&quot; &quot;Eiffel&quot; &quot;Elixir&quot;<br />
&nbsp; &nbsp; &quot;Elm&quot; &quot;Emacs-Lisp&quot; &quot;EmberScript&quot; &quot;Erlang&quot; &quot;F#&quot; &quot;FLUX&quot; &quot;Factor&quot; &quot;Fancy&quot;<br />
&nbsp; &nbsp; &quot;Fantom&quot; &quot;Filebench-WML&quot; &quot;Filterscript&quot; &quot;Formatted&quot; &quot;Forth&quot; &quot;Fortran&quot;<br />
&nbsp; &nbsp; &quot;FreeMarker&quot; &quot;Frege&quot; &quot;G-code&quot; &quot;GAMS&quot; &quot;GAP&quot; &quot;GCC-Machine-Description&quot;<br />
&nbsp; &nbsp; &quot;GDB&quot; &quot;GDScript&quot; &quot;GLSL&quot; &quot;GN&quot; &quot;Game-Maker-Language&quot; &quot;Genie&quot; &quot;Genshi&quot;<br />
&nbsp; &nbsp; &quot;Gentoo-Ebuild&quot; &quot;Gentoo-Eclass&quot; &quot;Gettext-Catalog&quot; &quot;Gherkin&quot; &quot;Glyph&quot;<br />
&nbsp; &nbsp; &quot;Gnuplot&quot; &quot;Go&quot; &quot;Golo&quot; &quot;Gosu&quot; &quot;Grace&quot; &quot;Gradle&quot; &quot;Grammatical-Framework&quot;<br />
&nbsp; &nbsp; &quot;Graph-Modeling-Language&quot; &quot;GraphQL&quot; &quot;Graphviz-(DOT)&quot; &quot;Groovy&quot;<br />
&nbsp; &nbsp; &quot;Groovy-Server-Pages&quot; &quot;HCL&quot; &quot;HLSL&quot; &quot;HTML&quot; &quot;HTML+Django&quot; &quot;HTML+ECR&quot;<br />
&nbsp; &nbsp; &quot;HTML+EEX&quot; &quot;HTML+ERB&quot; &quot;HTML+PHP&quot; &quot;HTTP&quot; &quot;Hack&quot; &quot;Haml&quot; &quot;Handlebars&quot;<br />
&nbsp; &nbsp; &quot;Harbour&quot; &quot;Haskell&quot; &quot;Haxe&quot; &quot;Hy&quot; &quot;HyPhy&quot; &quot;IDL&quot; &quot;IGOR-Pro&quot; &quot;INI&quot;<br />
&nbsp; &nbsp; &quot;IRC-log&quot; &quot;Idris&quot; &quot;Inform-7&quot; &quot;Inno-Setup&quot; &quot;Io&quot; &quot;Ioke&quot; &quot;Isabelle&quot;<br />
&nbsp; &nbsp; &quot;Isabelle-ROOT&quot; &quot;JFlex&quot; &quot;JSON&quot; &quot;JSON5&quot; &quot;JSONLD&quot; &quot;JSONiq&quot; &quot;JSX&quot;<br />
&nbsp; &nbsp; &quot;Jasmin&quot; &quot;Java&quot; &quot;Java-Server-Pages&quot; &quot;JavaScript&quot; &quot;Jison&quot; &quot;Jison-Lex&quot;<br />
&nbsp; &nbsp; &quot;Jolie&quot; &quot;Julia&quot; &quot;Jupyter-Notebook&quot; &quot;KRL&quot; &quot;KiCad&quot; &quot;Kit&quot; &quot;Kotlin&quot; &quot;LFE&quot;<br />
&nbsp; &nbsp; &quot;LLVM&quot; &quot;LOLCODE&quot; &quot;LSL&quot; &quot;LabVIEW&quot; &quot;Lasso&quot; &quot;Latte&quot; &quot;Lean&quot; &quot;Less&quot; &quot;Lex&quot;<br />
&nbsp; &nbsp; &quot;LilyPond&quot; &quot;Limbo&quot; &quot;Linker-Script&quot; &quot;Linux-Kernel-Module&quot; &quot;Liquid&quot;<br />
&nbsp; &nbsp; &quot;Literate-Agda&quot; &quot;Literate-CoffeeScript&quot; &quot;Literate-Haskell&quot;<br />
&nbsp; &nbsp; &quot;LiveScript&quot; &quot;Logos&quot; &quot;Logtalk&quot; &quot;LookML&quot; &quot;LoomScript&quot; &quot;Lua&quot; &quot;M4&quot;<br />
&nbsp; &nbsp; &quot;M4Sugar&quot; &quot;MAXScript&quot; &quot;MQL4&quot; &quot;MQL5&quot; &quot;MTML&quot; &quot;MUF&quot; &quot;Makefile&quot; &quot;Mako&quot;<br />
&nbsp; &nbsp; &quot;Markdown&quot; &quot;Marko&quot; &quot;Mask&quot; &quot;Mathematica&quot; &quot;Matlab&quot; &quot;Maven-POM&quot; &quot;Max&quot;<br />
&nbsp; &nbsp; &quot;MediaWiki&quot; &quot;Mercury&quot; &quot;Meson&quot; &quot;Metal&quot; &quot;MiniD&quot; &quot;Mirah&quot; &quot;Modelica&quot;<br />
&nbsp; &nbsp; &quot;Modula-2&quot; &quot;Module-Management-System&quot; &quot;Monkey&quot; &quot;Moocode&quot; &quot;MoonScript&quot;<br />
&nbsp; &nbsp; &quot;Myghty&quot; &quot;NCL&quot; &quot;NL&quot; &quot;NSIS&quot; &quot;Nemerle&quot; &quot;NetLinx&quot; &quot;NetLinx+ERB&quot; &quot;NetLogo&quot;<br />
&nbsp; &nbsp; &quot;NewLisp&quot; &quot;Nginx&quot; &quot;Nim&quot; &quot;Ninja&quot; &quot;Nit&quot; &quot;Nix&quot; &quot;Nu&quot; &quot;NumPy&quot; &quot;OCaml&quot;<br />
&nbsp; &nbsp; &quot;ObjDump&quot; &quot;Objective-C&quot; &quot;Objective-C++&quot; &quot;Objective-J&quot; &quot;Omgrofl&quot; &quot;Opa&quot;<br />
&nbsp; &nbsp; &quot;Opal&quot; &quot;OpenCL&quot; &quot;OpenEdge-ABL&quot; &quot;OpenRC-runscript&quot; &quot;OpenSCAD&quot;<br />
&nbsp; &nbsp; &quot;OpenType-Feature-File&quot; &quot;Org&quot; &quot;Ox&quot; &quot;Oxygene&quot; &quot;Oz&quot; &quot;P4&quot; &quot;PAWN&quot; &quot;PHP&quot;<br />
&nbsp; &nbsp; &quot;PLSQL&quot; &quot;PLpgSQL&quot; &quot;POV-Ray-SDL&quot; &quot;Pan&quot; &quot;Papyrus&quot; &quot;Parrot&quot;<br />
&nbsp; &nbsp; &quot;Parrot-Assembly&quot; &quot;Parrot-Internal-Representation&quot; &quot;Pascal&quot; &quot;Pep8&quot;<br />
&nbsp; &nbsp; &quot;Perl&quot; &quot;Perl6&quot; &quot;Pic&quot; &quot;Pickle&quot; &quot;PicoLisp&quot; &quot;PigLatin&quot; &quot;Pike&quot; &quot;Pod&quot;<br />
&nbsp; &nbsp; &quot;PogoScript&quot; &quot;Pony&quot; &quot;PostScript&quot; &quot;PowerBuilder&quot; &quot;PowerShell&quot;<br />
&nbsp; &nbsp; &quot;Processing&quot; &quot;Prolog&quot; &quot;Propeller-Spin&quot; &quot;Protocol-Buffer&quot; &quot;Public-Key&quot;<br />
&nbsp; &nbsp; &quot;Pug&quot; &quot;Puppet&quot; &quot;Pure-Data&quot; &quot;PureBasic&quot; &quot;PureScript&quot; &quot;Python&quot;<br />
&nbsp; &nbsp; &quot;Python-console&quot; &quot;Python-traceback&quot; &quot;QML&quot; &quot;QMake&quot; &quot;RAML&quot; &quot;RDoc&quot;<br />
&nbsp; &nbsp; &quot;REALbasic&quot; &quot;REXX&quot; &quot;RHTML&quot; &quot;RMarkdown&quot; &quot;RPM-Spec&quot; &quot;RUNOFF&quot; &quot;Racket&quot;<br />
&nbsp; &nbsp; &quot;Ragel&quot; &quot;Rascal&quot; &quot;Raw-token-data&quot; &quot;Reason&quot; &quot;Rebol&quot; &quot;Red&quot; &quot;Redcode&quot;<br />
&nbsp; &nbsp; &quot;Regular-Expression&quot; &quot;Ren&#39;Py&quot; &quot;RenderScript&quot; &quot;RobotFramework&quot; &quot;Roff&quot;<br />
&nbsp; &nbsp; &quot;Rouge&quot; &quot;Ruby&quot; &quot;Rust&quot; &quot;SAS&quot; &quot;SCSS&quot; &quot;SMT&quot; &quot;SPARQL&quot; &quot;SQF&quot; &quot;SQL&quot; &quot;SQLPL&quot;<br />
&nbsp; &nbsp; &quot;SRecode-Template&quot; &quot;STON&quot; &quot;SVG&quot; &quot;Sage&quot; &quot;SaltStack&quot; &quot;Sass&quot; &quot;Scala&quot;<br />
&nbsp; &nbsp; &quot;Scaml&quot; &quot;Scheme&quot; &quot;Scilab&quot; &quot;Self&quot; &quot;ShaderLab&quot; &quot;Shell&quot; &quot;ShellSession&quot;<br />
&nbsp; &nbsp; &quot;Shen&quot; &quot;Slash&quot; &quot;Slim&quot; &quot;Smali&quot; &quot;Smalltalk&quot; &quot;Smarty&quot; &quot;SourcePawn&quot;<br />
&nbsp; &nbsp; &quot;Spline-Font-Database&quot; &quot;Squirrel&quot; &quot;Stan&quot; &quot;Standard-ML&quot; &quot;Stata&quot;<br />
&nbsp; &nbsp; &quot;Stylus&quot; &quot;SubRip-Text&quot; &quot;Sublime-Text-Config&quot; &quot;SuperCollider&quot; &quot;Swift&quot;<br />
&nbsp; &nbsp; &quot;SystemVerilog&quot; &quot;TI-Program&quot; &quot;TLA&quot; &quot;TOML&quot; &quot;TXL&quot; &quot;Tcl&quot; &quot;Tcsh&quot; &quot;TeX&quot;<br />
&nbsp; &nbsp; &quot;Tea&quot; &quot;Terra&quot; &quot;Text&quot; &quot;Textile&quot; &quot;Thrift&quot; &quot;Turing&quot; &quot;Turtle&quot; &quot;Twig&quot;<br />
&nbsp; &nbsp; &quot;Type-Language&quot; &quot;TypeScript&quot; &quot;Unified-Parallel-C&quot; &quot;Unity3D-Asset&quot;<br />
&nbsp; &nbsp; &quot;Unix-Assembly&quot; &quot;Uno&quot; &quot;UnrealScript&quot; &quot;UrWeb&quot; &quot;VCL&quot; &quot;VHDL&quot; &quot;Vala&quot;<br />
&nbsp; &nbsp; &quot;Verilog&quot; &quot;Vim-script&quot; &quot;Visual-Basic&quot; &quot;Volt&quot; &quot;Vue&quot;<br />
&nbsp; &nbsp; &quot;Wavefront-Material&quot; &quot;Wavefront-Object&quot; &quot;Web-Ontology-Language&quot;<br />
&nbsp; &nbsp; &quot;WebAssembly&quot; &quot;WebIDL&quot; &quot;World-of-Warcraft-Addon-Data&quot; &quot;X10&quot; &quot;XC&quot;<br />
&nbsp; &nbsp; &quot;XCompose&quot; &quot;XML&quot; &quot;XPages&quot; &quot;XProc&quot; &quot;XQuery&quot; &quot;XS&quot; &quot;XSLT&quot; &quot;Xojo&quot; &quot;Xtend&quot;<br />
&nbsp; &nbsp; &quot;YAML&quot; &quot;YANG&quot; &quot;Yacc&quot; &quot;Zephir&quot; &quot;Zimpl&quot; &quot;desktop&quot; &quot;eC&quot; &quot;edn&quot; &quot;fish&quot;<br />
&nbsp; &nbsp; &quot;mupad&quot; &quot;nesC&quot; &quot;ooc&quot; &quot;reStructuredText&quot; &quot;wisp&quot; &quot;xBase&quot;)<br />
&nbsp; &quot;Language specifiers recognized by GitHub&#39;s syntax highlighting features.&quot;)</p>

<p>(defvar markdown-gfm-used-languages nil<br />
&nbsp; &quot;Language names used in GFM code blocks.&quot;)<br />
(make-variable-buffer-local &#39;markdown-gfm-used-languages)</p>

<p>(defun markdown-trim-whitespace (str)<br />
&nbsp; (markdown-replace-regexp-in-string<br />
&nbsp; &nbsp;&quot;\\(?:[[:space:]\r\n]+\\&#39;\\|\\`[[:space:]\r\n]+\\)&quot; &quot;&quot; str))</p>

<p>(defun markdown-clean-language-string (str)<br />
&nbsp; (markdown-replace-regexp-in-string<br />
&nbsp; &nbsp;&quot;{\\.?\\|}&quot; &quot;&quot; (markdown-trim-whitespace str)))</p>

<p>(defun markdown-validate-language-string (widget)<br />
&nbsp; (let ((str (widget-value widget)))<br />
&nbsp; &nbsp; (unless (string= str (markdown-clean-language-string str))<br />
&nbsp; &nbsp; &nbsp; (widget-put widget :error (format &quot;Invalid language spec: &#39;%s&#39;&quot; str))<br />
&nbsp; &nbsp; &nbsp; widget)))</p>

<p>(defun markdown-gfm-get-corpus ()<br />
&nbsp; &quot;Create corpus of recognized GFM code block languages for the given buffer.&quot;<br />
&nbsp; (let ((given-corpus (append markdown-gfm-additional-languages<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; markdown-gfm-recognized-languages)))<br />
&nbsp; &nbsp; (append<br />
&nbsp; &nbsp; &nbsp;markdown-gfm-used-languages<br />
&nbsp; &nbsp; &nbsp;(if markdown-gfm-downcase-languages (cl-mapcar #&#39;downcase given-corpus)<br />
&nbsp; &nbsp; &nbsp; &nbsp;given-corpus))))</p>

<p>(defun markdown-gfm-add-used-language (lang)<br />
&nbsp; &quot;Clean LANG and add to list of used languages.&quot;<br />
&nbsp; (setq markdown-gfm-used-languages<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cons lang (remove lang markdown-gfm-used-languages))))</p>

<p>(defcustom markdown-spaces-after-code-fence 1<br />
&nbsp; &quot;Number of space characters to insert after a code fence.<br />
\\&lt;gfm-mode-map&gt;\\[markdown-insert-gfm-code-block] inserts this many spaces between an<br />
opening code fence and an info string.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;integer<br />
&nbsp; :safe #&#39;natnump<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.3&quot;))</p>

<p>(defun markdown-insert-gfm-code-block (&amp;optional lang)<br />
&nbsp; &quot;Insert GFM code block for language LANG.<br />
If LANG is nil, the language will be queried from user. &nbsp;If a<br />
region is active, wrap this region with the markup instead. &nbsp;If<br />
the region boundaries are not on empty lines, these are added<br />
automatically in order to have the correct markup.&quot;<br />
&nbsp; (interactive<br />
&nbsp; &nbsp;(list (let ((completion-ignore-case nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(condition-case nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-clean-language-string<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (completing-read<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;Programming language: &quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-gfm-get-corpus)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;nil &#39;confirm (car markdown-gfm-used-languages)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;markdown-gfm-language-history))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(quit &quot;&quot;)))))<br />
&nbsp; (unless (string= lang &quot;&quot;) (markdown-gfm-add-used-language lang))<br />
&nbsp; (when (&gt; (length lang) 0)<br />
&nbsp; &nbsp; (setq lang (concat (make-string markdown-spaces-after-code-fence ?\s)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lang)))<br />
&nbsp; (if (markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; (let* ((b (region-beginning)) (e (region-end))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(indent (progn (goto-char b) (current-indentation))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char e)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; if we&#39;re on a blank line, don&#39;t newline, otherwise the ```<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; should go on its own line<br />
&nbsp; &nbsp; &nbsp; &nbsp; (unless (looking-back &quot;\n&quot; nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (newline))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (indent-to indent)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (insert &quot;```&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-ensure-blank-line-after)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char b)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; if we&#39;re on a blank line, insert the quotes here, otherwise<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; add a new line first<br />
&nbsp; &nbsp; &nbsp; &nbsp; (unless (looking-at-p &quot;\n&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (newline)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line -1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-ensure-blank-line-before)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (indent-to indent)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (insert &quot;```&quot; lang))<br />
&nbsp; &nbsp; (let ((indent (current-indentation)))<br />
&nbsp; &nbsp; &nbsp; (delete-horizontal-space :backward-only)<br />
&nbsp; &nbsp; &nbsp; (markdown-ensure-blank-line-before)<br />
&nbsp; &nbsp; &nbsp; (indent-to indent)<br />
&nbsp; &nbsp; &nbsp; (insert &quot;```&quot; lang &quot;\n&quot;)<br />
&nbsp; &nbsp; &nbsp; (indent-to indent)<br />
&nbsp; &nbsp; &nbsp; (insert ?\n)<br />
&nbsp; &nbsp; &nbsp; (indent-to indent)<br />
&nbsp; &nbsp; &nbsp; (insert &quot;```&quot;)<br />
&nbsp; &nbsp; &nbsp; (markdown-ensure-blank-line-after))<br />
&nbsp; &nbsp; (end-of-line 0)))</p>

<p>(defun markdown-code-block-lang (&amp;optional pos-prop)<br />
&nbsp; &quot;Return the language name for a GFM or tilde fenced code block.<br />
The beginning of the block may be described by POS-PROP,<br />
a cons of (pos . prop) giving the position and property<br />
at the beginning of the block.&quot;<br />
&nbsp; (or pos-prop<br />
&nbsp; &nbsp; &nbsp; (setq pos-prop<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-max-of-seq<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#&#39;car<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cl-remove-if<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;null<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-mapcar<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#&#39;markdown-find-previous-prop<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-get-fenced-block-begin-properties))))))<br />
&nbsp; (when pos-prop<br />
&nbsp; &nbsp; (goto-char (car pos-prop))<br />
&nbsp; &nbsp; (set-match-data (get-text-property (point) (cdr pos-prop)))<br />
&nbsp; &nbsp; ;; Note: Hard-coded group number assumes tilde<br />
&nbsp; &nbsp; ;; and GFM fenced code regexp groups agree.<br />
&nbsp; &nbsp; (let ((begin (match-beginning 3))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (end (match-end 3)))<br />
&nbsp; &nbsp; &nbsp; (when (and begin end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Fix language strings beginning with periods, like &quot;.ruby&quot;.<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (eq (char-after begin) ?.)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq begin (1+ begin)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (buffer-substring-no-properties begin end)))))</p>

<p>(defun markdown-gfm-parse-buffer-for-languages (&amp;optional buffer)<br />
&nbsp; (with-current-buffer (or buffer (current-buffer))<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; &nbsp; (cl-loop<br />
&nbsp; &nbsp; &nbsp; &nbsp;with prop = &#39;markdown-gfm-block-begin<br />
&nbsp; &nbsp; &nbsp; &nbsp;for pos-prop = (markdown-find-next-prop prop)<br />
&nbsp; &nbsp; &nbsp; &nbsp;while pos-prop<br />
&nbsp; &nbsp; &nbsp; &nbsp;for lang = (markdown-code-block-lang pos-prop)<br />
&nbsp; &nbsp; &nbsp; &nbsp;do (progn (when lang (markdown-gfm-add-used-language lang))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(goto-char (next-single-property-change (point) prop)))))))</p>

<p><br />
;;; Footnotes ==================================================================</p>

<p>(defun markdown-footnote-counter-inc ()<br />
&nbsp; &quot;Increment `markdown-footnote-counter&#39; and return the new value.&quot;<br />
&nbsp; (when (= markdown-footnote-counter 0) ; hasn&#39;t been updated in this buffer yet.<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; &nbsp; (while (re-search-forward (concat &quot;^\\[\\^\\(&quot; markdown-footnote-chars &quot;*?\\)\\]:&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (point-max) t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let ((fn (string-to-number (match-string 1))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (&gt; fn markdown-footnote-counter)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq markdown-footnote-counter fn))))))<br />
&nbsp; (cl-incf markdown-footnote-counter))</p>

<p>(defun markdown-insert-footnote ()<br />
&nbsp; &quot;Insert footnote with a new number and move point to footnote definition.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((fn (markdown-footnote-counter-inc)))<br />
&nbsp; &nbsp; (insert (format &quot;[^%d]&quot; fn))<br />
&nbsp; &nbsp; (markdown-footnote-text-find-new-location)<br />
&nbsp; &nbsp; (markdown-ensure-blank-line-before)<br />
&nbsp; &nbsp; (unless (markdown-cur-line-blank-p)<br />
&nbsp; &nbsp; &nbsp; (insert &quot;\n&quot;))<br />
&nbsp; &nbsp; (insert (format &quot;[^%d]: &quot; fn))<br />
&nbsp; &nbsp; (markdown-ensure-blank-line-after)))</p>

<p>(defun markdown-footnote-text-find-new-location ()<br />
&nbsp; &quot;Position the cursor at the proper location for a new footnote text.&quot;<br />
&nbsp; (cond<br />
&nbsp; &nbsp;((eq markdown-footnote-location &#39;end) (goto-char (point-max)))<br />
&nbsp; &nbsp;((eq markdown-footnote-location &#39;immediately) (markdown-end-of-text-block))<br />
&nbsp; &nbsp;((eq markdown-footnote-location &#39;subtree) (markdown-end-of-subtree))<br />
&nbsp; &nbsp;((eq markdown-footnote-location &#39;header) (markdown-end-of-defun))))</p>

<p>(defun markdown-footnote-kill ()<br />
&nbsp; &quot;Kill the footnote at point.<br />
The footnote text is killed (and added to the kill ring), the<br />
footnote marker is deleted. &nbsp;Point has to be either at the<br />
footnote marker or in the footnote text.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((marker-pos nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (skip-deleting-marker nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (starting-footnote-text-positions<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-footnote-text-positions)))<br />
&nbsp; &nbsp; (when starting-footnote-text-positions<br />
&nbsp; &nbsp; &nbsp; ;; We&#39;re starting in footnote text, so mark our return position and jump<br />
&nbsp; &nbsp; &nbsp; ;; to the marker if possible.<br />
&nbsp; &nbsp; &nbsp; (let ((marker-pos (markdown-footnote-find-marker<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cl-first starting-footnote-text-positions))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if marker-pos<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (1- marker-pos))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; If there isn&#39;t a marker, we still want to kill the text.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq skip-deleting-marker t))))<br />
&nbsp; &nbsp; ;; Either we didn&#39;t start in the text, or we started in the text and jumped<br />
&nbsp; &nbsp; ;; to the marker. We want to assume we&#39;re at the marker now and error if<br />
&nbsp; &nbsp; ;; we&#39;re not.<br />
&nbsp; &nbsp; (unless skip-deleting-marker<br />
&nbsp; &nbsp; &nbsp; (let ((marker (markdown-footnote-delete-marker)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (unless marker<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (error &quot;Not at a footnote&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Even if we knew the text position before, it changed when we deleted<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; the label.<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq marker-pos (cl-second marker))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let ((new-text-pos (markdown-footnote-find-text (cl-first marker))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless new-text-pos<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (error &quot;No text for footnote `%s&#39;&quot; (cl-first marker)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char new-text-pos))))<br />
&nbsp; &nbsp; (let ((pos (markdown-footnote-kill-text)))<br />
&nbsp; &nbsp; &nbsp; (goto-char (if starting-footnote-text-positions<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pos<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;marker-pos)))))</p>

<p>(defun markdown-footnote-delete-marker ()<br />
&nbsp; &quot;Delete a footnote marker at point.<br />
Returns a list (ID START) containing the footnote ID and the<br />
start position of the marker before deletion. &nbsp;If no footnote<br />
marker was deleted, this function returns NIL.&quot;<br />
&nbsp; (let ((marker (markdown-footnote-marker-positions)))<br />
&nbsp; &nbsp; (when marker<br />
&nbsp; &nbsp; &nbsp; (delete-region (cl-second marker) (cl-third marker))<br />
&nbsp; &nbsp; &nbsp; (butlast marker))))</p>

<p>(defun markdown-footnote-kill-text ()<br />
&nbsp; &quot;Kill footnote text at point.<br />
Returns the start position of the footnote text before deletion,<br />
or NIL if point was not inside a footnote text.</p>

<p>The killed text is placed in the kill ring (without the footnote<br />
number).&quot;<br />
&nbsp; (let ((fn (markdown-footnote-text-positions)))<br />
&nbsp; &nbsp; (when fn<br />
&nbsp; &nbsp; &nbsp; (let ((text (delete-and-extract-region (cl-second fn) (cl-third fn))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (string-match (concat &quot;\\[\\&quot; (cl-first fn) &quot;\\]:[[:space:]]*\\(\\(.*\n?\\)*\\)&quot;) text)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (kill-new (match-string 1 text))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (and (markdown-cur-line-blank-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-prev-line-blank-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (bobp)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (delete-region (1- (point)) (point)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cl-second fn)))))</p>

<p>(defun markdown-footnote-goto-text ()<br />
&nbsp; &quot;Jump to the text of the footnote at point.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((fn (car (markdown-footnote-marker-positions))))<br />
&nbsp; &nbsp; (unless fn<br />
&nbsp; &nbsp; &nbsp; (user-error &quot;Not at a footnote marker&quot;))<br />
&nbsp; &nbsp; (let ((new-pos (markdown-footnote-find-text fn)))<br />
&nbsp; &nbsp; &nbsp; (unless new-pos<br />
&nbsp; &nbsp; &nbsp; &nbsp; (error &quot;No definition found for footnote `%s&#39;&quot; fn))<br />
&nbsp; &nbsp; &nbsp; (goto-char new-pos))))</p>

<p>(defun markdown-footnote-return ()<br />
&nbsp; &quot;Return from a footnote to its footnote number in the main text.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((fn (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (car (markdown-footnote-text-positions)))))<br />
&nbsp; &nbsp; (unless fn<br />
&nbsp; &nbsp; &nbsp; (user-error &quot;Not in a footnote&quot;))<br />
&nbsp; &nbsp; (let ((new-pos (markdown-footnote-find-marker fn)))<br />
&nbsp; &nbsp; &nbsp; (unless new-pos<br />
&nbsp; &nbsp; &nbsp; &nbsp; (error &quot;Footnote marker `%s&#39; not found&quot; fn))<br />
&nbsp; &nbsp; &nbsp; (goto-char new-pos))))</p>

<p>(defun markdown-footnote-find-marker (id)<br />
&nbsp; &quot;Find the location of the footnote marker with ID.<br />
The actual buffer position returned is the position directly<br />
following the marker&#39;s closing bracket. &nbsp;If no marker is found,<br />
NIL is returned.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; (when (re-search-forward (concat &quot;\\[&quot; id &quot;\\]\\([^:]\\|\\&#39;\\)&quot;) nil t)<br />
&nbsp; &nbsp; &nbsp; (skip-chars-backward &quot;^]&quot;)<br />
&nbsp; &nbsp; &nbsp; (point))))</p>

<p>(defun markdown-footnote-find-text (id)<br />
&nbsp; &quot;Find the location of the text of footnote ID.<br />
The actual buffer position returned is the position of the first<br />
character of the text, after the footnote&#39;s identifier. &nbsp;If no<br />
footnote text is found, NIL is returned.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; (when (re-search-forward (concat &quot;^ \\{0,3\\}\\[&quot; id &quot;\\]:&quot;) nil t)<br />
&nbsp; &nbsp; &nbsp; (skip-chars-forward &quot;[ \t]&quot;)<br />
&nbsp; &nbsp; &nbsp; (point))))</p>

<p>(defun markdown-footnote-marker-positions ()<br />
&nbsp; &quot;Return the position and ID of the footnote marker point is on.<br />
The return value is a list (ID START END). &nbsp;If point is not on a<br />
footnote, NIL is returned.&quot;<br />
&nbsp; ;; first make sure we&#39;re at a footnote marker<br />
&nbsp; (if (or (looking-back (concat &quot;\\[\\^&quot; markdown-footnote-chars &quot;*\\]?&quot;) (line-beginning-position))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (looking-at-p (concat &quot;\\[?\\^&quot; markdown-footnote-chars &quot;*?\\]&quot;)))<br />
&nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; move point between [ and ^:<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (looking-at-p &quot;\\[&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-char 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (skip-chars-backward &quot;^[&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (looking-at (concat &quot;\\(\\^&quot; markdown-footnote-chars &quot;*?\\)\\]&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (list (match-string 1) (1- (match-beginning 1)) (1+ (match-end 1))))))</p>

<p>(defun markdown-footnote-text-positions ()<br />
&nbsp; &quot;Return the start and end positions of the footnote text point is in.<br />
The exact return value is a list of three elements: (ID START END).<br />
The start position is the position of the opening bracket<br />
of the footnote id. &nbsp;The end position is directly after the<br />
newline that ends the footnote. &nbsp;If point is not in a footnote,<br />
NIL is returned instead.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (let (result)<br />
&nbsp; &nbsp; &nbsp; (move-beginning-of-line 1)<br />
&nbsp; &nbsp; &nbsp; ;; Try to find the label. If we haven&#39;t found the label and we&#39;re at a blank<br />
&nbsp; &nbsp; &nbsp; ;; or indented line, back up if possible.<br />
&nbsp; &nbsp; &nbsp; (while (and<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (and (looking-at markdown-regex-footnote-definition)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq result (list (match-string 1) (point)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (and (not (bobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(or (markdown-cur-line-blank-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(&gt;= (current-indentation) 4))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line -1))<br />
&nbsp; &nbsp; &nbsp; (when result<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Advance if there is a next line that is either blank or indented.<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; (Need to check if we&#39;re on the last line, because<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; markdown-next-line-blank-p returns true for last line in buffer.)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (while (and (/= (line-end-position) (point-max))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (or (markdown-next-line-blank-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&gt;= (markdown-next-line-indent) 4)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Move back while the current line is blank.<br />
&nbsp; &nbsp; &nbsp; &nbsp; (while (markdown-cur-line-blank-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line -1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Advance to capture this line and a single trailing newline (if there<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; is one).<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (append result (list (point)))))))</p>

<p><br />
;;; Element Removal ===========================================================</p>

<p>(defun markdown-kill-thing-at-point ()<br />
&nbsp; &quot;Kill thing at point and add important text, without markup, to kill ring.<br />
Possible things to kill include (roughly in order of precedence):<br />
inline code, headers, horizonal rules, links (add link text to<br />
kill ring), images (add alt text to kill ring), angle uri, email<br />
addresses, bold, italics, reference definition (add URI to kill<br />
ring), footnote markers and text (kill both marker and text, add<br />
text to kill ring), and list items.&quot;<br />
&nbsp; (interactive &quot;*&quot;)<br />
&nbsp; (let (val)<br />
&nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp;;; Inline code<br />
&nbsp; &nbsp; &nbsp;((markdown-inline-code-at-point)<br />
&nbsp; &nbsp; &nbsp; (kill-new (match-string 2))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 0) (match-end 0)))<br />
&nbsp; &nbsp; &nbsp;;; ATX header<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-header-atx)<br />
&nbsp; &nbsp; &nbsp; (kill-new (match-string 2))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 0) (match-end 0)))<br />
&nbsp; &nbsp; &nbsp;;; Setext header<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-header-setext)<br />
&nbsp; &nbsp; &nbsp; (kill-new (match-string 1))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 0) (match-end 0)))<br />
&nbsp; &nbsp; &nbsp;;; Horizonal rule<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-hr)<br />
&nbsp; &nbsp; &nbsp; (kill-new (match-string 0))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 0) (match-end 0)))<br />
&nbsp; &nbsp; &nbsp;;; Inline link or image (add link or alt text to kill ring)<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-link-inline)<br />
&nbsp; &nbsp; &nbsp; (kill-new (match-string 3))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 0) (match-end 0)))<br />
&nbsp; &nbsp; &nbsp;;; Reference link or image (add link or alt text to kill ring)<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-link-reference)<br />
&nbsp; &nbsp; &nbsp; (kill-new (match-string 3))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 0) (match-end 0)))<br />
&nbsp; &nbsp; &nbsp;;; Angle URI (add URL to kill ring)<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-angle-uri)<br />
&nbsp; &nbsp; &nbsp; (kill-new (match-string 2))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 0) (match-end 0)))<br />
&nbsp; &nbsp; &nbsp;;; Email address in angle brackets (add email address to kill ring)<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-email)<br />
&nbsp; &nbsp; &nbsp; (kill-new (match-string 1))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 0) (match-end 0)))<br />
&nbsp; &nbsp; &nbsp;;; Wiki link (add alias text to kill ring)<br />
&nbsp; &nbsp; &nbsp;((and markdown-enable-wiki-links<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(thing-at-point-looking-at markdown-regex-wiki-link))<br />
&nbsp; &nbsp; &nbsp; (kill-new (markdown-wiki-link-alias))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 1) (match-end 1)))<br />
&nbsp; &nbsp; &nbsp;;; Bold<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-bold)<br />
&nbsp; &nbsp; &nbsp; (kill-new (match-string 4))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 2) (match-end 2)))<br />
&nbsp; &nbsp; &nbsp;;; Italics<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-italic)<br />
&nbsp; &nbsp; &nbsp; (kill-new (match-string 3))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 1) (match-end 1)))<br />
&nbsp; &nbsp; &nbsp;;; Strikethrough<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-strike-through)<br />
&nbsp; &nbsp; &nbsp; (kill-new (match-string 4))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 2) (match-end 2)))<br />
&nbsp; &nbsp; &nbsp;;; Footnote marker (add footnote text to kill ring)<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-footnote)<br />
&nbsp; &nbsp; &nbsp; (markdown-footnote-kill))<br />
&nbsp; &nbsp; &nbsp;;; Footnote text (add footnote text to kill ring)<br />
&nbsp; &nbsp; &nbsp;((setq val (markdown-footnote-text-positions))<br />
&nbsp; &nbsp; &nbsp; (markdown-footnote-kill))<br />
&nbsp; &nbsp; &nbsp;;; Reference definition (add URL to kill ring)<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-reference-definition)<br />
&nbsp; &nbsp; &nbsp; (kill-new (match-string 5))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 0) (match-end 0)))<br />
&nbsp; &nbsp; &nbsp;;; List item<br />
&nbsp; &nbsp; &nbsp;((setq val (markdown-cur-list-item-bounds))<br />
&nbsp; &nbsp; &nbsp; (kill-new (delete-and-extract-region (cl-first val) (cl-second val))))<br />
&nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; (user-error &quot;Nothing found at point to kill&quot;)))))</p>

<p><br />
;;; Indentation ====================================================================</p>

<p>(defun markdown-indent-find-next-position (cur-pos positions)<br />
&nbsp; &quot;Return the position after the index of CUR-POS in POSITIONS.<br />
Positions are calculated by `markdown-calc-indents&#39;.&quot;<br />
&nbsp; (while (and positions<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (equal cur-pos (car positions))))<br />
&nbsp; &nbsp; (setq positions (cdr positions)))<br />
&nbsp; (or (cadr positions) 0))</p>

<p>(define-obsolete-function-alias &#39;markdown-exdent-find-next-position<br />
&nbsp; &#39;markdown-outdent-find-next-position &quot;v2.3&quot;)</p>

<p>(defun markdown-outdent-find-next-position (cur-pos positions)<br />
&nbsp; &quot;Return the maximal element that precedes CUR-POS from POSITIONS.<br />
Positions are calculated by `markdown-calc-indents&#39;.&quot;<br />
&nbsp; (let ((result 0))<br />
&nbsp; &nbsp; (dolist (i positions)<br />
&nbsp; &nbsp; &nbsp; (when (&lt; i cur-pos)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq result (max result i))))<br />
&nbsp; &nbsp; result))</p>

<p>(defun markdown-indent-line ()<br />
&nbsp; &quot;Indent the current line using some heuristics.<br />
If the _previous_ command was either `markdown-enter-key&#39; or<br />
`markdown-cycle&#39;, then we should cycle to the next<br />
reasonable indentation position. &nbsp;Otherwise, we could have been<br />
called directly by `markdown-enter-key&#39;, by an initial call of<br />
`markdown-cycle&#39;, or indirectly by `auto-fill-mode&#39;. &nbsp;In<br />
these cases, indent to the default position.<br />
Positions are calculated by `markdown-calc-indents&#39;.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((positions (markdown-calc-indents))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cursor-pos (current-column))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (_ (back-to-indentation))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cur-pos (current-column)))<br />
&nbsp; &nbsp; (if (not (equal this-command &#39;markdown-cycle))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (indent-line-to (car positions))<br />
&nbsp; &nbsp; &nbsp; (setq positions (sort (delete-dups positions) &#39;&lt;))<br />
&nbsp; &nbsp; &nbsp; (let* ((next-pos (markdown-indent-find-next-position cur-pos positions))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(new-cursor-pos<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (&lt; cur-pos next-pos)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (+ cursor-pos (- next-pos cur-pos))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (- cursor-pos cur-pos))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (indent-line-to next-pos)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (move-to-column new-cursor-pos)))))</p>

<p>(defun markdown-calc-indents ()<br />
&nbsp; &quot;Return a list of indentation columns to cycle through.<br />
The first element in the returned list should be considered the<br />
default indentation level. &nbsp;This function does not worry about<br />
duplicate positions, which are handled up by calling functions.&quot;<br />
&nbsp; (let (pos prev-line-pos positions)</p>

<p>&nbsp; &nbsp; ;; Indentation of previous line<br />
&nbsp; &nbsp; (setq prev-line-pos (markdown-prev-line-indent))<br />
&nbsp; &nbsp; (setq positions (cons prev-line-pos positions))</p>

<p>&nbsp; &nbsp; ;; Indentation of previous non-list-marker text<br />
&nbsp; &nbsp; (when (setq pos (markdown-prev-non-list-indent))<br />
&nbsp; &nbsp; &nbsp; (setq positions (cons pos positions)))</p>

<p>&nbsp; &nbsp; ;; Indentation required for a pre block in current context<br />
&nbsp; &nbsp; (setq pos (length (markdown-pre-indentation (point))))<br />
&nbsp; &nbsp; (setq positions (cons pos positions))</p>

<p>&nbsp; &nbsp; ;; Indentation of the previous line + tab-width<br />
&nbsp; &nbsp; (if prev-line-pos<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq positions (cons (+ prev-line-pos tab-width) positions))<br />
&nbsp; &nbsp; &nbsp; (setq positions (cons tab-width positions)))</p>

<p>&nbsp; &nbsp; ;; Indentation of the previous line - tab-width<br />
&nbsp; &nbsp; (if (and prev-line-pos (&gt; prev-line-pos tab-width))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq positions (cons (- prev-line-pos tab-width) positions)))</p>

<p>&nbsp; &nbsp; ;; Indentation of all preceeding list markers (when in a list)<br />
&nbsp; &nbsp; (when (setq pos (markdown-calculate-list-levels))<br />
&nbsp; &nbsp; &nbsp; (setq positions (append pos positions)))</p>

<p>&nbsp; &nbsp; ;; First column<br />
&nbsp; &nbsp; (setq positions (cons 0 positions))</p>

<p>&nbsp; &nbsp; ;; Return reversed list<br />
&nbsp; &nbsp; (reverse positions)))</p>

<p>(defun markdown-enter-key ()<br />
&nbsp; &quot;Handle RET according to value of `markdown-indent-on-enter&#39;.<br />
When it is nil, simply call `newline&#39;. &nbsp;Otherwise, indent the next line<br />
following RET using `markdown-indent-line&#39;. &nbsp;Furthermore, when it<br />
is set to &#39;indent-and-new-item and the point is in a list item,<br />
start a new item with the same indentation. If the point is in an<br />
empty list item, remove it (so that pressing RET twice when in a<br />
list simply adds a blank line).&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (if (not markdown-indent-on-enter)<br />
&nbsp; &nbsp; &nbsp; (newline)<br />
&nbsp; &nbsp; (let (bounds)<br />
&nbsp; &nbsp; &nbsp; (if (and (memq markdown-indent-on-enter &#39;(indent-and-new-item))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(setq bounds (markdown-cur-list-item-bounds)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((beg (cl-first bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (end (cl-second bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (length (cl-fourth bounds)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Point is in a list item<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (= (- end beg) length)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Delete blank list<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (delete-region beg end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (newline)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-indent-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (call-interactively #&#39;markdown-insert-list-item)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Point is not in a list<br />
&nbsp; &nbsp; &nbsp; &nbsp; (newline)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-indent-line)))))</p>

<p>(define-obsolete-function-alias &#39;markdown-exdent-or-delete<br />
&nbsp; &#39;markdown-outdent-or-delete &quot;v2.3&quot;)</p>

<p>(defun markdown-outdent-or-delete (arg)<br />
&nbsp; &quot;Handle BACKSPACE by cycling through indentation points.<br />
When BACKSPACE is pressed, if there is only whitespace<br />
before the current point, then outdent the line one level.<br />
Otherwise, do normal delete by repeating<br />
`backward-delete-char-untabify&#39; ARG times.&quot;<br />
&nbsp; (interactive &quot;*p&quot;)<br />
&nbsp; (if (use-region-p)<br />
&nbsp; &nbsp; &nbsp; (backward-delete-char-untabify arg)<br />
&nbsp; &nbsp; (let ((cur-pos (current-column))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (start-of-indention (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (back-to-indentation)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (current-column)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (positions (markdown-calc-indents)))<br />
&nbsp; &nbsp; &nbsp; (if (and (&gt; cur-pos 0) (= cur-pos start-of-indention))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (indent-line-to (markdown-outdent-find-next-position cur-pos positions))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (backward-delete-char-untabify arg)))))</p>

<p>(defun markdown-find-leftmost-column (beg end)<br />
&nbsp; &quot;Find the leftmost column in the region from BEG to END.&quot;<br />
&nbsp; (let ((mincol 1000))<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (goto-char beg)<br />
&nbsp; &nbsp; &nbsp; (while (&lt; (point) end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (back-to-indentation)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (unless (looking-at-p &quot;[ \t]*$&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq mincol (min mincol (current-column))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ))<br />
&nbsp; &nbsp; mincol))</p>

<p>(defun markdown-indent-region (beg end arg)<br />
&nbsp; &quot;Indent the region from BEG to END using some heuristics.<br />
When ARG is non-nil, outdent the region instead.<br />
See `markdown-indent-line&#39; and `markdown-indent-line&#39;.&quot;<br />
&nbsp; (interactive &quot;*r\nP&quot;)<br />
&nbsp; (let* ((positions (sort (delete-dups (markdown-calc-indents)) &#39;&lt;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(leftmostcol (markdown-find-leftmost-column beg end))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(next-pos (if arg<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-outdent-find-next-position leftmostcol positions)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-indent-find-next-position leftmostcol positions))))<br />
&nbsp; &nbsp; (indent-rigidly beg end (- next-pos leftmostcol))<br />
&nbsp; &nbsp; (setq deactivate-mark nil)))</p>

<p>(define-obsolete-function-alias &#39;markdown-exdent-region<br />
&nbsp; &#39;markdown-outdent-region &quot;v2.3&quot;)</p>

<p>(defun markdown-outdent-region (beg end)<br />
&nbsp; &quot;Call `markdown-indent-region&#39; on region from BEG to END with prefix.&quot;<br />
&nbsp; (interactive &quot;*r&quot;)<br />
&nbsp; (markdown-indent-region beg end t))</p>

<p><br />
;;; Markup Completion =========================================================</p>

<p>(defconst markdown-complete-alist<br />
&nbsp; &#39;((markdown-regex-header-atx . markdown-complete-atx)<br />
&nbsp; &nbsp; (markdown-regex-header-setext . markdown-complete-setext)<br />
&nbsp; &nbsp; (markdown-regex-hr . markdown-complete-hr))<br />
&nbsp; &quot;Association list of form (regexp . function) for markup completion.&quot;)</p>

<p>(defun markdown-incomplete-atx-p ()<br />
&nbsp; &quot;Return t if ATX header markup is incomplete and nil otherwise.<br />
Assumes match data is available for `markdown-regex-header-atx&#39;.<br />
Checks that the number of trailing hash marks equals the number of leading<br />
hash marks, that there is only a single space before and after the text,<br />
and that there is no extraneous whitespace in the text.&quot;<br />
&nbsp; (or<br />
&nbsp; &nbsp;;; Number of starting and ending hash marks differs<br />
&nbsp; &nbsp;(not (= (length (match-string 1)) (length (match-string 3))))<br />
&nbsp; &nbsp;;; When the header text is not empty...<br />
&nbsp; &nbsp;(and (&gt; (length (match-string 2)) 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; ...if there are extra leading, trailing, or interior spaces<br />
&nbsp; &nbsp; &nbsp; &nbsp; (or (not (= (match-beginning 2) (1+ (match-end 1))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (= (match-beginning 3) (1+ (match-end 2))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (string-match-p &quot;[ \t\n]\\{2\\}&quot; (match-string 2))))<br />
&nbsp; &nbsp;;; When the header text is empty...<br />
&nbsp; &nbsp;(and (= (length (match-string 2)) 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; ...if there are too many or too few spaces<br />
&nbsp; &nbsp; &nbsp; &nbsp; (not (= (match-beginning 3) (+ (match-end 1) 2))))))</p>

<p>(defun markdown-complete-atx ()<br />
&nbsp; &quot;Complete and normalize ATX headers.<br />
Add or remove hash marks to the end of the header to match the<br />
beginning. &nbsp;Ensure that there is only a single space between hash<br />
marks and header text. &nbsp;Removes extraneous whitespace from header text.<br />
Assumes match data is available for `markdown-regex-header-atx&#39;.<br />
Return nil if markup was complete and non-nil if markup was completed.&quot;<br />
&nbsp; (when (markdown-incomplete-atx-p)<br />
&nbsp; &nbsp; (let* ((new-marker (make-marker))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(new-marker (set-marker new-marker (match-end 2))))<br />
&nbsp; &nbsp; &nbsp; ;; Hash marks and spacing at end<br />
&nbsp; &nbsp; &nbsp; (goto-char (match-end 2))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-end 2) (match-end 3))<br />
&nbsp; &nbsp; &nbsp; (insert &quot; &quot; (match-string 1))<br />
&nbsp; &nbsp; &nbsp; ;; Remove extraneous whitespace from title<br />
&nbsp; &nbsp; &nbsp; (replace-match (markdown-compress-whitespace-string (match-string 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;t t nil 2)<br />
&nbsp; &nbsp; &nbsp; ;; Spacing at beginning<br />
&nbsp; &nbsp; &nbsp; (goto-char (match-end 1))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-end 1) (match-beginning 2))<br />
&nbsp; &nbsp; &nbsp; (insert &quot; &quot;)<br />
&nbsp; &nbsp; &nbsp; ;; Leave point at end of text<br />
&nbsp; &nbsp; &nbsp; (goto-char new-marker))))</p>

<p>(defun markdown-incomplete-setext-p ()<br />
&nbsp; &quot;Return t if setext header markup is incomplete and nil otherwise.<br />
Assumes match data is available for `markdown-regex-header-setext&#39;.<br />
Checks that length of underline matches text and that there is no<br />
extraneous whitespace in the text.&quot;<br />
&nbsp; (or (not (= (length (match-string 1)) (length (match-string 2))))<br />
&nbsp; &nbsp; &nbsp; (string-match-p &quot;[ \t\n]\\{2\\}&quot; (match-string 1))))</p>

<p>(defun markdown-complete-setext ()<br />
&nbsp; &quot;Complete and normalize setext headers.<br />
Add or remove underline characters to match length of header<br />
text. &nbsp;Removes extraneous whitespace from header text. &nbsp;Assumes<br />
match data is available for `markdown-regex-header-setext&#39;.<br />
Return nil if markup was complete and non-nil if markup was completed.&quot;<br />
&nbsp; (when (markdown-incomplete-setext-p)<br />
&nbsp; &nbsp; (let* ((text (markdown-compress-whitespace-string (match-string 1)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(char (char-after (match-beginning 2)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(level (if (char-equal char ?-) 2 1)))<br />
&nbsp; &nbsp; &nbsp; (goto-char (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 0) (match-end 0))<br />
&nbsp; &nbsp; &nbsp; (markdown-insert-header level text t)<br />
&nbsp; &nbsp; &nbsp; t)))</p>

<p>(defun markdown-incomplete-hr-p ()<br />
&nbsp; &quot;Return non-nil if hr is not in `markdown-hr-strings&#39; and nil otherwise.<br />
Assumes match data is available for `markdown-regex-hr&#39;.&quot;<br />
&nbsp; (not (member (match-string 0) markdown-hr-strings)))</p>

<p>(defun markdown-complete-hr ()<br />
&nbsp; &quot;Complete horizontal rules.<br />
If horizontal rule string is a member of `markdown-hr-strings&#39;,<br />
do nothing. &nbsp;Otherwise, replace with the car of<br />
`markdown-hr-strings&#39;.<br />
Assumes match data is available for `markdown-regex-hr&#39;.<br />
Return nil if markup was complete and non-nil if markup was completed.&quot;<br />
&nbsp; (when (markdown-incomplete-hr-p)<br />
&nbsp; &nbsp; (replace-match (car markdown-hr-strings))<br />
&nbsp; &nbsp; t))</p>

<p>(defun markdown-complete ()<br />
&nbsp; &quot;Complete markup of object near point or in region when active.<br />
Handle all objects in `markdown-complete-alist&#39;, in order.<br />
See `markdown-complete-at-point&#39; and `markdown-complete-region&#39;.&quot;<br />
&nbsp; (interactive &quot;*&quot;)<br />
&nbsp; (if (markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; (markdown-complete-region (region-beginning) (region-end))<br />
&nbsp; &nbsp; (markdown-complete-at-point)))</p>

<p>(defun markdown-complete-at-point ()<br />
&nbsp; &quot;Complete markup of object near point.<br />
Handle all elements of `markdown-complete-alist&#39; in order.&quot;<br />
&nbsp; (interactive &quot;*&quot;)<br />
&nbsp; (let ((list markdown-complete-alist) found changed)<br />
&nbsp; &nbsp; (while list<br />
&nbsp; &nbsp; &nbsp; (let ((regexp (eval (caar list)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (function (cdar list)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq list (cdr list))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (thing-at-point-looking-at regexp)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq found t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq changed (funcall function))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq list nil))))<br />
&nbsp; &nbsp; (if found<br />
&nbsp; &nbsp; &nbsp; &nbsp; (or changed (user-error &quot;Markup at point is complete&quot;))<br />
&nbsp; &nbsp; &nbsp; (user-error &quot;Nothing to complete at point&quot;))))</p>

<p>(defun markdown-complete-region (beg end)<br />
&nbsp; &quot;Complete markup of objects in region from BEG to END.<br />
Handle all objects in `markdown-complete-alist&#39;, in order. &nbsp;Each<br />
match is checked to ensure that a previous regexp does not also<br />
match.&quot;<br />
&nbsp; (interactive &quot;*r&quot;)<br />
&nbsp; (let ((end-marker (set-marker (make-marker) end))<br />
&nbsp; &nbsp; &nbsp; &nbsp; previous)<br />
&nbsp; &nbsp; (dolist (element markdown-complete-alist)<br />
&nbsp; &nbsp; &nbsp; (let ((regexp (eval (car element)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (function (cdr element)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char beg)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (while (re-search-forward regexp end-marker &#39;limit)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (match-string 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Make sure this is not a match for any of the preceding regexps.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; This prevents mistaking an HR for a Setext subheading.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let (match)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-match-data<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (dolist (prev-regexp previous)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (or match (setq match (looking-back prev-regexp nil)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless match<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-excursion (funcall function))))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cl-pushnew regexp previous :test #&#39;equal)))<br />
&nbsp; &nbsp; previous))</p>

<p>(defun markdown-complete-buffer ()<br />
&nbsp; &quot;Complete markup for all objects in the current buffer.&quot;<br />
&nbsp; (interactive &quot;*&quot;)<br />
&nbsp; (markdown-complete-region (point-min) (point-max)))</p>

<p><br />
;;; Markup Cycling ============================================================</p>

<p>(defun markdown-cycle-atx (arg &amp;optional remove)<br />
&nbsp; &quot;Cycle ATX header markup.<br />
Promote header (decrease level) when ARG is 1 and demote<br />
header (increase level) if arg is -1. &nbsp;When REMOVE is non-nil,<br />
remove the header when the level reaches zero and stop cycling<br />
when it reaches six. &nbsp;Otherwise, perform a proper cycling through<br />
levels one through six. &nbsp;Assumes match data is available for<br />
`markdown-regex-header-atx&#39;.&quot;<br />
&nbsp; (let* ((old-level (length (match-string 1)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(new-level (+ old-level arg))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(text (match-string 2)))<br />
&nbsp; &nbsp; (when (not remove)<br />
&nbsp; &nbsp; &nbsp; (setq new-level (% new-level 6))<br />
&nbsp; &nbsp; &nbsp; (setq new-level (cond ((= new-level 0) 6)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((&lt; new-level 0) (+ new-level 6))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (t new-level))))<br />
&nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp;((= new-level 0)<br />
&nbsp; &nbsp; &nbsp; (markdown-unwrap-thing-at-point nil 0 2))<br />
&nbsp; &nbsp; &nbsp;((&lt;= new-level 6)<br />
&nbsp; &nbsp; &nbsp; (goto-char (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; (delete-region (match-beginning 0) (match-end 0))<br />
&nbsp; &nbsp; &nbsp; (markdown-insert-header new-level text nil)))))</p>

<p>(defun markdown-cycle-setext (arg &amp;optional remove)<br />
&nbsp; &quot;Cycle setext header markup.<br />
Promote header (increase level) when ARG is 1 and demote<br />
header (decrease level or remove) if arg is -1. &nbsp;When demoting a<br />
level-two setext header, replace with a level-three atx header.<br />
When REMOVE is non-nil, remove the header when the level reaches<br />
zero. &nbsp;Otherwise, cycle back to a level six atx header. &nbsp;Assumes<br />
match data is available for `markdown-regex-header-setext&#39;.&quot;<br />
&nbsp; (let* ((char (char-after (match-beginning 2)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(old-level (if (char-equal char ?=) 1 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(new-level (+ old-level arg)))<br />
&nbsp; &nbsp; (when (and (not remove) (= new-level 0))<br />
&nbsp; &nbsp; &nbsp; (setq new-level 6))<br />
&nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp;((= new-level 0)<br />
&nbsp; &nbsp; &nbsp; (markdown-unwrap-thing-at-point nil 0 1))<br />
&nbsp; &nbsp; &nbsp;((&lt;= new-level 2)<br />
&nbsp; &nbsp; &nbsp; (markdown-insert-header new-level nil t))<br />
&nbsp; &nbsp; &nbsp;((&lt;= new-level 6)<br />
&nbsp; &nbsp; &nbsp; (markdown-insert-header new-level nil nil)))))</p>

<p>(defun markdown-cycle-hr (arg &amp;optional remove)<br />
&nbsp; &quot;Cycle string used for horizontal rule from `markdown-hr-strings&#39;.<br />
When ARG is 1, cycle forward (demote), and when ARG is -1, cycle<br />
backwards (promote). &nbsp;When REMOVE is non-nil, remove the hr instead<br />
of cycling when the end of the list is reached.<br />
Assumes match data is available for `markdown-regex-hr&#39;.&quot;<br />
&nbsp; (let* ((strings (if (= arg -1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (reverse markdown-hr-strings)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; markdown-hr-strings))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(tail (member (match-string 0) strings))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(new (or (cadr tail)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if remove<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (= arg 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (car tail))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (car strings)))))<br />
&nbsp; &nbsp; (replace-match new)))</p>

<p>(defun markdown-cycle-bold ()<br />
&nbsp; &quot;Cycle bold markup between underscores and asterisks.<br />
Assumes match data is available for `markdown-regex-bold&#39;.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (let* ((old-delim (match-string 3))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(new-delim (if (string-equal old-delim &quot;**&quot;) &quot;__&quot; &quot;**&quot;)))<br />
&nbsp; &nbsp; &nbsp; (replace-match new-delim t t nil 3)<br />
&nbsp; &nbsp; &nbsp; (replace-match new-delim t t nil 5))))</p>

<p>(defun markdown-cycle-italic ()<br />
&nbsp; &quot;Cycle italic markup between underscores and asterisks.<br />
Assumes match data is available for `markdown-regex-italic&#39;.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (let* ((old-delim (match-string 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(new-delim (if (string-equal old-delim &quot;*&quot;) &quot;_&quot; &quot;*&quot;)))<br />
&nbsp; &nbsp; &nbsp; (replace-match new-delim t t nil 2)<br />
&nbsp; &nbsp; &nbsp; (replace-match new-delim t t nil 4))))</p>

<p><br />
;;; Keymap ====================================================================</p>

<p>(defun markdown--style-map-prompt ()<br />
&nbsp; &quot;Return a formatted prompt for Markdown markup insertion.&quot;<br />
&nbsp; (when markdown-enable-prefix-prompts<br />
&nbsp; &nbsp; (concat<br />
&nbsp; &nbsp; &nbsp;&quot;Markdown: &quot;<br />
&nbsp; &nbsp; &nbsp;(propertize &quot;bold&quot; &#39;face &#39;markdown-bold-face) &quot;, &quot;<br />
&nbsp; &nbsp; &nbsp;(propertize &quot;italic&quot; &#39;face &#39;markdown-italic-face) &quot;, &quot;<br />
&nbsp; &nbsp; &nbsp;(propertize &quot;code&quot; &#39;face &#39;markdown-inline-code-face) &quot;, &quot;<br />
&nbsp; &nbsp; &nbsp;(propertize &quot;C = GFM code&quot; &#39;face &#39;markdown-code-face) &quot;, &quot;<br />
&nbsp; &nbsp; &nbsp;(propertize &quot;pre&quot; &#39;face &#39;markdown-pre-face) &quot;, &quot;<br />
&nbsp; &nbsp; &nbsp;(propertize &quot;footnote&quot; &#39;face &#39;markdown-footnote-text-face) &quot;, &quot;<br />
&nbsp; &nbsp; &nbsp;(propertize &quot;q = blockquote&quot; &#39;face &#39;markdown-blockquote-face) &quot;, &quot;<br />
&nbsp; &nbsp; &nbsp;(propertize &quot;h &amp; 1-6 = heading&quot; &#39;face &#39;markdown-header-face) &quot;, &quot;<br />
&nbsp; &nbsp; &nbsp;(propertize &quot;- = hr&quot; &#39;face &#39;markdown-hr-face) &quot;, &quot;<br />
&nbsp; &nbsp; &nbsp;&quot;C-h = more&quot;)))</p>

<p>(defun markdown--command-map-prompt ()<br />
&nbsp; &quot;Return prompt for Markdown buffer-wide commands.&quot;<br />
&nbsp; (when markdown-enable-prefix-prompts<br />
&nbsp; &nbsp; (concat<br />
&nbsp; &nbsp; &nbsp;&quot;Command: &quot;<br />
&nbsp; &nbsp; &nbsp;(propertize &quot;m&quot; &#39;face &#39;markdown-bold-face) &quot;arkdown, &quot;<br />
&nbsp; &nbsp; &nbsp;(propertize &quot;p&quot; &#39;face &#39;markdown-bold-face) &quot;review, &quot;<br />
&nbsp; &nbsp; &nbsp;(propertize &quot;o&quot; &#39;face &#39;markdown-bold-face) &quot;pen, &quot;<br />
&nbsp; &nbsp; &nbsp;(propertize &quot;e&quot; &#39;face &#39;markdown-bold-face) &quot;xport, &quot;<br />
&nbsp; &nbsp; &nbsp;&quot;export &amp; pre&quot; (propertize &quot;v&quot; &#39;face &#39;markdown-bold-face) &quot;iew, &quot;<br />
&nbsp; &nbsp; &nbsp;(propertize &quot;c&quot; &#39;face &#39;markdown-bold-face) &quot;heck refs, &quot;<br />
&nbsp; &nbsp; &nbsp;&quot;C-h = more&quot;)))</p>

<p>(defvar markdown-mode-style-map<br />
&nbsp; (let ((map (make-keymap (markdown--style-map-prompt))))<br />
&nbsp; &nbsp; (define-key map (kbd &quot;1&quot;) &#39;markdown-insert-header-atx-1)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;2&quot;) &#39;markdown-insert-header-atx-2)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;3&quot;) &#39;markdown-insert-header-atx-3)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;4&quot;) &#39;markdown-insert-header-atx-4)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;5&quot;) &#39;markdown-insert-header-atx-5)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;6&quot;) &#39;markdown-insert-header-atx-6)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;!&quot;) &#39;markdown-insert-header-setext-1)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;@&quot;) &#39;markdown-insert-header-setext-2)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;b&quot;) &#39;markdown-insert-bold)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;c&quot;) &#39;markdown-insert-code)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C&quot;) &#39;markdown-insert-gfm-code-block)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;f&quot;) &#39;markdown-insert-footnote)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;h&quot;) &#39;markdown-insert-header-dwim)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;H&quot;) &#39;markdown-insert-header-setext-dwim)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;i&quot;) &#39;markdown-insert-italic)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;k&quot;) &#39;markdown-insert-kbd)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;l&quot;) &#39;markdown-insert-link)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;p&quot;) &#39;markdown-insert-pre)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;P&quot;) &#39;markdown-pre-region)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;q&quot;) &#39;markdown-insert-blockquote)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;s&quot;) &#39;markdown-insert-strike-through)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;Q&quot;) &#39;markdown-blockquote-region)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;w&quot;) &#39;markdown-insert-wiki-link)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;-&quot;) &#39;markdown-insert-hr)<br />
&nbsp; &nbsp; ;; Deprecated keys that may be removed in a future version<br />
&nbsp; &nbsp; (define-key map (kbd &quot;e&quot;) &#39;markdown-insert-italic)<br />
&nbsp; &nbsp; map)<br />
&nbsp; &quot;Keymap for Markdown text styling commands.&quot;)</p>

<p>(defvar markdown-mode-command-map<br />
&nbsp; (let ((map (make-keymap (markdown--command-map-prompt))))<br />
&nbsp; &nbsp; (define-key map (kbd &quot;m&quot;) &#39;markdown-other-window)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;p&quot;) &#39;markdown-preview)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;e&quot;) &#39;markdown-export)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;v&quot;) &#39;markdown-export-and-preview)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;o&quot;) &#39;markdown-open)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;l&quot;) &#39;markdown-live-preview-mode)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;w&quot;) &#39;markdown-kill-ring-save)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;c&quot;) &#39;markdown-check-refs)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;n&quot;) &#39;markdown-cleanup-list-numbers)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;]&quot;) &#39;markdown-complete-buffer)<br />
&nbsp; &nbsp; map)<br />
&nbsp; &quot;Keymap for Markdown buffer-wide commands.&quot;)</p>

<p>(defvar markdown-mode-map<br />
&nbsp; (let ((map (make-keymap)))<br />
&nbsp; &nbsp; ;; Markup insertion &amp; removal<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-s&quot;) markdown-mode-style-map)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-l&quot;) &#39;markdown-insert-link)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-k&quot;) &#39;markdown-kill-thing-at-point)<br />
&nbsp; &nbsp; ;; Promotion, demotion, and cycling<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C--&quot;) &#39;markdown-promote)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-=&quot;) &#39;markdown-demote)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-]&quot;) &#39;markdown-complete)<br />
&nbsp; &nbsp; ;; Following and doing things<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-o&quot;) &#39;markdown-follow-thing-at-point)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-d&quot;) &#39;markdown-do)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c &#39;&quot;) &#39;markdown-edit-code-block)<br />
&nbsp; &nbsp; ;; Indentation<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-m&quot;) &#39;markdown-enter-key)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;DEL&quot;) &#39;markdown-outdent-or-delete)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c &gt;&quot;) &#39;markdown-indent-region)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c &lt;&quot;) &#39;markdown-outdent-region)<br />
&nbsp; &nbsp; ;; Visibility cycling<br />
&nbsp; &nbsp; (define-key map (kbd &quot;TAB&quot;) &#39;markdown-cycle)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;&lt;S-iso-lefttab&gt;&quot;) &#39;markdown-shifttab)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;&lt;S-tab&gt;&quot;) &nbsp;&#39;markdown-shifttab)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;&lt;backtab&gt;&quot;) &#39;markdown-shifttab)<br />
&nbsp; &nbsp; ;; Heading and list navigation<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-n&quot;) &#39;markdown-outline-next)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-p&quot;) &#39;markdown-outline-previous)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-f&quot;) &#39;markdown-outline-next-same-level)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-b&quot;) &#39;markdown-outline-previous-same-level)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-u&quot;) &#39;markdown-outline-up)<br />
&nbsp; &nbsp; ;; Buffer-wide commands<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-c&quot;) markdown-mode-command-map)<br />
&nbsp; &nbsp; ;; Subtree and list editing<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c &lt;up&gt;&quot;) &#39;markdown-move-up)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c &lt;down&gt;&quot;) &#39;markdown-move-down)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c &lt;left&gt;&quot;) &#39;markdown-promote)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c &lt;right&gt;&quot;) &#39;markdown-demote)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-M-h&quot;) &#39;markdown-mark-subtree)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-x n s&quot;) &#39;markdown-narrow-to-subtree)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;M-&lt;return&gt;&quot;) &#39;markdown-insert-list-item)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-j&quot;) &#39;markdown-insert-list-item)<br />
&nbsp; &nbsp; ;; Paragraphs (Markdown context aware)<br />
&nbsp; &nbsp; (define-key map [remap backward-paragraph] &#39;markdown-backward-paragraph)<br />
&nbsp; &nbsp; (define-key map [remap forward-paragraph] &#39;markdown-forward-paragraph)<br />
&nbsp; &nbsp; (define-key map [remap mark-paragraph] &#39;markdown-mark-paragraph)<br />
&nbsp; &nbsp; ;; Blocks (one or more paragraphs)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-M-{&quot;) &#39;markdown-backward-block)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-M-}&quot;) &#39;markdown-forward-block)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c M-h&quot;) &#39;markdown-mark-block)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-x n b&quot;) &#39;markdown-narrow-to-block)<br />
&nbsp; &nbsp; ;; Pages (top-level sections)<br />
&nbsp; &nbsp; (define-key map [remap backward-page] &#39;markdown-backward-page)<br />
&nbsp; &nbsp; (define-key map [remap forward-page] &#39;markdown-forward-page)<br />
&nbsp; &nbsp; (define-key map [remap mark-page] &#39;markdown-mark-page)<br />
&nbsp; &nbsp; (define-key map [remap narrow-to-page] &#39;markdown-narrow-to-page)<br />
&nbsp; &nbsp; ;; Link Movement<br />
&nbsp; &nbsp; (define-key map (kbd &quot;M-n&quot;) &#39;markdown-next-link)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;M-p&quot;) &#39;markdown-previous-link)<br />
&nbsp; &nbsp; ;; Toggling functionality<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-x C-e&quot;) &#39;markdown-toggle-math)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-x C-f&quot;) &#39;markdown-toggle-fontify-code-blocks-natively)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-x C-i&quot;) &#39;markdown-toggle-inline-images)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-x C-l&quot;) &#39;markdown-toggle-url-hiding)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-x C-m&quot;) &#39;markdown-toggle-markup-hiding)<br />
&nbsp; &nbsp; ;; Alternative keys (in case of problems with the arrow keys)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-x u&quot;) &#39;markdown-move-up)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-x d&quot;) &#39;markdown-move-down)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-x l&quot;) &#39;markdown-promote)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-x r&quot;) &#39;markdown-demote)<br />
&nbsp; &nbsp; ;; Deprecated keys that may be removed in a future version<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-a L&quot;) &#39;markdown-insert-link) ;; C-c C-l<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-a l&quot;) &#39;markdown-insert-link) ;; C-c C-l<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-a r&quot;) &#39;markdown-insert-link) ;; C-c C-l<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-a u&quot;) &#39;markdown-insert-uri) ;; C-c C-l<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-a f&quot;) &#39;markdown-insert-footnote)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-a w&quot;) &#39;markdown-insert-wiki-link)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-t 1&quot;) &#39;markdown-insert-header-atx-1)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-t 2&quot;) &#39;markdown-insert-header-atx-2)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-t 3&quot;) &#39;markdown-insert-header-atx-3)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-t 4&quot;) &#39;markdown-insert-header-atx-4)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-t 5&quot;) &#39;markdown-insert-header-atx-5)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-t 6&quot;) &#39;markdown-insert-header-atx-6)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-t !&quot;) &#39;markdown-insert-header-setext-1)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-t @&quot;) &#39;markdown-insert-header-setext-2)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-t h&quot;) &#39;markdown-insert-header-dwim)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-t H&quot;) &#39;markdown-insert-header-setext-dwim)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-t s&quot;) &#39;markdown-insert-header-setext-2)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-t t&quot;) &#39;markdown-insert-header-setext-1)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-i&quot;) &#39;markdown-insert-image)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-x m&quot;) &#39;markdown-insert-list-item) ;; C-c C-j<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-x C-x&quot;) &#39;markdown-toggle-gfm-checkbox) ;; C-c C-d<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c -&quot;) &#39;markdown-insert-hr)<br />
&nbsp; &nbsp; map)<br />
&nbsp; &quot;Keymap for Markdown major mode.&quot;)</p>

<p>(defvar markdown-mode-mouse-map<br />
&nbsp; (let ((map (make-sparse-keymap)))<br />
&nbsp; &nbsp; (define-key map [follow-link] &#39;mouse-face)<br />
&nbsp; &nbsp; (define-key map [mouse-2] &#39;markdown-follow-link-at-point)<br />
&nbsp; &nbsp; map)<br />
&nbsp; &quot;Keymap for following links with mouse.&quot;)</p>

<p>(defvar gfm-mode-map<br />
&nbsp; (let ((map (make-sparse-keymap)))<br />
&nbsp; &nbsp; (set-keymap-parent map markdown-mode-map)<br />
&nbsp; &nbsp; (define-key map (kbd &quot;C-c C-s d&quot;) &#39;markdown-insert-strike-through)<br />
&nbsp; &nbsp; (define-key map &quot;`&quot; &#39;markdown-electric-backquote)<br />
&nbsp; &nbsp; map)<br />
&nbsp; &quot;Keymap for `gfm-mode&#39;.<br />
See also `markdown-mode-map&#39;.&quot;)</p>

<p><br />
;;; Menu ==================================================================</p>

<p>(easy-menu-define markdown-mode-menu markdown-mode-map<br />
&nbsp; &quot;Menu for Markdown mode&quot;<br />
&nbsp; &#39;(&quot;Markdown&quot;<br />
&nbsp; &nbsp; &quot;---&quot;<br />
&nbsp; &nbsp; (&quot;Movement&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Jump&quot; markdown-do]<br />
&nbsp; &nbsp; &nbsp;[&quot;Follow Link&quot; markdown-follow-thing-at-point]<br />
&nbsp; &nbsp; &nbsp;[&quot;Next Link&quot; markdown-next-link]<br />
&nbsp; &nbsp; &nbsp;[&quot;Previous Link&quot; markdown-previous-link]<br />
&nbsp; &nbsp; &nbsp;&quot;---&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Next Heading or List Item&quot; markdown-outline-next]<br />
&nbsp; &nbsp; &nbsp;[&quot;Previous Heading or List Item&quot; markdown-outline-previous]<br />
&nbsp; &nbsp; &nbsp;[&quot;Next at Same Level&quot; markdown-outline-next-same-level]<br />
&nbsp; &nbsp; &nbsp;[&quot;Previous at Same Level&quot; markdown-outline-previous-same-level]<br />
&nbsp; &nbsp; &nbsp;[&quot;Up to Parent&quot; markdown-outline-up]<br />
&nbsp; &nbsp; &nbsp;&quot;---&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Forward Paragraph&quot; markdown-forward-paragraph]<br />
&nbsp; &nbsp; &nbsp;[&quot;Backward Paragraph&quot; markdown-backward-paragraph]<br />
&nbsp; &nbsp; &nbsp;[&quot;Forward Block&quot; markdown-forward-block]<br />
&nbsp; &nbsp; &nbsp;[&quot;Backward Block&quot; markdown-backward-block])<br />
&nbsp; &nbsp; (&quot;Show &amp; Hide&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Cycle Heading Visibility&quot; markdown-cycle (markdown-on-heading-p)]<br />
&nbsp; &nbsp; &nbsp;[&quot;Cycle Heading Visibility (Global)&quot; markdown-shifttab]<br />
&nbsp; &nbsp; &nbsp;&quot;---&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Narrow to Region&quot; narrow-to-region]<br />
&nbsp; &nbsp; &nbsp;[&quot;Narrow to Block&quot; markdown-narrow-to-block]<br />
&nbsp; &nbsp; &nbsp;[&quot;Narrow to Section&quot; narrow-to-defun]<br />
&nbsp; &nbsp; &nbsp;[&quot;Narrow to Subtree&quot; markdown-narrow-to-subtree]<br />
&nbsp; &nbsp; &nbsp;[&quot;Widen&quot; widen (buffer-narrowed-p)]<br />
&nbsp; &nbsp; &nbsp;&quot;---&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Toggle Markup Hiding&quot; markdown-toggle-markup-hiding<br />
&nbsp; &nbsp; &nbsp; :keys &quot;C-c C-x C-m&quot;<br />
&nbsp; &nbsp; &nbsp; :style radio<br />
&nbsp; &nbsp; &nbsp; :selected markdown-hide-markup])<br />
&nbsp; &nbsp; &quot;---&quot;<br />
&nbsp; &nbsp; (&quot;Headings &amp; Structure&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Automatic Heading&quot; markdown-insert-header-dwim :keys &quot;C-c C-s h&quot;]<br />
&nbsp; &nbsp; &nbsp;[&quot;Automatic Heading (Setext)&quot; markdown-insert-header-setext-dwim :keys &quot;C-c C-s H&quot;]<br />
&nbsp; &nbsp; &nbsp;(&quot;Specific Heading (atx)&quot;<br />
&nbsp; &nbsp; &nbsp; [&quot;First Level atx&quot; markdown-insert-header-atx-1 :keys &quot;C-c C-s 1&quot;]<br />
&nbsp; &nbsp; &nbsp; [&quot;Second Level atx&quot; markdown-insert-header-atx-2 :keys &quot;C-c C-s 2&quot;]<br />
&nbsp; &nbsp; &nbsp; [&quot;Third Level atx&quot; markdown-insert-header-atx-3 :keys &quot;C-c C-s 3&quot;]<br />
&nbsp; &nbsp; &nbsp; [&quot;Fourth Level atx&quot; markdown-insert-header-atx-4 :keys &quot;C-c C-s 4&quot;]<br />
&nbsp; &nbsp; &nbsp; [&quot;Fifth Level atx&quot; markdown-insert-header-atx-5 :keys &quot;C-c C-s 5&quot;]<br />
&nbsp; &nbsp; &nbsp; [&quot;Sixth Level atx&quot; markdown-insert-header-atx-6 :keys &quot;C-c C-s 6&quot;])<br />
&nbsp; &nbsp; &nbsp;(&quot;Specific Heading (Setext)&quot;<br />
&nbsp; &nbsp; &nbsp; [&quot;First Level Setext&quot; markdown-insert-header-setext-1 :keys &quot;C-c C-s !&quot;]<br />
&nbsp; &nbsp; &nbsp; [&quot;Second Level Setext&quot; markdown-insert-header-setext-2 :keys &quot;C-c C-s @&quot;])<br />
&nbsp; &nbsp; &nbsp;[&quot;Horizontal Rule&quot; markdown-insert-hr :keys &quot;C-c C-s -&quot;]<br />
&nbsp; &nbsp; &nbsp;&quot;---&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Move Subtree Up&quot; markdown-move-up :keys &quot;C-c &lt;up&gt;&quot;]<br />
&nbsp; &nbsp; &nbsp;[&quot;Move Subtree Down&quot; markdown-move-down :keys &quot;C-c &lt;down&gt;&quot;]<br />
&nbsp; &nbsp; &nbsp;[&quot;Promote Subtree&quot; markdown-promote :keys &quot;C-c &lt;left&gt;&quot;]<br />
&nbsp; &nbsp; &nbsp;[&quot;Demote Subtree&quot; markdown-demote :keys &quot;C-c &lt;right&gt;&quot;])<br />
&nbsp; &nbsp; (&quot;Region &amp; Mark&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Indent Region&quot; markdown-indent-region]<br />
&nbsp; &nbsp; &nbsp;[&quot;Outdent Region&quot; markdown-outdent-region]<br />
&nbsp; &nbsp; &nbsp;&quot;--&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Mark Paragraph&quot; mark-paragraph]<br />
&nbsp; &nbsp; &nbsp;[&quot;Mark Block&quot; markdown-mark-block]<br />
&nbsp; &nbsp; &nbsp;[&quot;Mark Section&quot; mark-defun]<br />
&nbsp; &nbsp; &nbsp;[&quot;Mark Subtree&quot; markdown-mark-subtree])<br />
&nbsp; &nbsp; (&quot;Lists&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Insert List Item&quot; markdown-insert-list-item]<br />
&nbsp; &nbsp; &nbsp;[&quot;Move Subtree Up&quot; markdown-move-up :keys &quot;C-c &lt;up&gt;&quot;]<br />
&nbsp; &nbsp; &nbsp;[&quot;Move Subtree Down&quot; markdown-move-down :keys &quot;C-c &lt;down&gt;&quot;]<br />
&nbsp; &nbsp; &nbsp;[&quot;Indent Subtree&quot; markdown-demote :keys &quot;C-c &lt;right&gt;&quot;]<br />
&nbsp; &nbsp; &nbsp;[&quot;Outdent Subtree&quot; markdown-promote :keys &quot;C-c &lt;left&gt;&quot;]<br />
&nbsp; &nbsp; &nbsp;[&quot;Renumber List&quot; markdown-cleanup-list-numbers]<br />
&nbsp; &nbsp; &nbsp;[&quot;Toggle Task List Item&quot; markdown-toggle-gfm-checkbox :keys &quot;C-c C-d&quot;])<br />
&nbsp; &nbsp; (&quot;Links &amp; Images&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Insert Link&quot; markdown-insert-link]<br />
&nbsp; &nbsp; &nbsp;[&quot;Insert Image&quot; markdown-insert-image]<br />
&nbsp; &nbsp; &nbsp;[&quot;Insert Footnote&quot; markdown-insert-footnote :keys &quot;C-c C-s f&quot;]<br />
&nbsp; &nbsp; &nbsp;[&quot;Insert Wiki Link&quot; markdown-insert-wiki-link :keys &quot;C-c C-s w&quot;]<br />
&nbsp; &nbsp; &nbsp;&quot;---&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Check References&quot; markdown-check-refs]<br />
&nbsp; &nbsp; &nbsp;[&quot;Toggle URL Hiding&quot; markdown-toggle-url-hiding<br />
&nbsp; &nbsp; &nbsp; :style radio<br />
&nbsp; &nbsp; &nbsp; :selected markdown-hide-urls]<br />
&nbsp; &nbsp; &nbsp;[&quot;Toggle Inline Images&quot; markdown-toggle-inline-images<br />
&nbsp; &nbsp; &nbsp; :keys &quot;C-c C-x C-i&quot;<br />
&nbsp; &nbsp; &nbsp; :style radio<br />
&nbsp; &nbsp; &nbsp; :selected markdown-inline-image-overlays]<br />
&nbsp; &nbsp; &nbsp;[&quot;Toggle Wiki Links&quot; markdown-toggle-wiki-links<br />
&nbsp; &nbsp; &nbsp; :style radio<br />
&nbsp; &nbsp; &nbsp; :selected markdown-enable-wiki-links])<br />
&nbsp; &nbsp; (&quot;Styles&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Bold&quot; markdown-insert-bold]<br />
&nbsp; &nbsp; &nbsp;[&quot;Italic&quot; markdown-insert-italic]<br />
&nbsp; &nbsp; &nbsp;[&quot;Code&quot; markdown-insert-code]<br />
&nbsp; &nbsp; &nbsp;[&quot;Strikethrough&quot; markdown-insert-strike-through]<br />
&nbsp; &nbsp; &nbsp;[&quot;Keyboard&quot; markdown-insert-kbd]<br />
&nbsp; &nbsp; &nbsp;&quot;---&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Blockquote&quot; markdown-insert-blockquote]<br />
&nbsp; &nbsp; &nbsp;[&quot;Preformatted&quot; markdown-insert-pre]<br />
&nbsp; &nbsp; &nbsp;[&quot;GFM Code Block&quot; markdown-insert-gfm-code-block]<br />
&nbsp; &nbsp; &nbsp;[&quot;Edit Code Block&quot; markdown-edit-code-block (markdown-code-block-at-point-p)]<br />
&nbsp; &nbsp; &nbsp;&quot;---&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Blockquote Region&quot; markdown-blockquote-region]<br />
&nbsp; &nbsp; &nbsp;[&quot;Preformatted Region&quot; markdown-pre-region]<br />
&nbsp; &nbsp; &nbsp;&quot;---&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Fontify Code Blocks Natively&quot; markdown-toggle-fontify-code-blocks-natively<br />
&nbsp; &nbsp; &nbsp; :style radio<br />
&nbsp; &nbsp; &nbsp; :selected markdown-fontify-code-blocks-natively]<br />
&nbsp; &nbsp; &nbsp;[&quot;LaTeX Math Support&quot; markdown-toggle-math<br />
&nbsp; &nbsp; &nbsp; :style radio<br />
&nbsp; &nbsp; &nbsp; :selected markdown-enable-math])<br />
&nbsp; &nbsp; &quot;---&quot;<br />
&nbsp; &nbsp; (&quot;Preview &amp; Export&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Compile&quot; markdown-other-window]<br />
&nbsp; &nbsp; &nbsp;[&quot;Preview&quot; markdown-preview]<br />
&nbsp; &nbsp; &nbsp;[&quot;Export&quot; markdown-export]<br />
&nbsp; &nbsp; &nbsp;[&quot;Export &amp; View&quot; markdown-export-and-preview]<br />
&nbsp; &nbsp; &nbsp;[&quot;Open&quot; markdown-open]<br />
&nbsp; &nbsp; &nbsp;[&quot;Live Export&quot; markdown-live-preview-mode<br />
&nbsp; &nbsp; &nbsp; :style radio<br />
&nbsp; &nbsp; &nbsp; :selected markdown-live-preview-mode]<br />
&nbsp; &nbsp; &nbsp;[&quot;Kill ring save&quot; markdown-kill-ring-save])<br />
&nbsp; &nbsp; (&quot;Markup Completion and Cycling&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Complete Markup&quot; markdown-complete]<br />
&nbsp; &nbsp; &nbsp;[&quot;Promote Element&quot; markdown-promote :keys &quot;C-c C--&quot;]<br />
&nbsp; &nbsp; &nbsp;[&quot;Demote Element&quot; markdown-demote :keys &quot;C-c C-=&quot;])<br />
&nbsp; &nbsp; &quot;---&quot;<br />
&nbsp; &nbsp; [&quot;Kill Element&quot; markdown-kill-thing-at-point]<br />
&nbsp; &nbsp; &quot;---&quot;<br />
&nbsp; &nbsp; (&quot;Documentation&quot;<br />
&nbsp; &nbsp; &nbsp;[&quot;Version&quot; markdown-show-version]<br />
&nbsp; &nbsp; &nbsp;[&quot;Homepage&quot; markdown-mode-info]<br />
&nbsp; &nbsp; &nbsp;[&quot;Describe Mode&quot; (describe-function &#39;markdown-mode)]<br />
&nbsp; &nbsp; &nbsp;[&quot;Guide&quot; (browse-url &quot;https://leanpub.com/markdown-mode&quot;)])))</p>

<p><br />
;;; imenu =====================================================================</p>

<p>(defun markdown-imenu-create-nested-index ()<br />
&nbsp; &quot;Create and return a nested imenu index alist for the current buffer.<br />
See `imenu-create-index-function&#39; and `imenu--index-alist&#39; for details.&quot;<br />
&nbsp; (let* ((root &#39;(nil . nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;cur-alist<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cur-level 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(empty-heading &quot;-&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(self-heading &quot;.&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;hashes pos level heading)<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; &nbsp; (while (re-search-forward markdown-regex-header (point-max) t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (unless (markdown-code-block-at-point-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((match-string-no-properties 2) ;; level 1 setext<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq heading (match-string-no-properties 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq pos (match-beginning 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; level 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((match-string-no-properties 3) ;; level 2 setext<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq heading (match-string-no-properties 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq pos (match-beginning 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; level 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((setq hashes (markdown-trim-whitespace<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (match-string-no-properties 4)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq heading (match-string-no-properties 5)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pos (match-beginning 4)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; level (length hashes))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((alist (list (cons heading pos))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((= cur-level level) &nbsp; &nbsp; &nbsp; ; new sibling<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setcdr cur-alist alist)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq cur-alist alist))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((&lt; cur-level level) &nbsp; &nbsp; &nbsp; ; first child<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (dotimes (_ (- level cur-level 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq alist (list (cons empty-heading alist))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if cur-alist<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let* ((parent (car cur-alist))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(self-pos (cdr parent)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setcdr parent (cons (cons self-heading self-pos) alist)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setcdr root alist)) &nbsp; &nbsp;; primogenitor<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq cur-alist alist)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq cur-level level))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(t &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ; new sibling of an ancestor<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((sibling-alist (last (cdr root))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (dotimes (_ (1- level))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq sibling-alist (last (cdar sibling-alist))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setcdr sibling-alist alist)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq cur-alist alist))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq cur-level level))))))<br />
&nbsp; &nbsp; &nbsp; (cdr root))))</p>

<p>(defun markdown-imenu-create-flat-index ()<br />
&nbsp; &quot;Create and return a flat imenu index alist for the current buffer.<br />
See `imenu-create-index-function&#39; and `imenu--index-alist&#39; for details.&quot;<br />
&nbsp; (let* ((empty-heading &quot;-&quot;) index heading pos)<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; &nbsp; (while (re-search-forward markdown-regex-header (point-max) t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (and (not (markdown-code-block-at-point-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (markdown-text-property-at-point &#39;markdown-yaml-metadata-begin)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((setq heading (match-string-no-properties 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq pos (match-beginning 1)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((setq heading (match-string-no-properties 5))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq pos (match-beginning 4))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (or (&gt; (length heading) 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq heading empty-heading))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq index (append index (list (cons heading pos))))))<br />
&nbsp; &nbsp; &nbsp; index)))</p>

<p><br />
;;; References ================================================================</p>

<p>(defun markdown-reference-goto-definition ()<br />
&nbsp; &quot;Jump to the definition of the reference at point or create it.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (when (thing-at-point-looking-at markdown-regex-link-reference)<br />
&nbsp; &nbsp; (let* ((text (match-string-no-properties 3))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(reference (match-string-no-properties 6))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(target (downcase (if (string= reference &quot;&quot;) text reference)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(loc (cadr (save-match-data (markdown-reference-definition target)))))<br />
&nbsp; &nbsp; &nbsp; (if loc<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char loc)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-insert-reference-definition target)))))</p>

<p>(defun markdown-reference-find-links (reference)<br />
&nbsp; &quot;Return a list of all links for REFERENCE.<br />
REFERENCE should not include the surrounding square brackets.<br />
Elements of the list have the form (text start line), where<br />
text is the link text, start is the location at the beginning of<br />
the link, and line is the line number on which the link appears.&quot;<br />
&nbsp; (let* ((ref-quote (regexp-quote reference))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(regexp (format &quot;!?\\(?:\\[\\(%s\\)\\][ ]?\\[\\]\\|\\[\\([^]]+?\\)\\][ ]?\\[%s\\]\\)&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ref-quote ref-quote))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;links)<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; &nbsp; (while (re-search-forward regexp nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let* ((text (or (match-string-no-properties 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-string-no-properties 2)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(start (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(line (markdown-line-number-at-pos)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-pushnew (list text start line) links :test #&#39;equal))))<br />
&nbsp; &nbsp; links))</p>

<p>(defun markdown-get-undefined-refs ()<br />
&nbsp; &quot;Return a list of undefined Markdown references.<br />
Result is an alist of pairs (reference . occurrences), where<br />
occurrences is itself another alist of pairs (label . line-number).<br />
For example, an alist corresponding to [Nice editor][Emacs] at line 12,<br />
\[GNU Emacs][Emacs] at line 45 and [manual][elisp] at line 127 is<br />
\((\&quot;emacs\&quot; (\&quot;Nice editor\&quot; . 12) (\&quot;GNU Emacs\&quot; . 45)) (\&quot;elisp\&quot; (\&quot;manual\&quot; . 127))).&quot;<br />
&nbsp; (let ((missing))<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; &nbsp; (while<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-forward markdown-regex-link-reference nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let* ((text (match-string-no-properties 3))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(reference (match-string-no-properties 6))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(target (downcase (if (string= reference &quot;&quot;) text reference))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless (markdown-reference-definition target)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((entry (assoc target missing)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (not entry)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-pushnew<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cons target (list (cons text (markdown-line-number-at-pos))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;missing :test #&#39;equal)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setcdr entry<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (append (cdr entry) (list (cons text (markdown-line-number-at-pos))))))))))<br />
&nbsp; &nbsp; &nbsp; (reverse missing))))</p>

<p>(defconst markdown-reference-check-buffer<br />
&nbsp; &quot;*Undefined references for %buffer%*&quot;<br />
&nbsp; &quot;Pattern for name of buffer for listing undefined references.<br />
The string %buffer% will be replaced by the corresponding<br />
`markdown-mode&#39; buffer name.&quot;)</p>

<p>(defun markdown-reference-check-buffer (&amp;optional buffer-name)<br />
&nbsp; &quot;Name and return buffer for reference checking.<br />
BUFFER-NAME is the name of the main buffer being visited.&quot;<br />
&nbsp; (or buffer-name (setq buffer-name (buffer-name)))<br />
&nbsp; (let ((refbuf (get-buffer-create (markdown-replace-regexp-in-string<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;%buffer%&quot; buffer-name<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; markdown-reference-check-buffer))))<br />
&nbsp; &nbsp; (with-current-buffer refbuf<br />
&nbsp; &nbsp; &nbsp; (when view-mode<br />
&nbsp; &nbsp; &nbsp; &nbsp; (View-exit-and-edit))<br />
&nbsp; &nbsp; &nbsp; (use-local-map button-buffer-map)<br />
&nbsp; &nbsp; &nbsp; (erase-buffer))<br />
&nbsp; &nbsp; refbuf))</p>

<p>(defconst markdown-reference-links-buffer<br />
&nbsp; &quot;*Reference links for %buffer%*&quot;<br />
&nbsp; &quot;Pattern for name of buffer for listing references.<br />
The string %buffer% will be replaced by the corresponding buffer name.&quot;)</p>

<p>(defun markdown-reference-links-buffer (&amp;optional buffer-name)<br />
&nbsp; &quot;Name, setup, and return a buffer for listing links.<br />
BUFFER-NAME is the name of the main buffer being visited.&quot;<br />
&nbsp; (or buffer-name (setq buffer-name (buffer-name)))<br />
&nbsp; (let ((linkbuf (get-buffer-create (markdown-replace-regexp-in-string<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;%buffer%&quot; buffer-name<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-reference-links-buffer))))<br />
&nbsp; &nbsp; (with-current-buffer linkbuf<br />
&nbsp; &nbsp; &nbsp; (when view-mode<br />
&nbsp; &nbsp; &nbsp; &nbsp; (View-exit-and-edit))<br />
&nbsp; &nbsp; &nbsp; (use-local-map button-buffer-map)<br />
&nbsp; &nbsp; &nbsp; (erase-buffer))<br />
&nbsp; &nbsp; linkbuf))</p>

<p>;; Add an empty Markdown reference definition to buffer<br />
;; specified in the &#39;target-buffer property. &nbsp;The reference name is<br />
;; the button&#39;s label.<br />
(define-button-type &#39;markdown-undefined-reference-button<br />
&nbsp; &#39;help-echo &quot;mouse-1, RET: create definition for undefined reference&quot;<br />
&nbsp; &#39;follow-link t<br />
&nbsp; &#39;face &#39;bold<br />
&nbsp; &#39;action (lambda (b)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((buffer (button-get b &#39;target-buffer))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (line (button-get b &#39;target-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (label (button-label b)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (switch-to-buffer-other-window buffer)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-insert-reference-definition label)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-check-refs t))))</p>

<p>;; Jump to line in buffer specified by &#39;target-buffer property.<br />
;; Line number is button&#39;s &#39;line property.<br />
(define-button-type &#39;markdown-goto-line-button<br />
&nbsp; &#39;help-echo &quot;mouse-1, RET: go to line&quot;<br />
&nbsp; &#39;follow-link t<br />
&nbsp; &#39;face &#39;italic<br />
&nbsp; &#39;action (lambda (b)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (message (button-get b &#39;buffer))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (switch-to-buffer-other-window (button-get b &#39;target-buffer))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; use call-interactively to silence compiler<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((current-prefix-arg (button-get b &#39;target-line)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (call-interactively &#39;goto-line))))</p>

<p>;; Jumps to a particular link at location given by &#39;target-char<br />
;; property in buffer given by &#39;target-buffer property.<br />
(define-button-type &#39;markdown-location-button<br />
&nbsp; &#39;help-echo &quot;mouse-1, RET: jump to location of link&quot;<br />
&nbsp; &#39;follow-link t<br />
&nbsp; &#39;face &#39;bold<br />
&nbsp; &#39;action (lambda (b)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((target (button-get b &#39;target-buffer))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (loc (button-get b &#39;target-char)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (kill-buffer-and-window)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (switch-to-buffer target)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char loc))))</p>

<p>(defun markdown-insert-undefined-reference-button (reference oldbuf)<br />
&nbsp; &quot;Insert a button for creating REFERENCE in buffer OLDBUF.<br />
REFERENCE should be a list of the form (reference . occurrences),<br />
as by `markdown-get-undefined-refs&#39;.&quot;<br />
&nbsp; (let ((label (car reference)))<br />
&nbsp; &nbsp; ;; Create a reference button<br />
&nbsp; &nbsp; (insert-button label<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;:type &#39;markdown-undefined-reference-button<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;target-buffer oldbuf<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;target-line (cdr (car (cdr reference))))<br />
&nbsp; &nbsp; (insert &quot; (&quot;)<br />
&nbsp; &nbsp; (dolist (occurrence (cdr reference))<br />
&nbsp; &nbsp; &nbsp; (let ((line (cdr occurrence)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Create a line number button<br />
&nbsp; &nbsp; &nbsp; &nbsp; (insert-button (number-to-string line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;:type &#39;markdown-goto-line-button<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;target-buffer oldbuf<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;target-line line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (insert &quot; &quot;)))<br />
&nbsp; &nbsp; (delete-char -1)<br />
&nbsp; &nbsp; (insert &quot;)&quot;)<br />
&nbsp; &nbsp; (newline)))</p>

<p>(defun markdown-insert-link-button (link oldbuf)<br />
&nbsp; &quot;Insert a button for jumping to LINK in buffer OLDBUF.<br />
LINK should be a list of the form (text char line) containing<br />
the link text, location, and line number.&quot;<br />
&nbsp; (let ((label (cl-first link))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (char (cl-second link))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (line (cl-third link)))<br />
&nbsp; &nbsp; ;; Create a reference button<br />
&nbsp; &nbsp; (insert-button label<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;:type &#39;markdown-location-button<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;target-buffer oldbuf<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;target-char char)<br />
&nbsp; &nbsp; (insert (format &quot; (line %d)\n&quot; line))))</p>

<p>(defun markdown-reference-goto-link (&amp;optional reference)<br />
&nbsp; &quot;Jump to the location of the first use of REFERENCE.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (unless reference<br />
&nbsp; &nbsp; (if (thing-at-point-looking-at markdown-regex-reference-definition)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq reference (match-string-no-properties 2))<br />
&nbsp; &nbsp; &nbsp; (user-error &quot;No reference definition at point&quot;)))<br />
&nbsp; (let ((links (markdown-reference-find-links reference)))<br />
&nbsp; &nbsp; (cond ((= (length links) 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(goto-char (cadr (car links))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((&gt; (length links) 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(let ((oldbuf (current-buffer))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(linkbuf (markdown-reference-links-buffer)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(with-current-buffer linkbuf<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(insert &quot;Links using reference &quot; reference &quot;:\n\n&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(dolist (link (reverse links))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-insert-link-button link oldbuf)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(view-buffer-other-window linkbuf)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(goto-char (point-min))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(forward-line 2)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(error &quot;No links for reference %s&quot; reference)))))</p>

<p>(defun markdown-check-refs (&amp;optional silent)<br />
&nbsp; &quot;Show all undefined Markdown references in current `markdown-mode&#39; buffer.<br />
If SILENT is non-nil, do not message anything when no undefined<br />
references found.<br />
Links which have empty reference definitions are considered to be<br />
defined.&quot;<br />
&nbsp; (interactive &quot;P&quot;)<br />
&nbsp; (when (not (eq major-mode &#39;markdown-mode))<br />
&nbsp; &nbsp; (user-error &quot;Not available in current mode&quot;))<br />
&nbsp; (let ((oldbuf (current-buffer))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (refs (markdown-get-undefined-refs))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (refbuf (markdown-reference-check-buffer)))<br />
&nbsp; &nbsp; (if (null refs)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (not silent)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (message &quot;No undefined references found&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (kill-buffer refbuf))<br />
&nbsp; &nbsp; &nbsp; (with-current-buffer refbuf<br />
&nbsp; &nbsp; &nbsp; &nbsp; (insert &quot;The following references are undefined:\n\n&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (dolist (ref refs)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-insert-undefined-reference-button ref oldbuf))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (view-buffer-other-window refbuf)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line 2)))))</p>

<p><br />
;;; Lists =====================================================================</p>

<p>(defun markdown-insert-list-item (&amp;optional arg)<br />
&nbsp; &quot;Insert a new list item.<br />
If the point is inside unordered list, insert a bullet mark. &nbsp;If<br />
the point is inside ordered list, insert the next number followed<br />
by a period. &nbsp;Use the previous list item to determine the amount<br />
of whitespace to place before and after list markers.</p>

<p>With a \\[universal-argument] prefix (i.e., when ARG is (4)),<br />
decrease the indentation by one level.</p>

<p>With two \\[universal-argument] prefixes (i.e., when ARG is (16)),<br />
increase the indentation by one level.&quot;<br />
&nbsp; (interactive &quot;p&quot;)<br />
&nbsp; (let (bounds cur-indent marker indent new-indent new-loc)<br />
&nbsp; &nbsp; (save-match-data<br />
&nbsp; &nbsp; &nbsp; ;; Look for a list item on current or previous non-blank line<br />
&nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; (while (and (not (setq bounds (markdown-cur-list-item-bounds)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (bobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-cur-line-blank-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line -1)))<br />
&nbsp; &nbsp; &nbsp; (when bounds<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cond ((save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(skip-chars-backward &quot; \t&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(looking-at-p markdown-regex-list))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(beginning-of-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(insert &quot;\n&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(forward-line -1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((not (markdown-cur-line-blank-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(newline)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq new-loc (point)))<br />
&nbsp; &nbsp; &nbsp; ;; Look ahead for a list item on next non-blank line<br />
&nbsp; &nbsp; &nbsp; (unless bounds<br />
&nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (while (and (null bounds)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (eobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-cur-line-blank-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq bounds (markdown-cur-list-item-bounds))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when bounds<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq new-loc (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless (markdown-cur-line-blank-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (newline))))<br />
&nbsp; &nbsp; &nbsp; (if (not bounds)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; When not in a list, start a new unordered one<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless (markdown-cur-line-blank-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (insert &quot;\n&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (insert markdown-unordered-list-item-prefix))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Compute indentation and marker for new list item<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq cur-indent (nth 2 bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq marker (nth 4 bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; If current item is a GFM checkbox, insert new unchecked checkbox.<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (nth 5 bounds)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq marker<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (concat marker<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (replace-regexp-in-string &quot;[Xx]&quot; &quot; &quot; (nth 5 bounds)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Dedent: decrement indentation, find previous marker.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((= arg 4)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq indent (max (- cur-indent 4) 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((prev-bounds<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(goto-char (nth 0 bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(when (markdown-up-list)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-cur-list-item-bounds)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when prev-bounds<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq marker (nth 4 prev-bounds)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Indent: increment indentation by 4, use same marker.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((= arg 16) (setq indent (+ cur-indent 4)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Same level: keep current indentation and marker.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(t (setq indent cur-indent)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq new-indent (make-string indent 32))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char new-loc)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Ordered list<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((string-match-p &quot;[0-9]&quot; marker)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (= arg 16) ;; starting a new column indented one more level<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (insert (concat new-indent &quot;1. &quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Don&#39;t use previous match-data<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (set-match-data nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; travel up to the last item and pick the correct number. &nbsp;If<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; the argument was nil, &quot;new-indent = cur-indent&quot; is the same,<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; so we don&#39;t need special treatment. Neat.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (while (and (not (looking-at (concat new-indent &quot;\\([0-9]+\\)\\(\\.[ \t]*\\)&quot;)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&gt;= (forward-line -1) 0))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let* ((old-prefix (match-string 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(old-spacing (match-string 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(new-prefix (if old-prefix<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(int-to-string (1+ (string-to-number old-prefix)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;1&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(space-adjust (- (length old-prefix) (length new-prefix)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(new-spacing (if (and (match-string 2)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (string-match-p &quot;\t&quot; old-spacing))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(&lt; space-adjust 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(&gt; space-adjust (- 1 (length (match-string 2)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (substring (match-string 2) 0 space-adjust)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (or old-spacing &quot;. &quot;))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (insert (concat new-indent new-prefix new-spacing)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Unordered list, GFM task list, or ordered list with hash mark<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((string-match-p &quot;[\\*\\+-]\\|#\\.&quot; marker)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (insert new-indent marker)))))))</p>

<p>(defun markdown-move-list-item-up ()<br />
&nbsp; &quot;Move the current list item up in the list when possible.<br />
In nested lists, move child items with the parent item.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let (cur prev old)<br />
&nbsp; &nbsp; (when (setq cur (markdown-cur-list-item-bounds))<br />
&nbsp; &nbsp; &nbsp; (setq old (point))<br />
&nbsp; &nbsp; &nbsp; (goto-char (nth 0 cur))<br />
&nbsp; &nbsp; &nbsp; (if (markdown-prev-list-item (nth 3 cur))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq prev (markdown-cur-list-item-bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (condition-case nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (transpose-regions (nth 0 prev) (nth 1 prev)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(nth 0 cur) (nth 1 cur) t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (+ (nth 0 prev) (- old (nth 0 cur)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Catch error in case regions overlap.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (error (goto-char old))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char old)))))</p>

<p>(defun markdown-move-list-item-down ()<br />
&nbsp; &quot;Move the current list item down in the list when possible.<br />
In nested lists, move child items with the parent item.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let (cur next old)<br />
&nbsp; &nbsp; (when (setq cur (markdown-cur-list-item-bounds))<br />
&nbsp; &nbsp; &nbsp; (setq old (point))<br />
&nbsp; &nbsp; &nbsp; (if (markdown-next-list-item (nth 3 cur))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq next (markdown-cur-list-item-bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (condition-case nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (transpose-regions (nth 0 cur) (nth 1 cur)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(nth 0 next) (nth 1 next) nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (+ old (- (nth 1 next) (nth 1 cur)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Catch error in case regions overlap.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (error (goto-char old))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char old)))))</p>

<p>(defun markdown-demote-list-item (&amp;optional bounds)<br />
&nbsp; &quot;Indent (or demote) the current list item.<br />
Optionally, BOUNDS of the current list item may be provided if available.<br />
In nested lists, demote child items as well.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (when (or bounds (setq bounds (markdown-cur-list-item-bounds)))<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (let ((end-marker (set-marker (make-marker) (nth 1 bounds))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (nth 0 bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (while (&lt; (point) end-marker)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless (markdown-cur-line-blank-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (insert (make-string markdown-list-indent-width ? )))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line))))))</p>

<p>(defun markdown-promote-list-item (&amp;optional bounds)<br />
&nbsp; &quot;Unindent (or promote) the current list item.<br />
Optionally, BOUNDS of the current list item may be provided if available.<br />
In nested lists, demote child items as well.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (when (or bounds (setq bounds (markdown-cur-list-item-bounds)))<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (save-match-data<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let ((end-marker (set-marker (make-marker) (nth 1 bounds)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; num regexp)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (nth 0 bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (looking-at (format &quot;^[ ]\\{1,%d\\}&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; markdown-list-indent-width))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq num (- (match-end 0) (match-beginning 0)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq regexp (format &quot;^[ ]\\{1,%d\\}&quot; num))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (while (and (&lt; (point) end-marker)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-forward regexp end-marker t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (replace-match &quot;&quot; nil nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line))))))))</p>

<p>(defun markdown-cleanup-list-numbers-level (&amp;optional pfx)<br />
&nbsp; &quot;Update the numbering for level PFX (as a string of spaces).</p>

<p>Assume that the previously found match was for a numbered item in<br />
a list.&quot;<br />
&nbsp; (let ((cpfx pfx)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (idx 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (continue t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (step t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (sep nil))<br />
&nbsp; &nbsp; (while (and continue (not (eobp)))<br />
&nbsp; &nbsp; &nbsp; (setq step t)<br />
&nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp;((looking-at &quot;^\\([\s-]*\\)[0-9]+\\. &quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq cpfx (match-string-no-properties 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((string= cpfx pfx)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (replace-match<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(concat pfx (number-to-string (setq idx (1+ idx))) &quot;. &quot;)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq sep nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; indented a level<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((string&lt; pfx cpfx)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq sep (markdown-cleanup-list-numbers-level cpfx))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq step nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; exit the loop<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq step nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq continue nil))))</p>

<p>&nbsp; &nbsp; &nbsp; &nbsp;((looking-at &quot;^\\([\s-]*\\)[^ \t\n\r].*$&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq cpfx (match-string-no-properties 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; reset if separated before<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((string= cpfx pfx) (when sep (setq idx 0)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((string&lt; cpfx pfx)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq step nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq continue nil))))<br />
&nbsp; &nbsp; &nbsp; &nbsp;(t (setq sep t)))</p>

<p>&nbsp; &nbsp; &nbsp; (when step<br />
&nbsp; &nbsp; &nbsp; &nbsp; (beginning-of-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq continue (= (forward-line) 0))))<br />
&nbsp; &nbsp; sep))</p>

<p>(defun markdown-cleanup-list-numbers ()<br />
&nbsp; &quot;Update the numbering of ordered lists.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; (markdown-cleanup-list-numbers-level &quot;&quot;)))</p>

<p><br />
;;; Movement ==================================================================</p>

<p>(defun markdown-beginning-of-defun (&amp;optional arg)<br />
&nbsp; &quot;`beginning-of-defun-function&#39; for Markdown.<br />
This is used to find the beginning of the defun and should behave<br />
like &acirc;&euro;&tilde;beginning-of-defun&acirc;&euro;&trade;, returning non-nil if it found the<br />
beginning of a defun. &nbsp;It moves the point backward, right before a<br />
heading which defines a defun. &nbsp;When ARG is non-nil, repeat that<br />
many times. &nbsp;When ARG is negative, move forward to the ARG-th<br />
following section.&quot;<br />
&nbsp; (or arg (setq arg 1))<br />
&nbsp; (when (&lt; arg 0) (end-of-line))<br />
&nbsp; ;; Adjust position for setext headings.<br />
&nbsp; (when (and (thing-at-point-looking-at markdown-regex-header-setext)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (= (point) (match-beginning 0)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (markdown-code-block-at-point-p)))<br />
&nbsp; &nbsp; (goto-char (match-end 0)))<br />
&nbsp; (let (found)<br />
&nbsp; &nbsp; ;; Move backward with positive argument.<br />
&nbsp; &nbsp; (while (and (not (bobp)) (&gt; arg 0))<br />
&nbsp; &nbsp; &nbsp; (setq found nil)<br />
&nbsp; &nbsp; &nbsp; (while (and (not found)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (bobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-backward markdown-regex-header nil &#39;move))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (not (markdown-code-block-at-pos (match-beginning 0))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq found (match-beginning 0)))<br />
&nbsp; &nbsp; &nbsp; (setq arg (1- arg)))<br />
&nbsp; &nbsp; ;; Move forward with negative argument.<br />
&nbsp; &nbsp; (while (and (not (eobp)) (&lt; arg 0))<br />
&nbsp; &nbsp; &nbsp; (setq found nil)<br />
&nbsp; &nbsp; &nbsp; (while (and (not found)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (eobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-forward markdown-regex-header nil &#39;move))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (not (markdown-code-block-at-pos (match-beginning 0))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq found (match-beginning 0)))<br />
&nbsp; &nbsp; &nbsp; (setq arg (1+ arg)))<br />
&nbsp; &nbsp; (when found<br />
&nbsp; &nbsp; &nbsp; (beginning-of-line)<br />
&nbsp; &nbsp; &nbsp; t)))</p>

<p>(defun markdown-end-of-defun ()<br />
&nbsp; &quot;`end-of-defun-function&acirc;&euro;&trade; for Markdown.<br />
This is used to find the end of the defun at point.<br />
It is called with no argument, right after calling &acirc;&euro;&tilde;beginning-of-defun-raw&acirc;&euro;&trade;,<br />
so it can assume that point is at the beginning of the defun body.<br />
It should move point to the first position after the defun.&quot;<br />
&nbsp; (or (eobp) (forward-char 1))<br />
&nbsp; (let (found)<br />
&nbsp; &nbsp; (while (and (not found)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (eobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-forward markdown-regex-header nil &#39;move))<br />
&nbsp; &nbsp; &nbsp; (when (not (markdown-code-block-at-pos (match-beginning 0)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq found (match-beginning 0))))<br />
&nbsp; &nbsp; (when found<br />
&nbsp; &nbsp; &nbsp; (goto-char found)<br />
&nbsp; &nbsp; &nbsp; (skip-syntax-backward &quot;-&quot;))))</p>

<p>(make-obsolete &#39;markdown-beginning-of-block &#39;markdown-beginning-of-text-block &quot;v2.2&quot;)</p>

<p>(defun markdown-beginning-of-text-block ()<br />
&nbsp; &quot;Move backward to previous beginning of a plain text block.<br />
This function simply looks for blank lines without considering<br />
the surrounding context in light of Markdown syntax. &nbsp;For that, see<br />
`markdown-backward-block&#39;.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((start (point)))<br />
&nbsp; &nbsp; (if (re-search-backward markdown-regex-block-separator nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-end 0))<br />
&nbsp; &nbsp; &nbsp; (goto-char (point-min)))<br />
&nbsp; &nbsp; (when (and (= start (point)) (not (bobp)))<br />
&nbsp; &nbsp; &nbsp; (forward-line -1)<br />
&nbsp; &nbsp; &nbsp; (if (re-search-backward markdown-regex-block-separator nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-end 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (point-min))))))</p>

<p>(make-obsolete &#39;markdown-end-of-block &#39;markdown-end-of-text-block &quot;v2.2&quot;)</p>

<p>(defun markdown-end-of-text-block ()<br />
&nbsp; &quot;Move forward to next beginning of a plain text block.<br />
This function simply looks for blank lines without considering<br />
the surrounding context in light of Markdown syntax. &nbsp;For that, see<br />
`markdown-forward-block&#39;.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (beginning-of-line)<br />
&nbsp; (skip-syntax-forward &quot;-&quot;)<br />
&nbsp; (when (= (point) (point-min))<br />
&nbsp; &nbsp; (forward-char))<br />
&nbsp; (if (re-search-forward markdown-regex-block-separator nil t)<br />
&nbsp; &nbsp; &nbsp; (goto-char (match-end 0))<br />
&nbsp; &nbsp; (goto-char (point-max)))<br />
&nbsp; (skip-syntax-backward &quot;-&quot;)<br />
&nbsp; (forward-line))</p>

<p>(defun markdown-backward-paragraph (&amp;optional arg)<br />
&nbsp; &quot;Move the point to the start of the current paragraph.<br />
With argument ARG, do it ARG times; a negative argument ARG = -N<br />
means move forward N blocks.&quot;<br />
&nbsp; (interactive &quot;^p&quot;)<br />
&nbsp; (or arg (setq arg 1))<br />
&nbsp; (if (&lt; arg 0)<br />
&nbsp; &nbsp; &nbsp; (markdown-forward-paragraph (- arg))<br />
&nbsp; &nbsp; (dotimes (_ arg)<br />
&nbsp; &nbsp; &nbsp; ;; Skip over whitespace in between paragraphs when moving backward.<br />
&nbsp; &nbsp; &nbsp; (skip-syntax-backward &quot;-&quot;)<br />
&nbsp; &nbsp; &nbsp; (beginning-of-line)<br />
&nbsp; &nbsp; &nbsp; ;; Skip over code block endings.<br />
&nbsp; &nbsp; &nbsp; (when (markdown-range-properties-exist<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (point-at-bol) (point-at-eol)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;(markdown-gfm-block-end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; markdown-tilde-fence-end))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line -1))<br />
&nbsp; &nbsp; &nbsp; ;; Skip over blank lines inside blockquotes.<br />
&nbsp; &nbsp; &nbsp; (while (and (not (eobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (looking-at markdown-regex-blockquote)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (= (length (match-string 3)) 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line -1))<br />
&nbsp; &nbsp; &nbsp; ;; Proceed forward based on the type of block of paragraph.<br />
&nbsp; &nbsp; &nbsp; (let (bounds skip)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Blockquotes<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((looking-at markdown-regex-blockquote)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (while (and (not (bobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (looking-at markdown-regex-blockquote)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&gt; (length (match-string 3)) 0)) ;; not blank<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line -1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; List items<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((setq bounds (markdown-cur-list-item-bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (nth 0 bounds)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Other<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (while (and (not (bobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not skip)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (markdown-cur-line-blank-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (looking-at markdown-regex-blockquote))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (markdown-range-properties-exist<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (point-at-bol) (point-at-eol)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;(markdown-gfm-block-end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; markdown-tilde-fence-end))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq skip (markdown-range-properties-exist<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (point-at-bol) (point-at-eol)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;(markdown-gfm-block-begin<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; markdown-tilde-fence-begin)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line -1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless (bobp)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line 1))))))))</p>

<p>(defun markdown-forward-paragraph (&amp;optional arg)<br />
&nbsp; &quot;Move forward to the next end of a paragraph.<br />
With argument ARG, do it ARG times; a negative argument ARG = -N<br />
means move backward N blocks.&quot;<br />
&nbsp; (interactive &quot;^p&quot;)<br />
&nbsp; (or arg (setq arg 1))<br />
&nbsp; (if (&lt; arg 0)<br />
&nbsp; &nbsp; &nbsp; (markdown-backward-paragraph (- arg))<br />
&nbsp; &nbsp; (dotimes (_ arg)<br />
&nbsp; &nbsp; &nbsp; ;; Skip whitespace in between paragraphs.<br />
&nbsp; &nbsp; &nbsp; (when (markdown-cur-line-blank-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (skip-syntax-forward &quot;-&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (beginning-of-line))<br />
&nbsp; &nbsp; &nbsp; ;; Proceed forward based on the type of block.<br />
&nbsp; &nbsp; &nbsp; (let (bounds skip)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Blockquotes<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((looking-at markdown-regex-blockquote)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Skip over blank lines inside blockquotes.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (while (and (not (eobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (looking-at markdown-regex-blockquote)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (= (length (match-string 3)) 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Move to end of quoted text block<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (while (and (not (eobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (looking-at markdown-regex-blockquote)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&gt; (length (match-string 3)) 0)) ;; not blank<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; List items<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((and (markdown-cur-list-item-bounds)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(setq bounds (markdown-next-list-item-bounds)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (nth 0 bounds)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Other<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (while (and (not (eobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not skip)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (markdown-cur-line-blank-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (looking-at markdown-regex-blockquote))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (markdown-range-properties-exist<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (point-at-bol) (point-at-eol)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;(markdown-gfm-block-begin<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; markdown-tilde-fence-begin))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq skip (markdown-range-properties-exist<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (point-at-bol) (point-at-eol)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;(markdown-gfm-block-end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; markdown-tilde-fence-end)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line))))))))</p>

<p>(defun markdown-backward-block (&amp;optional arg)<br />
&nbsp; &quot;Move the point to the start of the current Markdown block.<br />
Moves across complete code blocks, list items, and blockquotes,<br />
but otherwise stops at blank lines, headers, and horizontal<br />
rules. &nbsp;With argument ARG, do it ARG times; a negative argument<br />
ARG = -N means move forward N blocks.&quot;<br />
&nbsp; (interactive &quot;^p&quot;)<br />
&nbsp; (or arg (setq arg 1))<br />
&nbsp; (if (&lt; arg 0)<br />
&nbsp; &nbsp; &nbsp; (markdown-forward-block (- arg))<br />
&nbsp; &nbsp; (dotimes (_ arg)<br />
&nbsp; &nbsp; &nbsp; ;; Skip over whitespace in between blocks when moving backward,<br />
&nbsp; &nbsp; &nbsp; ;; unless at a block boundary with no whitespace.<br />
&nbsp; &nbsp; &nbsp; (skip-syntax-backward &quot;-&quot;)<br />
&nbsp; &nbsp; &nbsp; (beginning-of-line)<br />
&nbsp; &nbsp; &nbsp; ;; Proceed forward based on the type of block.<br />
&nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Code blocks<br />
&nbsp; &nbsp; &nbsp; &nbsp;((and (markdown-code-block-at-pos (point)) ;; this line<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-code-block-at-pos (point-at-bol 0))) ;; previous line<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line -1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (while (and (markdown-code-block-at-point-p) (not (bobp)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line -1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Headings<br />
&nbsp; &nbsp; &nbsp; &nbsp;((markdown-heading-at-point)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-beginning 0)))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Horizontal rules<br />
&nbsp; &nbsp; &nbsp; &nbsp;((looking-at markdown-regex-hr))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Blockquotes<br />
&nbsp; &nbsp; &nbsp; &nbsp;((looking-at markdown-regex-blockquote)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line -1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (while (and (looking-at markdown-regex-blockquote)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not (bobp)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line -1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; List items<br />
&nbsp; &nbsp; &nbsp; &nbsp;((markdown-cur-list-item-bounds)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-beginning-of-list))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Other<br />
&nbsp; &nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Move forward in case it is a one line regular paragraph.<br />
&nbsp; &nbsp; &nbsp; &nbsp; (unless (markdown-next-line-blank-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (unless (markdown-prev-line-blank-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-backward-paragraph)))))))</p>

<p>(defun markdown-forward-block (&amp;optional arg)<br />
&nbsp; &quot;Move forward to the next end of a Markdown block.<br />
Moves across complete code blocks, list items, and blockquotes,<br />
but otherwise stops at blank lines, headers, and horizontal<br />
rules. &nbsp;With argument ARG, do it ARG times; a negative argument<br />
ARG = -N means move backward N blocks.&quot;<br />
&nbsp; (interactive &quot;^p&quot;)<br />
&nbsp; (or arg (setq arg 1))<br />
&nbsp; (if (&lt; arg 0)<br />
&nbsp; &nbsp; &nbsp; (markdown-backward-block (- arg))<br />
&nbsp; &nbsp; (dotimes (_ arg)<br />
&nbsp; &nbsp; &nbsp; ;; Skip over whitespace in between blocks when moving forward.<br />
&nbsp; &nbsp; &nbsp; (if (markdown-cur-line-blank-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (skip-syntax-forward &quot;-&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (beginning-of-line))<br />
&nbsp; &nbsp; &nbsp; ;; Proceed forward based on the type of block.<br />
&nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Code blocks<br />
&nbsp; &nbsp; &nbsp; &nbsp;((markdown-code-block-at-point-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (while (and (markdown-code-block-at-point-p) (not (eobp)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line)))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Headings<br />
&nbsp; &nbsp; &nbsp; &nbsp;((looking-at markdown-regex-header)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (or (match-end 4) (match-end 2) (match-end 3)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Horizontal rules<br />
&nbsp; &nbsp; &nbsp; &nbsp;((looking-at markdown-regex-hr)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Blockquotes<br />
&nbsp; &nbsp; &nbsp; &nbsp;((looking-at markdown-regex-blockquote)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (while (and (looking-at markdown-regex-blockquote) (not (eobp)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-line)))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; List items<br />
&nbsp; &nbsp; &nbsp; &nbsp;((markdown-cur-list-item-bounds)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-end-of-list)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Other<br />
&nbsp; &nbsp; &nbsp; &nbsp;(t (markdown-forward-paragraph))))<br />
&nbsp; &nbsp; (skip-syntax-backward &quot;-&quot;)<br />
&nbsp; &nbsp; (unless (eobp)<br />
&nbsp; &nbsp; &nbsp; (forward-char 1))))</p>

<p>(defun markdown-backward-page (&amp;optional count)<br />
&nbsp; &quot;Move backward to boundary of the current toplevel section.<br />
With COUNT, repeat, or go forward if negative.&quot;<br />
&nbsp; (interactive &quot;p&quot;)<br />
&nbsp; (or count (setq count 1))<br />
&nbsp; (if (&lt; count 0)<br />
&nbsp; &nbsp; &nbsp; (markdown-forward-page (- count))<br />
&nbsp; &nbsp; (skip-syntax-backward &quot;-&quot;)<br />
&nbsp; &nbsp; (or (markdown-back-to-heading-over-code-block t t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (point-min)))<br />
&nbsp; &nbsp; (when (looking-at markdown-regex-header)<br />
&nbsp; &nbsp; &nbsp; (let ((level (markdown-outline-level)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (&gt; level 1) (markdown-up-heading level))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (&gt; count 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (condition-case nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-backward-same-level (1- count))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (error (goto-char (point-min)))))))))</p>

<p>(defun markdown-forward-page (&amp;optional count)<br />
&nbsp; &quot;Move forward to boundary of the current toplevel section.<br />
With COUNT, repeat, or go backward if negative.&quot;<br />
&nbsp; (interactive &quot;p&quot;)<br />
&nbsp; (or count (setq count 1))<br />
&nbsp; (if (&lt; count 0)<br />
&nbsp; &nbsp; &nbsp; (markdown-backward-page (- count))<br />
&nbsp; &nbsp; (if (markdown-back-to-heading-over-code-block t t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let ((level (markdown-outline-level)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (&gt; level 1) (markdown-up-heading level))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (condition-case nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-forward-same-level count)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (error (goto-char (point-max)))))<br />
&nbsp; &nbsp; &nbsp; (markdown-next-visible-heading 1))))</p>

<p>(defun markdown-next-link ()<br />
&nbsp; &quot;Jump to next inline, reference, or wiki link.<br />
If successful, return point. &nbsp;Otherwise, return nil.<br />
See `markdown-wiki-link-p&#39; and `markdown-previous-wiki-link&#39;.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((opoint (point)))<br />
&nbsp; &nbsp; (when (or (markdown-link-p) (markdown-wiki-link-p))<br />
&nbsp; &nbsp; &nbsp; ;; At a link already, move past it.<br />
&nbsp; &nbsp; &nbsp; (goto-char (+ (match-end 0) 1)))<br />
&nbsp; &nbsp; ;; Search for the next wiki link and move to the beginning.<br />
&nbsp; &nbsp; (while (and (re-search-forward (markdown-make-regex-link-generic) nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-code-block-at-point-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&lt; (point) (point-max))))<br />
&nbsp; &nbsp; (if (and (not (eq (point) opoint))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(or (markdown-link-p) (markdown-wiki-link-p)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Group 1 will move past non-escape character in wiki link regexp.<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Go to beginning of group zero for all other link types.<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (or (match-beginning 1) (match-beginning 0)))<br />
&nbsp; &nbsp; &nbsp; (goto-char opoint)<br />
&nbsp; &nbsp; &nbsp; nil)))</p>

<p>(defun markdown-previous-link ()<br />
&nbsp; &quot;Jump to previous wiki link.<br />
If successful, return point. &nbsp;Otherwise, return nil.<br />
See `markdown-wiki-link-p&#39; and `markdown-next-wiki-link&#39;.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((opoint (point)))<br />
&nbsp; &nbsp; (while (and (re-search-backward (markdown-make-regex-link-generic) nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-code-block-at-point-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&gt; (point) (point-min))))<br />
&nbsp; &nbsp; (if (and (not (eq (point) opoint))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(or (markdown-link-p) (markdown-wiki-link-p)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (or (match-beginning 1) (match-beginning 0)))<br />
&nbsp; &nbsp; &nbsp; (goto-char opoint)<br />
&nbsp; &nbsp; &nbsp; nil)))</p>

<p><br />
;;; Outline ===================================================================</p>

<p>(defun markdown-move-heading-common (move-fn &amp;optional arg adjust)<br />
&nbsp; &quot;Wrapper for `outline-mode&#39; functions to skip false positives.<br />
MOVE-FN is a function and ARG is its argument. For example,<br />
headings inside preformatted code blocks may match<br />
`outline-regexp&#39; but should not be considered as headings.<br />
When ADJUST is non-nil, adjust the point for interactive calls<br />
to avoid leaving the point at invisible markup. &nbsp;This adjustment<br />
generally should only be done for interactive calls, since other<br />
functions may expect the point to be at the beginning of the<br />
regular expression.&quot;<br />
&nbsp; (let ((prev -1) (start (point)))<br />
&nbsp; &nbsp; (if arg (funcall move-fn arg) (funcall move-fn))<br />
&nbsp; &nbsp; (while (and (/= prev (point)) (markdown-code-block-at-point-p))<br />
&nbsp; &nbsp; &nbsp; (setq prev (point))<br />
&nbsp; &nbsp; &nbsp; (if arg (funcall move-fn arg) (funcall move-fn)))<br />
&nbsp; &nbsp; ;; Adjust point for setext headings and invisible text.<br />
&nbsp; &nbsp; (save-match-data<br />
&nbsp; &nbsp; &nbsp; (when (and adjust (thing-at-point-looking-at markdown-regex-header))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if markdown-hide-markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Move to beginning of heading text if markup is hidden.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (or (match-beginning 1) (match-beginning 5)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Move to beginning of markup otherwise.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (or (match-beginning 1) (match-beginning 4))))))<br />
&nbsp; &nbsp; (if (= (point) start) nil (point))))</p>

<p>(defun markdown-next-visible-heading (arg)<br />
&nbsp; &quot;Move to the next visible heading line of any level.<br />
With argument, repeats or can move backward if negative. ARG is<br />
passed to `outline-next-visible-heading&#39;.&quot;<br />
&nbsp; (interactive &quot;p&quot;)<br />
&nbsp; (markdown-move-heading-common #&#39;outline-next-visible-heading arg &#39;adjust))</p>

<p>(defun markdown-previous-visible-heading (arg)<br />
&nbsp; &quot;Move to the previous visible heading line of any level.<br />
With argument, repeats or can move backward if negative. ARG is<br />
passed to `outline-previous-visible-heading&#39;.&quot;<br />
&nbsp; (interactive &quot;p&quot;)<br />
&nbsp; (markdown-move-heading-common #&#39;outline-previous-visible-heading arg &#39;adjust))</p>

<p>(defun markdown-next-heading ()<br />
&nbsp; &quot;Move to the next heading line of any level.&quot;<br />
&nbsp; (markdown-move-heading-common #&#39;outline-next-heading))</p>

<p>(defun markdown-previous-heading ()<br />
&nbsp; &quot;Move to the previous heading line of any level.&quot;<br />
&nbsp; (markdown-move-heading-common #&#39;outline-previous-heading))</p>

<p>(defun markdown-back-to-heading-over-code-block (&amp;optional invisible-ok no-error)<br />
&nbsp; &quot;Move back to the beginning of the previous heading.<br />
Returns t if the point is at a heading, the location if a heading<br />
was found, and nil otherwise.<br />
Only visible heading lines are considered, unless INVISIBLE-OK is<br />
non-nil. &nbsp;Throw an error if there is no previous heading unless<br />
NO-ERROR is non-nil.<br />
Leaves match data intact for `markdown-regex-header&#39;.&quot;<br />
&nbsp; (beginning-of-line)<br />
&nbsp; (or (and (markdown-heading-at-point)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (markdown-code-block-at-point-p)))<br />
&nbsp; &nbsp; &nbsp; (let (found)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (while (and (not found)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-backward markdown-regex-header nil t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (and (or invisible-ok (not (outline-invisible-p)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (markdown-code-block-at-point-p)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq found (point))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (not found)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless no-error (user-error &quot;Before first heading&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq found (point))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when found (goto-char found)))))</p>

<p>(defun markdown-forward-same-level (arg)<br />
&nbsp; &quot;Move forward to the ARG&#39;th heading at same level as this one.<br />
Stop at the first and last headings of a superior heading.&quot;<br />
&nbsp; (interactive &quot;p&quot;)<br />
&nbsp; (markdown-back-to-heading-over-code-block)<br />
&nbsp; (markdown-move-heading-common #&#39;outline-forward-same-level arg &#39;adjust))</p>

<p>(defun markdown-backward-same-level (arg)<br />
&nbsp; &quot;Move backward to the ARG&#39;th heading at same level as this one.<br />
Stop at the first and last headings of a superior heading.&quot;<br />
&nbsp; (interactive &quot;p&quot;)<br />
&nbsp; (markdown-back-to-heading-over-code-block)<br />
&nbsp; (while (&gt; arg 0)<br />
&nbsp; &nbsp; (let ((point-to-move-to<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-move-heading-common #&#39;outline-get-last-sibling nil &#39;adjust))))<br />
&nbsp; &nbsp; &nbsp; (if point-to-move-to<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char point-to-move-to)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq arg (1- arg)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (user-error &quot;No previous same-level heading&quot;)))))</p>

<p>(defun markdown-up-heading (arg)<br />
&nbsp; &quot;Move to the visible heading line of which the present line is a subheading.<br />
With argument, move up ARG levels.&quot;<br />
&nbsp; (interactive &quot;p&quot;)<br />
&nbsp; (and (called-interactively-p &#39;any)<br />
&nbsp; &nbsp; &nbsp; &nbsp;(not (eq last-command &#39;markdown-up-heading)) (push-mark))<br />
&nbsp; (markdown-move-heading-common #&#39;outline-up-heading arg &#39;adjust))</p>

<p>(defun markdown-back-to-heading (&amp;optional invisible-ok)<br />
&nbsp; &quot;Move to previous heading line, or beg of this line if it&#39;s a heading.<br />
Only visible heading lines are considered, unless INVISIBLE-OK is non-nil.&quot;<br />
&nbsp; (markdown-move-heading-common #&#39;outline-back-to-heading invisible-ok))</p>

<p>(defalias &#39;markdown-end-of-heading &#39;outline-end-of-heading)</p>

<p>(defun markdown-on-heading-p ()<br />
&nbsp; &quot;Return non-nil if point is on a heading line.&quot;<br />
&nbsp; (get-text-property (point-at-bol) &#39;markdown-heading))</p>

<p>(defun markdown-end-of-subtree (&amp;optional invisible-OK)<br />
&nbsp; &quot;Move to the end of the current subtree.<br />
Only visible heading lines are considered, unless INVISIBLE-OK is<br />
non-nil.<br />
Derived from `org-end-of-subtree&#39;.&quot;<br />
&nbsp; (markdown-back-to-heading invisible-OK)<br />
&nbsp; (let ((first t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (level (markdown-outline-level)))<br />
&nbsp; &nbsp; (while (and (not (eobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (or first (&gt; (markdown-outline-level) level)))<br />
&nbsp; &nbsp; &nbsp; (setq first nil)<br />
&nbsp; &nbsp; &nbsp; (markdown-next-heading))<br />
&nbsp; &nbsp; (if (memq (preceding-char) &#39;(?\n ?\^M))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Go to end of line before heading<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-char -1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (memq (preceding-char) &#39;(?\n ?\^M))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; leave blank line before heading<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-char -1)))))<br />
&nbsp; (point))</p>

<p>(defun markdown-outline-fix-visibility ()<br />
&nbsp; &quot;Hide any false positive headings that should not be shown.<br />
For example, headings inside preformatted code blocks may match<br />
`outline-regexp&#39; but should not be shown as headings when cycling.<br />
Also, the ending --- line in metadata blocks appears to be a<br />
setext header, but should not be folded.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; ;; Unhide any false positives in metadata blocks<br />
&nbsp; &nbsp; (when (markdown-text-property-at-point &#39;markdown-yaml-metadata-begin)<br />
&nbsp; &nbsp; &nbsp; (let ((body (progn (forward-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-text-property-at-point<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-yaml-metadata-section))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when body<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((end (progn (goto-char (cl-second body))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-text-property-at-point<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;markdown-yaml-metadata-end))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (outline-flag-region (point-min) (1+ (cl-second end)) nil)))))<br />
&nbsp; &nbsp; ;; Hide any false positives in code blocks<br />
&nbsp; &nbsp; (unless (outline-on-heading-p)<br />
&nbsp; &nbsp; &nbsp; (outline-next-visible-heading 1))<br />
&nbsp; &nbsp; (while (&lt; (point) (point-max))<br />
&nbsp; &nbsp; &nbsp; (when (markdown-code-block-at-point-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (outline-flag-region (1- (point-at-bol)) (point-at-eol) t))<br />
&nbsp; &nbsp; &nbsp; (outline-next-visible-heading 1))))</p>

<p>(defvar markdown-cycle-global-status 1)<br />
(defvar markdown-cycle-subtree-status nil)</p>

<p>(defun markdown-next-preface ()<br />
&nbsp; (let (finish)<br />
&nbsp; &nbsp; (while (and (not finish) (re-search-forward (concat &quot;\n\\(?:&quot; outline-regexp &quot;\\)&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil &#39;move))<br />
&nbsp; &nbsp; &nbsp; (unless (markdown-code-block-at-point-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq finish t))))<br />
&nbsp; (when (and (bolp) (or outline-blank-line (eobp)) (not (bobp)))<br />
&nbsp; &nbsp; (forward-char -1)))</p>

<p>(defun markdown-show-entry ()<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (outline-back-to-heading t)<br />
&nbsp; &nbsp; (outline-flag-region (1- (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-next-preface)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(if (= 1 (- (point-max) (point)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(point-max)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(point)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;nil)))</p>

<p>;; This function was originally derived from `org-cycle&#39; from org.el.<br />
(defun markdown-cycle (&amp;optional arg)<br />
&nbsp; &quot;Visibility cycling for Markdown mode.<br />
If ARG is t, perform global visibility cycling. &nbsp;If the point is<br />
at an atx-style header, cycle visibility of the corresponding<br />
subtree. &nbsp;Otherwise, indent the current line or insert a tab,<br />
as appropriate, by calling `indent-for-tab-command&#39;.&quot;<br />
&nbsp; (interactive &quot;P&quot;)<br />
&nbsp; (cond<br />
&nbsp; &nbsp;((eq arg t) ;; Global cycling<br />
&nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp;((and (eq last-command this-command)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(eq markdown-cycle-global-status 2))<br />
&nbsp; &nbsp; &nbsp; ;; Move from overview to contents<br />
&nbsp; &nbsp; &nbsp; (markdown-hide-sublevels 1)<br />
&nbsp; &nbsp; &nbsp; (message &quot;CONTENTS&quot;)<br />
&nbsp; &nbsp; &nbsp; (setq markdown-cycle-global-status 3)<br />
&nbsp; &nbsp; &nbsp; (markdown-outline-fix-visibility))</p>

<p>&nbsp; &nbsp; &nbsp;((and (eq last-command this-command)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(eq markdown-cycle-global-status 3))<br />
&nbsp; &nbsp; &nbsp; ;; Move from contents to all<br />
&nbsp; &nbsp; &nbsp; (markdown-show-all)<br />
&nbsp; &nbsp; &nbsp; (message &quot;SHOW ALL&quot;)<br />
&nbsp; &nbsp; &nbsp; (setq markdown-cycle-global-status 1))</p>

<p>&nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; ;; Defaults to overview<br />
&nbsp; &nbsp; &nbsp; (markdown-hide-body)<br />
&nbsp; &nbsp; &nbsp; (message &quot;OVERVIEW&quot;)<br />
&nbsp; &nbsp; &nbsp; (setq markdown-cycle-global-status 2)<br />
&nbsp; &nbsp; &nbsp; (markdown-outline-fix-visibility))))</p>

<p>&nbsp; &nbsp;((save-excursion (beginning-of-line 1) (markdown-on-heading-p))<br />
&nbsp; &nbsp; ;; At a heading: rotate between three different views<br />
&nbsp; &nbsp; (markdown-back-to-heading)<br />
&nbsp; &nbsp; (let ((goal-column 0) eoh eol eos)<br />
&nbsp; &nbsp; &nbsp; ;; Determine boundaries<br />
&nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-back-to-heading)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (beginning-of-line 2)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (while (and (not (eobp)) ;; this is like `next-line&#39;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (get-char-property (1- (point)) &#39;invisible))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (beginning-of-line 2)) (setq eol (point)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-end-of-heading) &nbsp; (setq eoh (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-end-of-subtree t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (skip-chars-forward &quot; \t\n&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (beginning-of-line 1) ; in case this is an item<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq eos (1- (point))))<br />
&nbsp; &nbsp; &nbsp; ;; Find out what to do next and set `this-command&#39;<br />
&nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp;((= eos eoh)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Nothing is hidden behind this heading<br />
&nbsp; &nbsp; &nbsp; &nbsp; (message &quot;EMPTY ENTRY&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq markdown-cycle-subtree-status nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp;((&gt;= eol eos)<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Entire subtree is hidden in one line: open it<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-show-entry)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-show-children)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (message &quot;CHILDREN&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq markdown-cycle-subtree-status &#39;children))<br />
&nbsp; &nbsp; &nbsp; &nbsp;((and (eq last-command this-command)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(eq markdown-cycle-subtree-status &#39;children))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; We just showed the children, now show everything.<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-show-subtree)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (message &quot;SUBTREE&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq markdown-cycle-subtree-status &#39;subtree))<br />
&nbsp; &nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Default action: hide the subtree.<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-hide-subtree)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (message &quot;FOLDED&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq markdown-cycle-subtree-status &#39;folded)))))</p>

<p>&nbsp; &nbsp;(t<br />
&nbsp; &nbsp; (indent-for-tab-command))))</p>

<p>(defun markdown-shifttab ()<br />
&nbsp; &quot;Global visibility cycling.<br />
Calls `markdown-cycle&#39; with argument t.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (markdown-cycle t))</p>

<p>(defun markdown-outline-level ()<br />
&nbsp; &quot;Return the depth to which a statement is nested in the outline.&quot;<br />
&nbsp; (cond<br />
&nbsp; &nbsp;((and (match-beginning 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-code-block-at-pos (match-beginning 0)))<br />
&nbsp; &nbsp; 7) ;; Only 6 header levels are defined.<br />
&nbsp; &nbsp;((match-end 2) 1)<br />
&nbsp; &nbsp;((match-end 3) 2)<br />
&nbsp; &nbsp;((match-end 4)<br />
&nbsp; &nbsp; (length (markdown-trim-whitespace (match-string-no-properties 4))))))</p>

<p>(defun markdown-promote-subtree (&amp;optional arg)<br />
&nbsp; &quot;Promote the current subtree of ATX headings.<br />
Note that Markdown does not support heading levels higher than<br />
six and therefore level-six headings will not be promoted<br />
further. If ARG is non-nil promote the heading, otherwise<br />
demote.&quot;<br />
&nbsp; (interactive &quot;*P&quot;)<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (when (and (or (thing-at-point-looking-at markdown-regex-header-atx)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(re-search-backward markdown-regex-header-atx nil t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (markdown-code-block-at-point-p)))<br />
&nbsp; &nbsp; &nbsp; (let ((level (length (match-string 1)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (promote-or-demote (if arg 1 -1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (remove &#39;t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-cycle-atx promote-or-demote remove)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (catch &#39;end-of-subtree<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (while (and (markdown-next-heading)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (looking-at markdown-regex-header-atx))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Exit if this not a higher level heading; promote otherwise.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (and (looking-at markdown-regex-header-atx)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(&lt;= (length (match-string-no-properties 1)) level))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (throw &#39;end-of-subtree nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-cycle-atx promote-or-demote remove))))))))</p>

<p>(defun markdown-demote-subtree ()<br />
&nbsp; &quot;Demote the current subtree of ATX headings.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (markdown-promote-subtree t))</p>

<p>(defun markdown-move-subtree-up ()<br />
&nbsp; &quot;Move the current subtree of ATX headings up.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (outline-move-subtree-up 1))</p>

<p>(defun markdown-move-subtree-down ()<br />
&nbsp; &quot;Move the current subtree of ATX headings down.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (outline-move-subtree-down 1))</p>

<p>(defun markdown-outline-next ()<br />
&nbsp; &quot;Move to next list item, when in a list, or next visible heading.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((bounds (markdown-next-list-item-bounds)))<br />
&nbsp; &nbsp; (if bounds<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (nth 0 bounds))<br />
&nbsp; &nbsp; &nbsp; (markdown-next-visible-heading 1))))</p>

<p>(defun markdown-outline-previous ()<br />
&nbsp; &quot;Move to previous list item, when in a list, or previous visible heading.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((bounds (markdown-prev-list-item-bounds)))<br />
&nbsp; &nbsp; (if bounds<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (nth 0 bounds))<br />
&nbsp; &nbsp; &nbsp; (markdown-previous-visible-heading 1))))</p>

<p>(defun markdown-outline-next-same-level ()<br />
&nbsp; &quot;Move to next list item or heading of same level.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((bounds (markdown-cur-list-item-bounds)))<br />
&nbsp; &nbsp; (if bounds<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-next-list-item (nth 3 bounds))<br />
&nbsp; &nbsp; &nbsp; (markdown-forward-same-level 1))))</p>

<p>(defun markdown-outline-previous-same-level ()<br />
&nbsp; &quot;Move to previous list item or heading of same level.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((bounds (markdown-cur-list-item-bounds)))<br />
&nbsp; &nbsp; (if bounds<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-prev-list-item (nth 3 bounds))<br />
&nbsp; &nbsp; &nbsp; (markdown-backward-same-level 1))))</p>

<p>(defun markdown-outline-up ()<br />
&nbsp; &quot;Move to previous list item, when in a list, or next heading.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (unless (markdown-up-list)<br />
&nbsp; &nbsp; (markdown-up-heading 1)))</p>

<p><br />
;;; Marking and Narrowing =====================================================</p>

<p>(defun markdown-mark-paragraph ()<br />
&nbsp; &quot;Put mark at end of this block, point at beginning.<br />
The block marked is the one that contains point or follows point.</p>

<p>Interactively, if this command is repeated or (in Transient Mark<br />
mode) if the mark is active, it marks the next block after the<br />
ones already marked.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (if (or (and (eq last-command this-command) (mark t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (and transient-mark-mode mark-active))<br />
&nbsp; &nbsp; &nbsp; (set-mark<br />
&nbsp; &nbsp; &nbsp; &nbsp;(save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(goto-char (mark))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-forward-paragraph)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(point)))<br />
&nbsp; &nbsp; (let ((beginning-of-defun-function &#39;markdown-backward-paragraph)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (end-of-defun-function &#39;markdown-forward-paragraph))<br />
&nbsp; &nbsp; &nbsp; (mark-defun))))</p>

<p>(defun markdown-mark-block ()<br />
&nbsp; &quot;Put mark at end of this block, point at beginning.<br />
The block marked is the one that contains point or follows point.</p>

<p>Interactively, if this command is repeated or (in Transient Mark<br />
mode) if the mark is active, it marks the next block after the<br />
ones already marked.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (if (or (and (eq last-command this-command) (mark t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (and transient-mark-mode mark-active))<br />
&nbsp; &nbsp; &nbsp; (set-mark<br />
&nbsp; &nbsp; &nbsp; &nbsp;(save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(goto-char (mark))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-forward-block)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(point)))<br />
&nbsp; &nbsp; (let ((beginning-of-defun-function &#39;markdown-backward-block)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (end-of-defun-function &#39;markdown-forward-block))<br />
&nbsp; &nbsp; &nbsp; (mark-defun))))</p>

<p>(defun markdown-narrow-to-block ()<br />
&nbsp; &quot;Make text outside current block invisible.<br />
The current block is the one that contains point or follows point.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((beginning-of-defun-function &#39;markdown-backward-block)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (end-of-defun-function &#39;markdown-forward-block))<br />
&nbsp; &nbsp; (narrow-to-defun)))</p>

<p>(defun markdown-mark-text-block ()<br />
&nbsp; &quot;Put mark at end of this plain text block, point at beginning.<br />
The block marked is the one that contains point or follows point.</p>

<p>Interactively, if this command is repeated or (in Transient Mark<br />
mode) if the mark is active, it marks the next block after the<br />
ones already marked.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (if (or (and (eq last-command this-command) (mark t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (and transient-mark-mode mark-active))<br />
&nbsp; &nbsp; &nbsp; (set-mark<br />
&nbsp; &nbsp; &nbsp; &nbsp;(save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(goto-char (mark))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-end-of-text-block)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(point)))<br />
&nbsp; &nbsp; (let ((beginning-of-defun-function &#39;markdown-beginning-of-text-block)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (end-of-defun-function &#39;markdown-end-of-text-block))<br />
&nbsp; &nbsp; &nbsp; (mark-defun))))</p>

<p>(defun markdown-mark-page ()<br />
&nbsp; &quot;Put mark at end of this top level section, point at beginning.<br />
The top level section marked is the one that contains point or<br />
follows point.</p>

<p>Interactively, if this command is repeated or (in Transient Mark<br />
mode) if the mark is active, it marks the next page after the<br />
ones already marked.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (if (or (and (eq last-command this-command) (mark t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (and transient-mark-mode mark-active))<br />
&nbsp; &nbsp; &nbsp; (set-mark<br />
&nbsp; &nbsp; &nbsp; &nbsp;(save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(goto-char (mark))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-forward-page)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(point)))<br />
&nbsp; &nbsp; (let ((beginning-of-defun-function &#39;markdown-backward-page)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (end-of-defun-function &#39;markdown-forward-page))<br />
&nbsp; &nbsp; &nbsp; (mark-defun))))</p>

<p>(defun markdown-narrow-to-page ()<br />
&nbsp; &quot;Make text outside current top level section invisible.<br />
The current section is the one that contains point or follows point.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((beginning-of-defun-function &#39;markdown-backward-page)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (end-of-defun-function &#39;markdown-forward-page))<br />
&nbsp; &nbsp; (narrow-to-defun)))</p>

<p>(defun markdown-mark-subtree ()<br />
&nbsp; &quot;Mark the current subtree.<br />
This puts point at the start of the current subtree, and mark at the end.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((beg))<br />
&nbsp; &nbsp; (if (markdown-heading-at-point)<br />
&nbsp;&nbsp; &nbsp;(beginning-of-line)<br />
&nbsp; &nbsp; &nbsp; (markdown-previous-visible-heading 1))<br />
&nbsp; &nbsp; (setq beg (point))<br />
&nbsp; &nbsp; (markdown-end-of-subtree)<br />
&nbsp; &nbsp; (push-mark (point) nil t)<br />
&nbsp; &nbsp; (goto-char beg)))</p>

<p>(defun markdown-narrow-to-subtree ()<br />
&nbsp; &quot;Narrow buffer to the current subtree.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (save-match-data<br />
&nbsp; &nbsp; &nbsp; (narrow-to-region<br />
&nbsp; &nbsp; &nbsp; &nbsp;(progn (markdown-back-to-heading-over-code-block t) (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp;(progn (markdown-end-of-subtree)<br />
&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(if (and (markdown-heading-at-point) (not (eobp)))<br />
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;(backward-char 1))<br />
&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(point))))))</p>

<p><br />
;;; Generic Structure Editing, Completion, and Cycling Commands ===============</p>

<p>(defun markdown-move-up ()<br />
&nbsp; &quot;Move thing at point up.<br />
When in a list item, call `markdown-move-list-item-up&#39;.<br />
Otherwise, move the current heading subtree up with<br />
`markdown-move-subtree-up&#39;.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (cond<br />
&nbsp; &nbsp;((markdown-list-item-at-point-p)<br />
&nbsp; &nbsp; (markdown-move-list-item-up))<br />
&nbsp; &nbsp;(t<br />
&nbsp; &nbsp; (markdown-move-subtree-up))))</p>

<p>(defun markdown-move-down ()<br />
&nbsp; &quot;Move thing at point down.<br />
When in a list item, call `markdown-move-list-item-down&#39;.<br />
Otherwise, move the current heading subtree up with<br />
`markdown-move-subtree-down&#39;.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (cond<br />
&nbsp; &nbsp;((markdown-list-item-at-point-p)<br />
&nbsp; &nbsp; (markdown-move-list-item-down))<br />
&nbsp; &nbsp;(t<br />
&nbsp; &nbsp; (markdown-move-subtree-down))))</p>

<p>(defun markdown-promote ()<br />
&nbsp; &quot;Either promote header or list item at point or cycle markup.<br />
See `markdown-cycle-atx&#39;, `markdown-cycle-setext&#39;, and<br />
`markdown-promote-list-item&#39;.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let (bounds)<br />
&nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp;;; Promote atx heading subtree<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-header-atx)<br />
&nbsp; &nbsp; &nbsp; (markdown-promote-subtree))<br />
&nbsp; &nbsp; &nbsp;;; Promote setext heading<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-header-setext)<br />
&nbsp; &nbsp; &nbsp; (markdown-cycle-setext -1))<br />
&nbsp; &nbsp; &nbsp;;; Promote horizonal rule<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-hr)<br />
&nbsp; &nbsp; &nbsp; (markdown-cycle-hr -1))<br />
&nbsp; &nbsp; &nbsp;;; Promote list item<br />
&nbsp; &nbsp; &nbsp;((setq bounds (markdown-cur-list-item-bounds))<br />
&nbsp; &nbsp; &nbsp; (markdown-promote-list-item bounds))<br />
&nbsp; &nbsp; &nbsp;;; Promote bold<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-bold)<br />
&nbsp; &nbsp; &nbsp; (markdown-cycle-bold))<br />
&nbsp; &nbsp; &nbsp;;; Promote italic<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-italic)<br />
&nbsp; &nbsp; &nbsp; (markdown-cycle-italic))<br />
&nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; (user-error &quot;Nothing to promote at point&quot;)))))</p>

<p>(defun markdown-demote ()<br />
&nbsp; &quot;Either demote header or list item at point or cycle or remove markup.<br />
See `markdown-cycle-atx&#39;, `markdown-cycle-setext&#39;, and<br />
`markdown-demote-list-item&#39;.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let (bounds)<br />
&nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp;;; Demote atx heading subtree<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-header-atx)<br />
&nbsp; &nbsp; &nbsp; (markdown-demote-subtree))<br />
&nbsp; &nbsp; &nbsp;;; Demote setext heading<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-header-setext)<br />
&nbsp; &nbsp; &nbsp; (markdown-cycle-setext 1))<br />
&nbsp; &nbsp; &nbsp;;; Demote horizonal rule<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-hr)<br />
&nbsp; &nbsp; &nbsp; (markdown-cycle-hr 1))<br />
&nbsp; &nbsp; &nbsp;;; Demote list item<br />
&nbsp; &nbsp; &nbsp;((setq bounds (markdown-cur-list-item-bounds))<br />
&nbsp; &nbsp; &nbsp; (markdown-demote-list-item bounds))<br />
&nbsp; &nbsp; &nbsp;;; Demote bold<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-bold)<br />
&nbsp; &nbsp; &nbsp; (markdown-cycle-bold))<br />
&nbsp; &nbsp; &nbsp;;; Demote italic<br />
&nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-italic)<br />
&nbsp; &nbsp; &nbsp; (markdown-cycle-italic))<br />
&nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; (user-error &quot;Nothing to demote at point&quot;)))))</p>

<p><br />
;;; Commands ==================================================================</p>

<p>(defun markdown (&amp;optional output-buffer-name)<br />
&nbsp; &quot;Run `markdown-command&#39; on buffer, sending output to OUTPUT-BUFFER-NAME.<br />
The output buffer name defaults to `markdown-output-buffer-name&#39;.<br />
Return the name of the output buffer used.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (save-window-excursion<br />
&nbsp; &nbsp; (let ((begin-region)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (end-region))<br />
&nbsp; &nbsp; &nbsp; (if (markdown-use-region-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq begin-region (region-beginning)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; end-region (region-end))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq begin-region (point-min)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; end-region (point-max)))</p>

<p>&nbsp; &nbsp; &nbsp; (unless output-buffer-name<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq output-buffer-name markdown-output-buffer-name))<br />
&nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Handle case when `markdown-command&#39; does not read from stdin<br />
&nbsp; &nbsp; &nbsp; &nbsp;(markdown-command-needs-filename<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (not buffer-file-name)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (user-error &quot;Must be visiting a file&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (shell-command (concat markdown-command &quot; &quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(shell-quote-argument buffer-file-name))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;output-buffer-name)))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Pass region to `markdown-command&#39; via stdin<br />
&nbsp; &nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let ((buf (get-buffer-create output-buffer-name)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (with-current-buffer buf<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq buffer-read-only nil)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (erase-buffer))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (call-process-region begin-region end-region<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;shell-file-name nil buf nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;shell-command-switch markdown-command)))))<br />
&nbsp; &nbsp; output-buffer-name))</p>

<p>(defun markdown-standalone (&amp;optional output-buffer-name)<br />
&nbsp; &quot;Special function to provide standalone HTML output.<br />
Insert the output in the buffer named OUTPUT-BUFFER-NAME.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (setq output-buffer-name (markdown output-buffer-name))<br />
&nbsp; (with-current-buffer output-buffer-name<br />
&nbsp; &nbsp; (set-buffer output-buffer-name)<br />
&nbsp; &nbsp; (unless (markdown-output-standalone-p)<br />
&nbsp; &nbsp; &nbsp; (markdown-add-xhtml-header-and-footer output-buffer-name))<br />
&nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; (html-mode))<br />
&nbsp; output-buffer-name)</p>

<p>(defun markdown-other-window (&amp;optional output-buffer-name)<br />
&nbsp; &quot;Run `markdown-command&#39; on current buffer and display in other window.<br />
When OUTPUT-BUFFER-NAME is given, insert the output in the buffer with<br />
that name.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (markdown-display-buffer-other-window<br />
&nbsp; &nbsp;(markdown-standalone output-buffer-name)))</p>

<p>(defun markdown-output-standalone-p ()<br />
&nbsp; &quot;Determine whether `markdown-command&#39; output is standalone XHTML.<br />
Standalone XHTML output is identified by an occurrence of<br />
`markdown-xhtml-standalone-regexp&#39; in the first five lines of output.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; (save-match-data<br />
&nbsp; &nbsp; &nbsp; (re-search-forward<br />
&nbsp; &nbsp; &nbsp; &nbsp;markdown-xhtml-standalone-regexp<br />
&nbsp; &nbsp; &nbsp; &nbsp;(save-excursion (goto-char (point-min)) (forward-line 4) (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp;t))))</p>

<p>(defun markdown-stylesheet-link-string (stylesheet-path)<br />
&nbsp; (concat &quot;&lt;link rel=\&quot;stylesheet\&quot; type=\&quot;text/css\&quot; media=\&quot;all\&quot; href=\&quot;&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; stylesheet-path<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;\&quot; &nbsp;/&gt;&quot;))</p>

<p>(defun markdown-add-xhtml-header-and-footer (title)<br />
&nbsp; &quot;Wrap XHTML header and footer with given TITLE around current buffer.&quot;<br />
&nbsp; (goto-char (point-min))<br />
&nbsp; (insert &quot;&lt;?xml version=\&quot;1.0\&quot; encoding=\&quot;UTF-8\&quot; ?&gt;\n&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;&lt;!DOCTYPE html PUBLIC \&quot;-//W3C//DTD XHTML 1.0 Strict//EN\&quot;\n&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;\t\&quot;http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\&quot;&gt;\n\n&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;&lt;html xmlns=\&quot;http://www.w3.org/1999/xhtml\&quot;&gt;\n\n&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;&lt;head&gt;\n&lt;title&gt;&quot;)<br />
&nbsp; (insert title)<br />
&nbsp; (insert &quot;&lt;/title&gt;\n&quot;)<br />
&nbsp; (when (&gt; (length markdown-content-type) 0)<br />
&nbsp; &nbsp; (insert<br />
&nbsp; &nbsp; &nbsp;(format<br />
&nbsp; &nbsp; &nbsp; &quot;&lt;meta http-equiv=\&quot;Content-Type\&quot; content=\&quot;%s;charset=%s\&quot;/&gt;\n&quot;<br />
&nbsp; &nbsp; &nbsp; markdown-content-type<br />
&nbsp; &nbsp; &nbsp; (or (and markdown-coding-system<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(fboundp &#39;coding-system-get)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(coding-system-get markdown-coding-system<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;mime-charset))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (and (fboundp &#39;coding-system-get)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(coding-system-get buffer-file-coding-system<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;mime-charset))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;iso-8859-1&quot;))))<br />
&nbsp; (if (&gt; (length markdown-css-paths) 0)<br />
&nbsp; &nbsp; &nbsp; (insert (mapconcat #&#39;markdown-stylesheet-link-string<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-css-paths &quot;\n&quot;)))<br />
&nbsp; (when (&gt; (length markdown-xhtml-header-content) 0)<br />
&nbsp; &nbsp; (insert markdown-xhtml-header-content))<br />
&nbsp; (insert &quot;\n&lt;/head&gt;\n\n&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;&lt;body&gt;\n\n&quot;)<br />
&nbsp; (goto-char (point-max))<br />
&nbsp; (insert &quot;\n&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;&lt;/body&gt;\n&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;&lt;/html&gt;\n&quot;))</p>

<p>(defun markdown-preview (&amp;optional output-buffer-name)<br />
&nbsp; &quot;Run `markdown-command&#39; on the current buffer and view output in browser.<br />
When OUTPUT-BUFFER-NAME is given, insert the output in the buffer with<br />
that name.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (browse-url-of-buffer<br />
&nbsp; &nbsp;(markdown-standalone (or output-buffer-name markdown-output-buffer-name))))</p>

<p>(defun markdown-export-file-name (&amp;optional extension)<br />
&nbsp; &quot;Attempt to generate a filename for Markdown output.<br />
The file extension will be EXTENSION if given, or .html by default.<br />
If the current buffer is visiting a file, we construct a new<br />
output filename based on that filename. &nbsp;Otherwise, return nil.&quot;<br />
&nbsp; (when (buffer-file-name)<br />
&nbsp; &nbsp; (unless extension<br />
&nbsp; &nbsp; &nbsp; (setq extension &quot;.html&quot;))<br />
&nbsp; &nbsp; (let ((candidate<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(concat<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((buffer-file-name)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (file-name-sans-extension (buffer-file-name)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(t (buffer-name)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; extension)))<br />
&nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp;((equal candidate (buffer-file-name))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (concat candidate extension))<br />
&nbsp; &nbsp; &nbsp; &nbsp;(t<br />
&nbsp; &nbsp; &nbsp; &nbsp; candidate)))))</p>

<p>(defun markdown-export (&amp;optional output-file)<br />
&nbsp; &quot;Run Markdown on the current buffer, save to file, and return the filename.<br />
If OUTPUT-FILE is given, use that as the filename. &nbsp;Otherwise, use the filename<br />
generated by `markdown-export-file-name&#39;, which will be constructed using the<br />
current filename, but with the extension removed and replaced with .html.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (unless output-file<br />
&nbsp; &nbsp; (setq output-file (markdown-export-file-name &quot;.html&quot;)))<br />
&nbsp; (when output-file<br />
&nbsp; &nbsp; (let* ((init-buf (current-buffer))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(init-point (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(init-buf-string (buffer-string))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(output-buffer (find-file-noselect output-file))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(output-buffer-name (buffer-name output-buffer)))<br />
&nbsp; &nbsp; &nbsp; (run-hooks &#39;markdown-before-export-hook)<br />
&nbsp; &nbsp; &nbsp; (markdown-standalone output-buffer-name)<br />
&nbsp; &nbsp; &nbsp; (with-current-buffer output-buffer<br />
&nbsp; &nbsp; &nbsp; &nbsp; (run-hooks &#39;markdown-after-export-hook)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (save-buffer))<br />
&nbsp; &nbsp; &nbsp; ;; if modified, restore initial buffer<br />
&nbsp; &nbsp; &nbsp; (when (buffer-modified-p init-buf)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (erase-buffer)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (insert init-buf-string)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (save-buffer)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char init-point))<br />
&nbsp; &nbsp; &nbsp; output-file)))</p>

<p>(defun markdown-export-and-preview ()<br />
&nbsp; &quot;Export to XHTML using `markdown-export&#39; and browse the resulting file.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (browse-url-of-file (markdown-export)))</p>

<p>(defvar markdown-live-preview-buffer nil<br />
&nbsp; &quot;Buffer used to preview markdown output in `markdown-live-preview-export&#39;.&quot;)<br />
(make-variable-buffer-local &#39;markdown-live-preview-buffer)</p>

<p>(defvar markdown-live-preview-source-buffer nil<br />
&nbsp; &quot;Source buffer from which current buffer was generated.<br />
This is the inverse of `markdown-live-preview-buffer&#39;.&quot;)<br />
(make-variable-buffer-local &#39;markdown-live-preview-source-buffer)</p>

<p>(defvar markdown-live-preview-currently-exporting nil)</p>

<p>(defun markdown-live-preview-get-filename ()<br />
&nbsp; &quot;Standardize the filename exported by `markdown-live-preview-export&#39;.&quot;<br />
&nbsp; (markdown-export-file-name &quot;.html&quot;))</p>

<p>(defun markdown-live-preview-window-eww (file)<br />
&nbsp; &quot;Preview FILE with eww.<br />
To be used with `markdown-live-preview-window-function&#39;.&quot;<br />
&nbsp; (if (require &#39;eww nil t)<br />
&nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; (eww-open-file file)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (get-buffer &quot;*eww*&quot;))<br />
&nbsp; &nbsp; (error &quot;EWW is not present or not loaded on this version of Emacs&quot;)))</p>

<p>(defun markdown-visual-lines-between-points (beg end)<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char beg)<br />
&nbsp; &nbsp; (cl-loop with count = 0<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;while (progn (end-of-visual-line)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (and (&lt; (point) end) (line-move-visual 1 t)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;do (cl-incf count)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;finally return count)))</p>

<p>(defun markdown-live-preview-window-serialize (buf)<br />
&nbsp; &quot;Get window point and scroll data for all windows displaying BUF.&quot;<br />
&nbsp; (when (buffer-live-p buf)<br />
&nbsp; &nbsp; (with-current-buffer buf<br />
&nbsp; &nbsp; &nbsp; (mapcar<br />
&nbsp; &nbsp; &nbsp; &nbsp;(lambda (win)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(with-selected-window win<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(let* ((start (window-start))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (pt (window-point))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (pt-or-sym (cond ((= pt (point-min)) &#39;min)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((= pt (point-max)) &#39;max)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(t pt)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (diff (markdown-visual-lines-between-points<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;start pt)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(list win pt-or-sym diff))))<br />
&nbsp; &nbsp; &nbsp; &nbsp;(get-buffer-window-list buf)))))</p>

<p>(defun markdown-get-point-back-lines (pt num-lines)<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char pt)<br />
&nbsp; &nbsp; (line-move-visual (- num-lines) t)<br />
&nbsp; &nbsp; ;; in testing, can occasionally overshoot the number of lines to traverse<br />
&nbsp; &nbsp; (let ((actual-num-lines (markdown-visual-lines-between-points (point) pt)))<br />
&nbsp; &nbsp; &nbsp; (when (&gt; actual-num-lines num-lines)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (line-move-visual (- actual-num-lines num-lines) t)))<br />
&nbsp; &nbsp; (point)))</p>

<p>(defun markdown-live-preview-window-deserialize (window-posns)<br />
&nbsp; &quot;Apply window point and scroll data from WINDOW-POSNS.<br />
WINDOW-POSNS is provided by `markdown-live-preview-window-serialize&#39;.&quot;<br />
&nbsp; (cl-destructuring-bind (win pt-or-sym diff) window-posns<br />
&nbsp; &nbsp; (when (window-live-p win)<br />
&nbsp; &nbsp; &nbsp; (with-current-buffer markdown-live-preview-buffer<br />
&nbsp; &nbsp; &nbsp; &nbsp; (set-window-buffer win (current-buffer))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (cl-destructuring-bind (actual-pt actual-diff)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-case pt-or-sym<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (min (list (point-min) 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (max (list (point-max) diff))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (t &nbsp; (list pt-or-sym diff)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (set-window-start<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;win (markdown-get-point-back-lines actual-pt actual-diff))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (set-window-point win actual-pt))))))</p>

<p>(defun markdown-live-preview-export ()<br />
&nbsp; &quot;Export to XHTML using `markdown-export&#39;.<br />
Browse the resulting file within Emacs using<br />
`markdown-live-preview-window-function&#39; Return the buffer<br />
displaying the rendered output.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (let ((filename (markdown-live-preview-get-filename)))<br />
&nbsp; &nbsp; (when filename<br />
&nbsp; &nbsp; &nbsp; (let* ((markdown-live-preview-currently-exporting t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cur-buf (current-buffer))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(export-file (markdown-export filename))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; get positions in all windows currently displaying output buffer<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(window-data<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-live-preview-window-serialize<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-live-preview-buffer)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (save-window-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((output-buffer<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(funcall markdown-live-preview-window-function export-file)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (with-current-buffer output-buffer<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq markdown-live-preview-source-buffer cur-buf)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (add-hook &#39;kill-buffer-hook<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown-live-preview-remove-on-kill t t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (with-current-buffer cur-buf<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq markdown-live-preview-buffer output-buffer))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (with-current-buffer cur-buf<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; reset all windows displaying output buffer to where they were,<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; now with the new output<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (mapc #&#39;markdown-live-preview-window-deserialize window-data)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; delete html editing buffer<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((buf (get-file-buffer export-file))) (when buf (kill-buffer buf)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (and export-file (file-exists-p export-file)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(eq markdown-live-preview-delete-export<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;delete-on-export))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (delete-file export-file))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; markdown-live-preview-buffer)))))</p>

<p>(defun markdown-live-preview-remove ()<br />
&nbsp; (when (buffer-live-p markdown-live-preview-buffer)<br />
&nbsp; &nbsp; (kill-buffer markdown-live-preview-buffer))<br />
&nbsp; (setq markdown-live-preview-buffer nil)<br />
&nbsp; ;; if set to &#39;delete-on-export, the output has already been deleted<br />
&nbsp; (when (eq markdown-live-preview-delete-export &#39;delete-on-destroy)<br />
&nbsp; &nbsp; (let ((outfile-name (markdown-live-preview-get-filename)))<br />
&nbsp; &nbsp; &nbsp; (when (and outfile-name (file-exists-p outfile-name))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (delete-file outfile-name)))))</p>

<p>(defun markdown-get-other-window ()<br />
&nbsp; &quot;Find another window to display preview or output content.&quot;<br />
&nbsp; (cond<br />
&nbsp; &nbsp;((memq markdown-split-window-direction &#39;(vertical below))<br />
&nbsp; &nbsp; (or (window-in-direction &#39;below) (split-window-vertically)))<br />
&nbsp; &nbsp;((memq markdown-split-window-direction &#39;(horizontal right))<br />
&nbsp; &nbsp; (or (window-in-direction &#39;right) (split-window-horizontally)))<br />
&nbsp; &nbsp;(t (split-window-sensibly (get-buffer-window)))))</p>

<p>(defun markdown-display-buffer-other-window (buf)<br />
&nbsp; &quot;Display preview or output buffer BUF in another window.&quot;<br />
&nbsp; (let ((cur-buf (current-buffer))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (window (markdown-get-other-window)))<br />
&nbsp; &nbsp; (set-window-buffer window buf)<br />
&nbsp; &nbsp; (set-buffer cur-buf)))</p>

<p>(defun markdown-live-preview-if-markdown ()<br />
&nbsp; (when (and (derived-mode-p &#39;markdown-mode)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-live-preview-mode)<br />
&nbsp; &nbsp; (unless markdown-live-preview-currently-exporting<br />
&nbsp; &nbsp; &nbsp; (if (buffer-live-p markdown-live-preview-buffer)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-live-preview-export)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-display-buffer-other-window<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-live-preview-export))))))</p>

<p>(defun markdown-live-preview-remove-on-kill ()<br />
&nbsp; (cond ((and (derived-mode-p &#39;markdown-mode)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; markdown-live-preview-mode)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-live-preview-remove))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-live-preview-source-buffer<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(with-current-buffer markdown-live-preview-source-buffer<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(setq markdown-live-preview-buffer nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(setq markdown-live-preview-source-buffer nil))))</p>

<p>(defun markdown-live-preview-switch-to-output ()<br />
&nbsp; &quot;Switch to output buffer.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; &quot;Turn on `markdown-live-preview-mode&#39; if not already on, and switch to its<br />
output buffer in another window.&quot;<br />
&nbsp; (if markdown-live-preview-mode<br />
&nbsp; &nbsp; &nbsp; (markdown-display-buffer-other-window (markdown-live-preview-export)))<br />
&nbsp; &nbsp; (markdown-live-preview-mode))</p>

<p>(defun markdown-live-preview-re-export ()<br />
&nbsp; &quot;Re export source buffer.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; &quot;If the current buffer is a buffer displaying the exported version of a<br />
`markdown-live-preview-mode&#39; buffer, call `markdown-live-preview-export&#39; and<br />
update this buffer&#39;s contents.&quot;<br />
&nbsp; (when markdown-live-preview-source-buffer<br />
&nbsp; &nbsp; (with-current-buffer markdown-live-preview-source-buffer<br />
&nbsp; &nbsp; &nbsp; (markdown-live-preview-export))))</p>

<p>(defun markdown-open ()<br />
&nbsp; &quot;Open file for the current buffer with `markdown-open-command&#39;.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (if (not markdown-open-command)<br />
&nbsp; &nbsp; &nbsp; (user-error &quot;Variable `markdown-open-command&#39; must be set&quot;)<br />
&nbsp; &nbsp; (if (not buffer-file-name)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (user-error &quot;Must be visiting a file&quot;)<br />
&nbsp; &nbsp; &nbsp; (call-process markdown-open-command<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil nil nil buffer-file-name))))</p>

<p>(defun markdown-kill-ring-save ()<br />
&nbsp; &quot;Run Markdown on file and store output in the kill ring.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (save-window-excursion<br />
&nbsp; &nbsp; (markdown)<br />
&nbsp; &nbsp; (with-current-buffer markdown-output-buffer-name<br />
&nbsp; &nbsp; &nbsp; (kill-ring-save (point-min) (point-max)))))</p>

<p><br />
;;; Links =====================================================================</p>

<p>(defun markdown-link-p ()<br />
&nbsp; &quot;Return non-nil when `point&#39; is at a non-wiki link.<br />
See `markdown-wiki-link-p&#39; for more information.&quot;<br />
&nbsp; (let ((case-fold-search nil))<br />
&nbsp; &nbsp; (and (not (markdown-wiki-link-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (markdown-code-block-at-point-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(or (thing-at-point-looking-at markdown-regex-link-inline)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(thing-at-point-looking-at markdown-regex-link-reference)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(thing-at-point-looking-at markdown-regex-uri)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(thing-at-point-looking-at markdown-regex-angle-uri)))))</p>

<p>(make-obsolete &#39;markdown-link-link &#39;markdown-link-url &quot;v2.3&quot;)</p>

<p>(defun markdown-link-at-pos (pos)<br />
&nbsp; &quot;Return properties of link or image at position POS.<br />
Value is a list of elements describing the link:<br />
&nbsp;0. beginning position<br />
&nbsp;1. end position<br />
&nbsp;2. link text<br />
&nbsp;3. URL<br />
&nbsp;4. reference label<br />
&nbsp;5. title text<br />
&nbsp;6. bang (nil or \&quot;!\&quot;)&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char pos)<br />
&nbsp; &nbsp; (let (begin end text url reference title bang)<br />
&nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Inline or reference image or link at point.<br />
&nbsp; &nbsp; &nbsp; &nbsp;((or (thing-at-point-looking-at markdown-regex-link-inline)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (thing-at-point-looking-at markdown-regex-link-reference))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq bang (match-string-no-properties 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; begin (match-beginning 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; end (match-end 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; text (match-string-no-properties 3))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (char-equal (char-after (match-beginning 5)) ?\[)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Reference link<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq reference (match-string-no-properties 6))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Inline link<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq url (match-string-no-properties 6))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (match-end 7)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq title (substring (match-string-no-properties 7) 1 -1)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Angle bracket URI at point.<br />
&nbsp; &nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-angle-uri)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq begin (match-beginning 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; end (match-end 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; url (match-string-no-properties 2)))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Plain URI at point.<br />
&nbsp; &nbsp; &nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-uri)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq begin (match-beginning 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; end (match-end 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; url (match-string-no-properties 1))))<br />
&nbsp; &nbsp; &nbsp; (list begin end text url reference title bang))))</p>

<p>(defun markdown-link-url ()<br />
&nbsp; &quot;Return the URL part of the regular (non-wiki) link at point.<br />
Works with both inline and reference style links, and with images.<br />
If point is not at a link or the link reference is not defined<br />
returns nil.&quot;<br />
&nbsp; (let* ((values (markdown-link-at-pos (point)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(text (nth 2 values))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(url (nth 3 values))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(ref (nth 4 values)))<br />
&nbsp; &nbsp; (or url (and ref (car (markdown-reference-definition<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(downcase (if (string= ref &quot;&quot;) text ref))))))))</p>

<p>(defun markdown-follow-link-at-point ()<br />
&nbsp; &quot;Open the current non-wiki link.<br />
If the link is a complete URL, open in browser with `browse-url&#39;.<br />
Otherwise, open with `find-file&#39; after stripping anchor and/or query string.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (if (markdown-link-p)<br />
&nbsp; &nbsp; &nbsp; (let* ((url (markdown-link-url))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(struct (url-generic-parse-url url))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(full (url-fullness struct))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(file url))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Parse URL, determine fullness, strip query string<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (fboundp &#39;url-path-and-query)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq file (car (url-path-and-query struct)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (and (setq file (url-filename struct))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(string-match &quot;\\?&quot; file))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq file (substring file 0 (match-beginning 0)))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ;; Open full URLs in browser, files in Emacs<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if full<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (browse-url url)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (and file (&gt; (length file) 0)) (find-file file))))<br />
&nbsp; &nbsp; (user-error &quot;Point is not at a Markdown link or URL&quot;)))</p>

<p>(defun markdown-fontify-inline-links (last)<br />
&nbsp; &quot;Add text properties to next inline link from point to LAST.&quot;<br />
&nbsp; (when (markdown-match-generic-links last nil)<br />
&nbsp; &nbsp; (let* ((link-start (match-beginning 3))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(link-end (match-end 3))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(url-start (match-beginning 6))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(url-end (match-end 6))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(url (match-string-no-properties 6))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(title-start (match-beginning 7))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(title-end (match-end 7))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(title (match-string-no-properties 7))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Markup part<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(mp (list &#39;face &#39;markdown-markup-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;invisible &#39;markdown-markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;rear-nonsticky t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;font-lock-multiline t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Link part<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(lp (list &#39;keymap markdown-mode-mouse-map<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;face markdown-link-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;mouse-face &#39;markdown-highlight-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;font-lock-multiline t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;help-echo (if title (concat title &quot;\n&quot; url) url)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; URL part<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(up (list &#39;keymap markdown-mode-mouse-map<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;face &#39;markdown-url-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;invisible &#39;markdown-markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;mouse-face &#39;markdown-highlight-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;font-lock-multiline t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Title part<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(tp (list &#39;face &#39;markdown-link-title-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;invisible &#39;markdown-markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;font-lock-multiline t)))<br />
&nbsp; &nbsp; &nbsp; (dolist (g &#39;(1 2 4 5 8))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (match-end g)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (add-text-properties (match-beginning g) (match-end g) mp)))<br />
&nbsp; &nbsp; &nbsp; (when link-start (add-text-properties link-start link-end lp))<br />
&nbsp; &nbsp; &nbsp; (when url-start (add-text-properties url-start url-end up))<br />
&nbsp; &nbsp; &nbsp; (when title-start (add-text-properties url-end title-end tp))<br />
&nbsp; &nbsp; &nbsp; (when (and markdown-hide-urls url-start)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (compose-region url-start (or title-end url-end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; markdown-url-compose-char))<br />
&nbsp; &nbsp; &nbsp; t)))</p>

<p>(defun markdown-fontify-reference-links (last)<br />
&nbsp; &quot;Add text properties to next reference link from point to LAST.&quot;<br />
&nbsp; (when (markdown-match-generic-links last t)<br />
&nbsp; &nbsp; (let* ((link-start (match-beginning 3))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(link-end (match-end 3))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(ref-start (match-beginning 6))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(ref-end (match-end 6))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Markup part<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(mp (list &#39;face &#39;markdown-markup-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;invisible &#39;markdown-markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;rear-nonsticky t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;font-lock-multiline t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Link part<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(lp (list &#39;keymap markdown-mode-mouse-map<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;face markdown-link-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;mouse-face &#39;markdown-highlight-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;font-lock-multiline t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;help-echo (lambda (_ __ pos)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-match-data<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char pos)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (or (markdown-link-url)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;Undefined reference&quot;))))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Reference part<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(rp (list &#39;face &#39;markdown-reference-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;invisible &#39;markdown-markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;font-lock-multiline t)))<br />
&nbsp; &nbsp; &nbsp; (dolist (g &#39;(1 2 4 5 8))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when (match-end g)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (add-text-properties (match-beginning g) (match-end g) mp)))<br />
&nbsp; &nbsp; &nbsp; (when link-start (add-text-properties link-start link-end lp))<br />
&nbsp; &nbsp; &nbsp; (when ref-start (add-text-properties ref-start ref-end rp)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (and markdown-hide-urls (&gt; (- ref-end ref-start) 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (compose-region ref-start ref-end markdown-url-compose-char)))<br />
&nbsp; &nbsp; &nbsp; t)))</p>

<p>(defun markdown-fontify-angle-uris (last)<br />
&nbsp; &quot;Add text properties to angle URIs from point to LAST.&quot;<br />
&nbsp; (when (markdown-match-angle-uris last)<br />
&nbsp; &nbsp; (let* ((url-start (match-beginning 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(url-end (match-end 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Markup part<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(mp (list &#39;face &#39;markdown-markup-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;invisible &#39;markdown-markup<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;rear-nonsticky t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;font-lock-multiline t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; URI part<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(up (list &#39;keymap markdown-mode-mouse-map<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;face &#39;markdown-plain-url-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;mouse-face &#39;markdown-highlight-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;font-lock-multiline t)))<br />
&nbsp; &nbsp; &nbsp; (dolist (g &#39;(1 3))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (add-text-properties (match-beginning g) (match-end g) mp))<br />
&nbsp; &nbsp; &nbsp; (add-text-properties url-start url-end up)<br />
&nbsp; &nbsp; &nbsp; t)))</p>

<p>(defun markdown-fontify-plain-uris (last)<br />
&nbsp; &quot;Add text properties to plain URLs from point to LAST.&quot;<br />
&nbsp; (when (markdown-match-plain-uris last)<br />
&nbsp; &nbsp; (let* ((start (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(end (match-end 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(props (list &#39;keymap markdown-mode-mouse-map<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;face &#39;markdown-plain-url-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;mouse-face &#39;markdown-highlight-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;rear-nonsticky t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;font-lock-multiline t)))<br />
&nbsp; &nbsp; &nbsp; (add-text-properties start end props)<br />
&nbsp; &nbsp; &nbsp; t)))</p>

<p>(defun markdown-toggle-url-hiding (&amp;optional arg)<br />
&nbsp; &quot;Toggle the display or hiding of URLs.<br />
With a prefix argument ARG, enable URL hiding if ARG is positive,<br />
and disable it otherwise.&quot;<br />
&nbsp; (interactive (list (or current-prefix-arg &#39;toggle)))<br />
&nbsp; (setq markdown-hide-urls<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (eq arg &#39;toggle)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not markdown-hide-urls)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&gt; (prefix-numeric-value arg) 0)))<br />
&nbsp; (if markdown-hide-urls<br />
&nbsp; &nbsp; &nbsp; (message &quot;markdown-mode URL hiding enabled&quot;)<br />
&nbsp; &nbsp; (message &quot;markdown-mode URL hiding disabled&quot;))<br />
&nbsp; (markdown-reload-extensions))</p>

<p><br />
;;; WikiLink Following/Markup =================================================</p>

<p>(defun markdown-wiki-link-p ()<br />
&nbsp; &quot;Return non-nil if wiki links are enabled and `point&#39; is at a true wiki link.<br />
A true wiki link name matches `markdown-regex-wiki-link&#39; but does<br />
not match the current file name after conversion. &nbsp;This modifies<br />
the data returned by `match-data&#39;. &nbsp;Note that the potential wiki<br />
link name must be available via `match-string&#39;.&quot;<br />
&nbsp; (when markdown-enable-wiki-links<br />
&nbsp; &nbsp; (let ((case-fold-search nil))<br />
&nbsp; &nbsp; &nbsp; (and (thing-at-point-looking-at markdown-regex-wiki-link)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (markdown-code-block-at-point-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(or (not buffer-file-name)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (string-equal (buffer-file-name)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-convert-wiki-link-to-filename<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-wiki-link-link)))))))))</p>

<p>(defun markdown-wiki-link-link ()<br />
&nbsp; &quot;Return the link part of the wiki link using current match data.<br />
The location of the link component depends on the value of<br />
`markdown-wiki-link-alias-first&#39;.&quot;<br />
&nbsp; (if markdown-wiki-link-alias-first<br />
&nbsp; &nbsp; &nbsp; (or (match-string-no-properties 5) (match-string-no-properties 3))<br />
&nbsp; &nbsp; (match-string-no-properties 3)))</p>

<p>(defun markdown-wiki-link-alias ()<br />
&nbsp; &quot;Return the alias or text part of the wiki link using current match data.<br />
The location of the alias component depends on the value of<br />
`markdown-wiki-link-alias-first&#39;.&quot;<br />
&nbsp; (if markdown-wiki-link-alias-first<br />
&nbsp; &nbsp; &nbsp; (match-string-no-properties 3)<br />
&nbsp; &nbsp; (or (match-string-no-properties 5) (match-string-no-properties 3))))</p>

<p>(defun markdown-convert-wiki-link-to-filename (name)<br />
&nbsp; &quot;Generate a filename from the wiki link NAME.<br />
Spaces in NAME are replaced with `markdown-link-space-sub-char&#39;.<br />
When in `gfm-mode&#39;, follow GitHub&#39;s conventions where [[Test Test]]<br />
and [[test test]] both map to Test-test.ext. &nbsp;Look in the current<br />
directory first, then in subdirectories if<br />
`markdown-wiki-link-search-subdirectories&#39; is non-nil, and then<br />
in parent directories if<br />
`markdown-wiki-link-search-parent-directories&#39; is non-nil.&quot;<br />
&nbsp; (let* ((basename (markdown-replace-regexp-in-string<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;[[:space:]\n]&quot; markdown-link-space-sub-char name))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(basename (if (eq major-mode &#39;gfm-mode)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(concat (upcase (substring basename 0 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(downcase (substring basename 1 nil)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;basename))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;directory extension default candidates dir)<br />
&nbsp; &nbsp; (when buffer-file-name<br />
&nbsp; &nbsp; &nbsp; (setq directory (file-name-directory buffer-file-name)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; extension (file-name-extension buffer-file-name)))<br />
&nbsp; &nbsp; (setq default (concat basename<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when extension (concat &quot;.&quot; extension))))<br />
&nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp;;; Look in current directory first.<br />
&nbsp; &nbsp; &nbsp;((or (null buffer-file-name)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (file-exists-p default))<br />
&nbsp; &nbsp; &nbsp; default)<br />
&nbsp; &nbsp; &nbsp;;; Possibly search in subdirectories, next.<br />
&nbsp; &nbsp; &nbsp;((and markdown-wiki-link-search-subdirectories<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(setq candidates<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-directory-files-recursively<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; directory (concat &quot;^&quot; default &quot;$&quot;))))<br />
&nbsp; &nbsp; &nbsp; (car candidates))<br />
&nbsp; &nbsp; &nbsp;;; Possibly search in parent directories as a last resort.<br />
&nbsp; &nbsp; &nbsp;((and markdown-wiki-link-search-parent-directories<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(setq dir (locate-dominating-file directory default)))<br />
&nbsp; &nbsp; &nbsp; (concat dir default))<br />
&nbsp; &nbsp; &nbsp;;; If nothing is found, return default in current directory.<br />
&nbsp; &nbsp; &nbsp;(t default))))</p>

<p>(defun markdown-follow-wiki-link (name &amp;optional other)<br />
&nbsp; &quot;Follow the wiki link NAME.<br />
Convert the name to a file name and call `find-file&#39;. &nbsp;Ensure that<br />
the new buffer remains in `markdown-mode&#39;. &nbsp;Open the link in another<br />
window when OTHER is non-nil.&quot;<br />
&nbsp; (let ((filename (markdown-convert-wiki-link-to-filename name))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (wp (when buffer-file-name<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (file-name-directory buffer-file-name))))<br />
&nbsp; &nbsp; (if (not wp)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (user-error &quot;Must be visiting a file&quot;)<br />
&nbsp; &nbsp; &nbsp; (when other (other-window 1))<br />
&nbsp; &nbsp; &nbsp; (let ((default-directory wp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (find-file filename)))<br />
&nbsp; &nbsp; (when (not (eq major-mode &#39;markdown-mode))<br />
&nbsp; &nbsp; &nbsp; (markdown-mode))))</p>

<p>(defun markdown-follow-wiki-link-at-point (&amp;optional arg)<br />
&nbsp; &quot;Find Wiki Link at point.<br />
With prefix argument ARG, open the file in other window.<br />
See `markdown-wiki-link-p&#39; and `markdown-follow-wiki-link&#39;.&quot;<br />
&nbsp; (interactive &quot;P&quot;)<br />
&nbsp; (if (markdown-wiki-link-p)<br />
&nbsp; &nbsp; &nbsp; (markdown-follow-wiki-link (markdown-wiki-link-link) arg)<br />
&nbsp; &nbsp; (user-error &quot;Point is not at a Wiki Link&quot;)))</p>

<p>(defun markdown-highlight-wiki-link (from to face)<br />
&nbsp; &quot;Highlight the wiki link in the region between FROM and TO using FACE.&quot;<br />
&nbsp; (put-text-property from to &#39;font-lock-face face))</p>

<p>(defun markdown-unfontify-region-wiki-links (from to)<br />
&nbsp; &quot;Remove wiki link faces from the region specified by FROM and TO.&quot;<br />
&nbsp; (interactive &quot;*r&quot;)<br />
&nbsp; (let ((modified (buffer-modified-p)))<br />
&nbsp; &nbsp; (remove-text-properties from to &#39;(font-lock-face markdown-link-face))<br />
&nbsp; &nbsp; (remove-text-properties from to &#39;(font-lock-face markdown-missing-link-face))<br />
&nbsp; &nbsp; ;; remove-text-properties marks the buffer modified in emacs 24.3,<br />
&nbsp; &nbsp; ;; undo that if it wasn&#39;t originally marked modified<br />
&nbsp; &nbsp; (set-buffer-modified-p modified)))</p>

<p>(defun markdown-fontify-region-wiki-links (from to)<br />
&nbsp; &quot;Search region given by FROM and TO for wiki links and fontify them.<br />
If a wiki link is found check to see if the backing file exists<br />
and highlight accordingly.&quot;<br />
&nbsp; (goto-char from)<br />
&nbsp; (save-match-data<br />
&nbsp; &nbsp; (while (re-search-forward markdown-regex-wiki-link to t)<br />
&nbsp; &nbsp; &nbsp; (when (not (markdown-code-block-at-point-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let ((highlight-beginning (match-beginning 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (highlight-end (match-end 1))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (file-name<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-convert-wiki-link-to-filename<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-wiki-link-link))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (condition-case nil (file-exists-p file-name) (error nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-highlight-wiki-link<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;highlight-beginning highlight-end markdown-link-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-highlight-wiki-link<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;highlight-beginning highlight-end markdown-missing-link-face)))))))</p>

<p>(defun markdown-extend-changed-region (from to)<br />
&nbsp; &quot;Extend region given by FROM and TO so that we can fontify all links.<br />
The region is extended to the first newline before and the first<br />
newline after.&quot;<br />
&nbsp; ;; start looking for the first new line before &#39;from<br />
&nbsp; (goto-char from)<br />
&nbsp; (re-search-backward &quot;\n&quot; nil t)<br />
&nbsp; (let ((new-from (point-min))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (new-to (point-max)))<br />
&nbsp; &nbsp; (if (not (= (point) from))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq new-from (point)))<br />
&nbsp; &nbsp; ;; do the same thing for the first new line after &#39;to<br />
&nbsp; &nbsp; (goto-char to)<br />
&nbsp; &nbsp; (re-search-forward &quot;\n&quot; nil t)<br />
&nbsp; &nbsp; (if (not (= (point) to))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (setq new-to (point)))<br />
&nbsp; &nbsp; (cl-values new-from new-to)))</p>

<p>(defun markdown-check-change-for-wiki-link (from to)<br />
&nbsp; &quot;Check region between FROM and TO for wiki links and re-fontify as needed.&quot;<br />
&nbsp; (interactive &quot;*r&quot;)<br />
&nbsp; (let* ((modified (buffer-modified-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(buffer-undo-list t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(inhibit-read-only t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(inhibit-point-motion-hooks t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;deactivate-mark<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;buffer-file-truename)<br />
&nbsp; &nbsp; (unwind-protect<br />
&nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-match-data<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-restriction<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Extend the region to fontify so that it starts<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; and ends at safe places.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cl-multiple-value-bind (new-from new-to)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-extend-changed-region from to)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char new-from)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Only refontify when the range contains text with a<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; wiki link face or if the wiki link regexp matches.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (or (markdown-range-property-any<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;new-from new-to &#39;font-lock-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(list markdown-link-face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-missing-link-face))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (re-search-forward<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-regex-wiki-link new-to t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Unfontify existing fontification (start from scratch)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-unfontify-region-wiki-links new-from new-to)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Now do the fontification.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-fontify-region-wiki-links new-from new-to))))))<br />
&nbsp; &nbsp; &nbsp; (and (not modified)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(buffer-modified-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(set-buffer-modified-p nil)))))</p>

<p>(defun markdown-check-change-for-wiki-link-after-change (from to _)<br />
&nbsp; &nbsp; &quot;Check region between FROM and TO for wiki links and re-fontify as needed.<br />
Designed to be used with the `after-change-functions&#39; hook.&quot;<br />
&nbsp; (markdown-check-change-for-wiki-link from to))</p>

<p>(defun markdown-fontify-buffer-wiki-links ()<br />
&nbsp; &quot;Refontify all wiki links in the buffer.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (markdown-check-change-for-wiki-link (point-min) (point-max)))</p>

<p><br />
;;; Following &amp; Doing =========================================================</p>

<p>(defun markdown-follow-thing-at-point (arg)<br />
&nbsp; &quot;Follow thing at point if possible, such as a reference link or wiki link.<br />
Opens inline and reference links in a browser. &nbsp;Opens wiki links<br />
to other files in the current window, or the another window if<br />
ARG is non-nil.<br />
See `markdown-follow-link-at-point&#39; and<br />
`markdown-follow-wiki-link-at-point&#39;.&quot;<br />
&nbsp; (interactive &quot;P&quot;)<br />
&nbsp; (cond ((markdown-link-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-follow-link-at-point))<br />
&nbsp; &nbsp; &nbsp; &nbsp; ((markdown-wiki-link-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-follow-wiki-link-at-point arg))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (t<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(user-error &quot;Nothing to follow at point&quot;))))</p>

<p>(make-obsolete &#39;markdown-jump &#39;markdown-do &quot;v2.3&quot;)</p>

<p>(defun markdown-do ()<br />
&nbsp; &quot;Do something sensible based on context at point.<br />
Jumps between reference links and definitions; between footnote<br />
markers and footnote text.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (cond<br />
&nbsp; &nbsp;;; Footnote definition<br />
&nbsp; &nbsp;((markdown-footnote-text-positions)<br />
&nbsp; &nbsp; (markdown-footnote-return))<br />
&nbsp; &nbsp;;; Footnote marker<br />
&nbsp; &nbsp;((markdown-footnote-marker-positions)<br />
&nbsp; &nbsp; (markdown-footnote-goto-text))<br />
&nbsp; &nbsp;;; Reference link<br />
&nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-link-reference)<br />
&nbsp; &nbsp; (markdown-reference-goto-definition))<br />
&nbsp; &nbsp;;; Reference definition<br />
&nbsp; &nbsp;((thing-at-point-looking-at markdown-regex-reference-definition)<br />
&nbsp; &nbsp; (markdown-reference-goto-link (match-string-no-properties 2)))<br />
&nbsp; &nbsp;;; GFM task list item<br />
&nbsp; &nbsp;((markdown-gfm-task-list-item-at-point)<br />
&nbsp; &nbsp; (markdown-toggle-gfm-checkbox))<br />
&nbsp; &nbsp;;; Otherwise<br />
&nbsp; &nbsp;(t<br />
&nbsp; &nbsp; (user-error &quot;Nothing to do in context at point&quot;))))</p>

<p><br />
;;; Miscellaneous =============================================================</p>

<p>(defun markdown-compress-whitespace-string (str)<br />
&nbsp; &quot;Compress whitespace in STR and return result.<br />
Leading and trailing whitespace is removed. &nbsp;Sequences of multiple<br />
spaces, tabs, and newlines are replaced with single spaces.&quot;<br />
&nbsp; (markdown-replace-regexp-in-string &quot;\\(^[ \t\n]+\\|[ \t\n]+$\\)&quot; &quot;&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-replace-regexp-in-string &quot;[ \t\n]+&quot; &quot; &quot; str)))</p>

<p>(defun markdown--substitute-command-keys (string)<br />
&nbsp; &quot;Like `substitute-command-keys&#39; but, but prefers control characters.<br />
First pass STRING to `substitute-command-keys&#39; and then<br />
substitute `C-i` for `TAB` and `C-m` for `RET`.&quot;<br />
&nbsp; (replace-regexp-in-string<br />
&nbsp; &nbsp;&quot;\\&lt;TAB\\&gt;&quot; &quot;C-i&quot;<br />
&nbsp; &nbsp;(replace-regexp-in-string<br />
&nbsp; &nbsp; &quot;\\&lt;RET\\&gt;&quot; &quot;C-m&quot; (substitute-command-keys string) t) t))</p>

<p>(defun markdown-line-number-at-pos (&amp;optional pos)<br />
&nbsp; &quot;Return (narrowed) buffer line number at position POS.<br />
If POS is nil, use current buffer location.<br />
This is an exact copy of `line-number-at-pos&#39; for use in emacs21.&quot;<br />
&nbsp; (let ((opoint (or pos (point))) start)<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; &nbsp; (setq start (point))<br />
&nbsp; &nbsp; &nbsp; (goto-char opoint)<br />
&nbsp; &nbsp; &nbsp; (forward-line 0)<br />
&nbsp; &nbsp; &nbsp; (1+ (count-lines start (point))))))</p>

<p>(defun markdown-inside-link-p ()<br />
&nbsp; &quot;Return t if point is within a link.&quot;<br />
&nbsp; (save-match-data<br />
&nbsp; &nbsp; (thing-at-point-looking-at (markdown-make-regex-link-generic))))</p>

<p>(defun markdown-line-is-reference-definition-p ()<br />
&nbsp; &quot;Return whether the current line is a (non-footnote) reference defition.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (move-beginning-of-line 1)<br />
&nbsp; &nbsp; (and (looking-at-p markdown-regex-reference-definition)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (looking-at-p &quot;[ \t]*\\[^&quot;)))))</p>

<p>(defun markdown-adaptive-fill-function ()<br />
&nbsp; &quot;Return prefix for filling paragraph or nil if not determined.&quot;<br />
&nbsp; (cond<br />
&nbsp; &nbsp;;; List item inside blockquote<br />
&nbsp; &nbsp;((looking-at &quot;^[ \t]*&gt;[ \t]*\\(\\(?:[0-9]+\\|#\\)\\.\\|[*+:-]\\)[ \t]+&quot;)<br />
&nbsp; &nbsp; (markdown-replace-regexp-in-string<br />
&nbsp; &nbsp; &nbsp;&quot;[0-9\\.*+-]&quot; &quot; &quot; (match-string-no-properties 0)))<br />
&nbsp; &nbsp;;; Blockquote<br />
&nbsp; &nbsp;((looking-at markdown-regex-blockquote)<br />
&nbsp; &nbsp; (buffer-substring-no-properties (match-beginning 0) (match-end 2)))<br />
&nbsp; &nbsp;;; List items<br />
&nbsp; &nbsp;((looking-at markdown-regex-list)<br />
&nbsp; &nbsp; (match-string-no-properties 0))<br />
&nbsp; &nbsp;;; Footnote definition<br />
&nbsp; &nbsp;((looking-at-p markdown-regex-footnote-definition)<br />
&nbsp; &nbsp; &quot; &nbsp; &nbsp;&quot;) ; four spaces<br />
&nbsp; &nbsp;;; No match<br />
&nbsp; &nbsp;(t nil)))</p>

<p>(defun markdown-fill-paragraph (&amp;optional justify)<br />
&nbsp; &quot;Fill paragraph at or after point.<br />
This function is like \\[fill-paragraph], but it skips Markdown<br />
code blocks. &nbsp;If the point is in a code block, or just before one,<br />
do not fill. &nbsp;Otherwise, call `fill-paragraph&#39; as usual. If<br />
JUSTIFY is non-nil, justify text as well. &nbsp;Since this function<br />
handles filling itself, it always returns t so that<br />
`fill-paragraph&#39; doesn&#39;t run.&quot;<br />
&nbsp; (interactive &quot;P&quot;)<br />
&nbsp; (unless (or (markdown-code-block-at-point-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (back-to-indentation)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (skip-syntax-forward &quot;-&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-code-block-at-point-p)))<br />
&nbsp; &nbsp; (fill-paragraph justify))<br />
&nbsp; t)</p>

<p>(make-obsolete &#39;markdown-fill-forward-paragraph-function<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;markdown-fill-forward-paragraph &quot;v2.3&quot;)</p>

<p>(defun markdown-fill-forward-paragraph (&amp;optional arg)<br />
&nbsp; &quot;Function used by `fill-paragraph&#39; to move over ARG paragraphs.<br />
This is a `fill-forward-paragraph-function&#39; for `markdown-mode&#39;.<br />
It is called with a single argument specifying the number of<br />
paragraphs to move. &nbsp;Just like `forward-paragraph&#39;, it should<br />
return the number of paragraphs left to move.&quot;<br />
&nbsp; (or arg (setq arg 1))<br />
&nbsp; (if (&gt; arg 0)<br />
&nbsp; &nbsp; &nbsp; ;; With positive ARG, move across ARG non-code-block paragraphs,<br />
&nbsp; &nbsp; &nbsp; ;; one at a time. &nbsp;When passing a code block, don&#39;t decrement ARG.<br />
&nbsp; &nbsp; &nbsp; (while (and (not (eobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&gt; arg 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (= (forward-paragraph 1) 0)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (or (markdown-code-block-at-pos (point-at-bol 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq arg (1- arg)))))<br />
&nbsp; &nbsp; ;; Move backward by one paragraph with negative ARG (always -1).<br />
&nbsp; &nbsp; (let ((start (point)))<br />
&nbsp; &nbsp; &nbsp; (setq arg (forward-paragraph arg))<br />
&nbsp; &nbsp; &nbsp; (while (and (not (eobp))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (progn (move-to-left-margin) (not (eobp)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (looking-at-p paragraph-separate))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (forward-line 1))<br />
&nbsp; &nbsp; &nbsp; (cond<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Move point past whitespace following list marker.<br />
&nbsp; &nbsp; &nbsp; &nbsp;((looking-at markdown-regex-list)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-end 0)))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Move point past whitespace following pipe at beginning of line<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; to handle Pandoc line blocks.<br />
&nbsp; &nbsp; &nbsp; &nbsp;((looking-at &quot;^|\\s-*&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char (match-end 0)))<br />
&nbsp; &nbsp; &nbsp; &nbsp;;; Return point if the paragraph passed was a code block.<br />
&nbsp; &nbsp; &nbsp; &nbsp;((markdown-code-block-at-pos (point-at-bol 2))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (goto-char start)))))<br />
&nbsp; arg)</p>

<p>(defun markdown--inhibit-electric-quote ()<br />
&nbsp; &quot;Function added to `electric-quote-inhibit-functions&#39;.<br />
Return non-nil if the quote has been inserted inside a code block<br />
or span.&quot;<br />
&nbsp; (let ((pos (1- (point))))<br />
&nbsp; &nbsp; (or (markdown-inline-code-at-pos pos)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-code-block-at-pos pos))))</p>

<p><br />
;;; Extension Framework =======================================================</p>

<p>(defun markdown-reload-extensions ()<br />
&nbsp; &quot;Check settings, update font-lock keywords and hooks, and re-fontify buffer.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (when (member major-mode &#39;(markdown-mode gfm-mode))<br />
&nbsp; &nbsp; ;; Update font lock keywords with extensions<br />
&nbsp; &nbsp; (setq markdown-mode-font-lock-keywords<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (append<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-mode-font-lock-keywords-math)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-mode-font-lock-keywords-basic<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-mode-font-lock-keywords-wiki-links)))<br />
&nbsp; &nbsp; ;; Update font lock defaults<br />
&nbsp; &nbsp; (setq font-lock-defaults<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;(markdown-mode-font-lock-keywords<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil nil nil nil<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (font-lock-syntactic-face-function . markdown-syntactic-face)))<br />
&nbsp; &nbsp; ;; Refontify buffer<br />
&nbsp; &nbsp; (when (and font-lock-mode (fboundp &#39;font-lock-refresh-defaults))<br />
&nbsp; &nbsp; &nbsp; (font-lock-refresh-defaults))</p>

<p>&nbsp; &nbsp; ;; Add or remove hooks related to extensions<br />
&nbsp; &nbsp; (markdown-setup-wiki-link-hooks)))</p>

<p>(defun markdown-handle-local-variables ()<br />
&nbsp; &quot;Run in `hack-local-variables-hook&#39; to update font lock rules.<br />
Checks to see if there is actually a &acirc;&euro;&tilde;markdown-mode&acirc;&euro;&trade; file local variable<br />
before regenerating font-lock rules for extensions.&quot;<br />
&nbsp; (when (and (boundp &#39;file-local-variables-alist)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(assoc &#39;markdown-enable-wiki-links file-local-variables-alist)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(assoc &#39;markdown-enable-math file-local-variables-alist))<br />
&nbsp; &nbsp; (markdown-reload-extensions)))</p>

<p><br />
;;; Wiki Links ================================================================</p>

<p>(defun markdown-toggle-wiki-links (&amp;optional arg)<br />
&nbsp; &quot;Toggle support for wiki links.<br />
With a prefix argument ARG, enable wiki link support if ARG is positive,<br />
and disable it otherwise.&quot;<br />
&nbsp; (interactive (list (or current-prefix-arg &#39;toggle)))<br />
&nbsp; (setq markdown-enable-wiki-links<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (eq arg &#39;toggle)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not markdown-enable-wiki-links)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&gt; (prefix-numeric-value arg) 0)))<br />
&nbsp; (if markdown-enable-wiki-links<br />
&nbsp; &nbsp; &nbsp; (message &quot;markdown-mode wiki link support enabled&quot;)<br />
&nbsp; &nbsp; (message &quot;markdown-mode wiki link support disabled&quot;))<br />
&nbsp; (markdown-reload-extensions))</p>

<p>(defun markdown-setup-wiki-link-hooks ()<br />
&nbsp; &quot;Add or remove hooks for fontifying wiki links.<br />
These are only enabled when `markdown-wiki-link-fontify-missing&#39; is non-nil.&quot;<br />
&nbsp; ;; Anytime text changes make sure it gets fontified correctly<br />
&nbsp; (if (and markdown-enable-wiki-links<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-wiki-link-fontify-missing)<br />
&nbsp; &nbsp; &nbsp; (add-hook &#39;after-change-functions<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-check-change-for-wiki-link-after-change t t)<br />
&nbsp; &nbsp; (remove-hook &#39;after-change-functions<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;markdown-check-change-for-wiki-link-after-change t))<br />
&nbsp; ;; If we left the buffer there is a really good chance we were<br />
&nbsp; ;; creating one of the wiki link documents. Make sure we get<br />
&nbsp; ;; refontified when we come back.<br />
&nbsp; (if (and markdown-enable-wiki-links<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-wiki-link-fontify-missing)<br />
&nbsp; &nbsp; &nbsp; (progn<br />
&nbsp; &nbsp; &nbsp; &nbsp; (add-hook &#39;window-configuration-change-hook<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;markdown-fontify-buffer-wiki-links t t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-fontify-buffer-wiki-links))<br />
&nbsp; &nbsp; (remove-hook &#39;window-configuration-change-hook<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;markdown-fontify-buffer-wiki-links t)<br />
&nbsp; (markdown-unfontify-region-wiki-links (point-min) (point-max))))</p>

<p>(defun markdown-mode-font-lock-keywords-wiki-links ()<br />
&nbsp; &quot;Return wiki-link lock keywords if support is enabled.<br />
If `markdown-wiki-link-fontify-missing&#39; is also enabled, we use<br />
hooks in `markdown-setup-wiki-link-hooks&#39; for fontification instead.&quot;<br />
&nbsp; (when (and markdown-enable-wiki-links<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not markdown-wiki-link-fontify-missing))<br />
&nbsp; &nbsp; (list<br />
&nbsp; &nbsp; &nbsp;(cons markdown-regex-wiki-link &#39;((1 markdown-link-face prepend))))))</p>

<p><br />
;;; Math Support ==============================================================</p>

<p>(make-obsolete &#39;markdown-enable-math &#39;markdown-toggle-math &quot;v2.1&quot;)</p>

<p>(defun markdown-toggle-math (&amp;optional arg)<br />
&nbsp; &quot;Toggle support for inline and display LaTeX math expressions.<br />
With a prefix argument ARG, enable math mode if ARG is positive,<br />
and disable it otherwise. &nbsp;If called from Lisp, enable the mode<br />
if ARG is omitted or nil.&quot;<br />
&nbsp; (interactive (list (or current-prefix-arg &#39;toggle)))<br />
&nbsp; (setq markdown-enable-math<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (eq arg &#39;toggle)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not markdown-enable-math)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&gt; (prefix-numeric-value arg) 0)))<br />
&nbsp; (if markdown-enable-math<br />
&nbsp; &nbsp; &nbsp; (message &quot;markdown-mode math support enabled&quot;)<br />
&nbsp; &nbsp; (message &quot;markdown-mode math support disabled&quot;))<br />
&nbsp; (markdown-reload-extensions))</p>

<p>(defun markdown-mode-font-lock-keywords-math ()<br />
&nbsp; &quot;Return math font lock keywords if support is enabled.&quot;<br />
&nbsp; (when markdown-enable-math<br />
&nbsp; &nbsp; (list<br />
&nbsp; &nbsp; &nbsp;;; Display mode equations with brackets: \[ \]<br />
&nbsp; &nbsp; &nbsp;(cons markdown-regex-math-display &#39;((1 markdown-markup-face prepend)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(2 markdown-math-face append)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(3 markdown-markup-face prepend)))<br />
&nbsp; &nbsp; &nbsp;;; Equation reference (eq:foo)<br />
&nbsp; &nbsp; &nbsp;(cons &quot;\\((eq:\\)\\([[:alnum:]:_]+\\)\\()\\)&quot; &#39;((1 markdown-markup-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(2 markdown-reference-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(3 markdown-markup-face)))<br />
&nbsp; &nbsp; &nbsp;;; Equation reference \eqref{foo}<br />
&nbsp; &nbsp; &nbsp;(cons &quot;\\(\\\\eqref{\\)\\([[:alnum:]:_]+\\)\\(}\\)&quot; &#39;((1 markdown-markup-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(2 markdown-reference-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(3 markdown-markup-face))))))</p>

<p><br />
;;; GFM Checkboxes ============================================================</p>

<p>(define-button-type &#39;markdown-gfm-checkbox-button<br />
&nbsp; &#39;follow-link t<br />
&nbsp; &#39;face &#39;markdown-gfm-checkbox-face<br />
&nbsp; &#39;mouse-face &#39;markdown-highlight-face<br />
&nbsp; &#39;action #&#39;markdown-toggle-gfm-checkbox-button)</p>

<p>(defun markdown-gfm-task-list-item-at-point (&amp;optional bounds)<br />
&nbsp; &quot;Return non-nil if there is a GFM task list item at the point.<br />
Optionally, the list item BOUNDS may be given if available, as<br />
returned by `markdown-cur-list-item-bounds&#39;. &nbsp;When a task list item<br />
is found, the return value is the same value returned by<br />
`markdown-cur-list-item-bounds&#39;.&quot;<br />
&nbsp; (unless bounds<br />
&nbsp; &nbsp; (setq bounds (markdown-cur-list-item-bounds)))<br />
&nbsp; (&gt; (length (nth 5 bounds)) 0))</p>

<p>(defun markdown-toggle-gfm-checkbox ()<br />
&nbsp; &quot;Toggle GFM checkbox at point.<br />
Returns the resulting status as a string, either \&quot;[x]\&quot; or \&quot;[ ]\&quot;.<br />
Returns nil if there is no task list item at the point.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (save-match-data<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (let ((bounds (markdown-cur-list-item-bounds)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (when bounds<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Move to beginning of task list item<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (goto-char (cl-first bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Advance to column of first non-whitespace after marker<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (forward-char (cl-fourth bounds))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cond ((looking-at &quot;\\[ \\]&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(replace-match<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if markdown-gfm-uppercase-checkbox &quot;[X]&quot; &quot;[x]&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-string-no-properties 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((looking-at &quot;\\[[xX]\\]&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(replace-match &quot;[ ]&quot; nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(match-string-no-properties 0))))))))</p>

<p>(defun markdown-toggle-gfm-checkbox-button (button)<br />
&nbsp; &quot;Toggle GFM checkbox BUTTON on click.&quot;<br />
&nbsp; (save-match-data<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (goto-char (button-start button))<br />
&nbsp; &nbsp; &nbsp; (markdown-toggle-gfm-checkbox))))</p>

<p>(defun markdown-make-gfm-checkboxes-buttons (start end)<br />
&nbsp; &quot;Make GFM checkboxes buttons in region between START and END.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (goto-char start)<br />
&nbsp; &nbsp; (let ((case-fold-search t))<br />
&nbsp; &nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; &nbsp; (while (re-search-forward markdown-regex-gfm-checkbox end t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (make-button (match-beginning 1) (match-end 1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;:type &#39;markdown-gfm-checkbox-button))))))</p>

<p>;; Called when any modification is made to buffer text.<br />
(defun markdown-gfm-checkbox-after-change-function (beg end _)<br />
&nbsp; &quot;Add to `after-change-functions&#39; to setup GFM checkboxes as buttons.<br />
BEG and END are the limits of scanned region.&quot;<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (save-match-data<br />
&nbsp; &nbsp; &nbsp; ;; Rescan between start of line from `beg&#39; and start of line after `end&#39;.<br />
&nbsp; &nbsp; &nbsp; (markdown-make-gfm-checkboxes-buttons<br />
&nbsp; &nbsp; &nbsp; &nbsp;(progn (goto-char beg) (beginning-of-line) (point))<br />
&nbsp; &nbsp; &nbsp; &nbsp;(progn (goto-char end) (forward-line 1) (point))))))</p>

<p><br />
;;; Display inline image =================================================</p>

<p>(defvar markdown-inline-image-overlays nil)<br />
(make-variable-buffer-local &#39;markdown-inline-image-overlays)</p>

<p>(defun markdown-remove-inline-images ()<br />
&nbsp; &quot;Remove inline image overlays from image links in the buffer.<br />
This can be toggled with `markdown-toggle-inline-images&#39;<br />
or \\[markdown-toggle-inline-images].&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (mapc #&#39;delete-overlay markdown-inline-image-overlays)<br />
&nbsp; (setq markdown-inline-image-overlays nil))</p>

<p>(defun markdown-display-inline-images ()<br />
&nbsp; &quot;Add inline image overlays to image links in the buffer.<br />
This can be toggled with `markdown-toggle-inline-images&#39;<br />
or \\[markdown-toggle-inline-images].&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (unless (display-graphic-p)<br />
&nbsp; &nbsp; (error &quot;Cannot show images&quot;))<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (save-restriction<br />
&nbsp; &nbsp; &nbsp; (widen)<br />
&nbsp; &nbsp; &nbsp; (goto-char (point-min))<br />
&nbsp; &nbsp; &nbsp; (while (re-search-forward markdown-regex-link-inline nil t)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let ((start (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (end (match-end 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (file (match-string-no-properties 6)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when (file-exists-p file)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let* ((abspath (if (file-name-absolute-p file)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; file<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (concat default-directory file)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(image (create-image abspath)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when image<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((ov (make-overlay start end)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (overlay-put ov &#39;display image)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (overlay-put ov &#39;face &#39;default)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (push ov markdown-inline-image-overlays))))))))))</p>

<p>(defun markdown-toggle-inline-images ()<br />
&nbsp; &quot;Toggle inline image overlays in the buffer.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (if markdown-inline-image-overlays<br />
&nbsp; &nbsp; &nbsp; (markdown-remove-inline-images)<br />
&nbsp; &nbsp; (markdown-display-inline-images)))</p>

<p><br />
;;; GFM Code Block Fontification ==============================================</p>

<p>(defcustom markdown-fontify-code-blocks-natively nil<br />
&nbsp; &quot;When non-nil, fontify code in code blocks using the native major mode.<br />
This only works for fenced code blocks where the language is<br />
specified where we can automatically determine the appropriate<br />
mode to use. &nbsp;The language to mode mapping may be customized by<br />
setting the variable `markdown-code-lang-modes&#39;.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;boolean<br />
&nbsp; :safe &#39;booleanp<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.3&quot;))</p>

<p>(defun markdown-toggle-fontify-code-blocks-natively (&amp;optional arg)<br />
&nbsp; &quot;Toggle the native fontification of code blocks.<br />
With a prefix argument ARG, enable if ARG is positive,<br />
and disable otherwise.&quot;<br />
&nbsp; (interactive (list (or current-prefix-arg &#39;toggle)))<br />
&nbsp; (setq markdown-fontify-code-blocks-natively<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if (eq arg &#39;toggle)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (not markdown-fontify-code-blocks-natively)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&gt; (prefix-numeric-value arg) 0)))<br />
&nbsp; (if markdown-fontify-code-blocks-natively<br />
&nbsp; &nbsp; &nbsp; (message &quot;markdown-mode native code block fontification enabled&quot;)<br />
&nbsp; &nbsp; (message &quot;markdown-mode native code block fontification disabled&quot;))<br />
&nbsp; (markdown-reload-extensions))</p>

<p>;; This is based on `org-src-lang-modes&#39; from org-src.el<br />
(defcustom markdown-code-lang-modes<br />
&nbsp; &#39;((&quot;ocaml&quot; . tuareg-mode) (&quot;elisp&quot; . emacs-lisp-mode) (&quot;ditaa&quot; . artist-mode)<br />
&nbsp; &nbsp; (&quot;asymptote&quot; . asy-mode) (&quot;dot&quot; . fundamental-mode) (&quot;sqlite&quot; . sql-mode)<br />
&nbsp; &nbsp; (&quot;calc&quot; . fundamental-mode) (&quot;C&quot; . c-mode) (&quot;cpp&quot; . c++-mode)<br />
&nbsp; &nbsp; (&quot;C++&quot; . c++-mode) (&quot;screen&quot; . shell-script-mode) (&quot;shell&quot; . sh-mode)<br />
&nbsp; &nbsp; (&quot;bash&quot; . sh-mode))<br />
&nbsp; &quot;Alist mapping languages to their major mode.<br />
The key is the language name, the value is the major mode. &nbsp;For<br />
many languages this is simple, but for language where this is not<br />
the case, this variable provides a way to simplify things on the<br />
user side. &nbsp;For example, there is no ocaml-mode in Emacs, but the<br />
mode to use is `tuareg-mode&#39;.&quot;<br />
&nbsp; :group &#39;markdown<br />
&nbsp; :type &#39;(repeat<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (cons<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(string &quot;Language name&quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(symbol &quot;Major mode&quot;)))<br />
&nbsp; :package-version &#39;(markdown-mode . &quot;2.3&quot;))</p>

<p>(defun markdown-get-lang-mode (lang)<br />
&nbsp; &quot;Return major mode that should be used for LANG.<br />
LANG is a string, and the returned major mode is a symbol.&quot;<br />
&nbsp; (cl-find-if<br />
&nbsp; &nbsp;&#39;fboundp<br />
&nbsp; &nbsp;(list (cdr (assoc lang markdown-code-lang-modes))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(cdr (assoc (downcase lang) markdown-code-lang-modes))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(intern (concat lang &quot;-mode&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(intern (concat (downcase lang) &quot;-mode&quot;)))))</p>

<p>(defun markdown-fontify-code-blocks-generic (matcher last)<br />
&nbsp; &quot;Add text properties to next code block from point to LAST.<br />
Use matching function MATCHER.&quot;<br />
&nbsp; (when (funcall matcher last)<br />
&nbsp; &nbsp; (save-excursion<br />
&nbsp; &nbsp; &nbsp; (save-match-data<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let* ((start (match-beginning 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(end (match-end 0))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; Find positions outside opening and closing backquotes.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(bol-prev (progn (goto-char start)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (bolp) (point-at-bol 0) (point-at-bol))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(eol-next (progn (goto-char end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (bolp) (point-at-bol 2) (point-at-bol 3))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lang)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (and markdown-fontify-code-blocks-natively<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(setq lang (markdown-code-block-lang)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-fontify-code-block-natively lang start end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (add-text-properties start end &#39;(face markdown-pre-face)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Set background for block as well as opening and closing lines.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (font-lock-append-text-property<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bol-prev eol-next &#39;face &#39;markdown-code-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Set invisible property for lines before and after, including newline.<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (add-text-properties bol-prev start &#39;(invisible markdown-markup))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (add-text-properties end eol-next &#39;(invisible markdown-markup)))))<br />
&nbsp; &nbsp; t))</p>

<p>(defun markdown-fontify-gfm-code-blocks (last)<br />
&nbsp; &quot;Add text properties to next GFM code block from point to LAST.&quot;<br />
&nbsp; (markdown-fontify-code-blocks-generic &#39;markdown-match-gfm-code-blocks last))</p>

<p>(defun markdown-fontify-fenced-code-blocks (last)<br />
&nbsp; &quot;Add text properties to next tilde fenced code block from point to LAST.&quot;<br />
&nbsp; (markdown-fontify-code-blocks-generic &#39;markdown-match-fenced-code-blocks last))</p>

<p>;; Based on `org-src-font-lock-fontify-block&#39; from org-src.el.<br />
(defun markdown-fontify-code-block-natively (lang start end)<br />
&nbsp; &quot;Fontify given GFM or fenced code block.<br />
This function is called by Emacs for automatic fontification when<br />
`markdown-fontify-code-blocks-natively&#39; is non-nil. &nbsp;LANG is the<br />
language used in the block. START and END specify the block<br />
position.&quot;<br />
&nbsp; (let ((lang-mode (markdown-get-lang-mode lang)))<br />
&nbsp; &nbsp; (when (fboundp lang-mode)<br />
&nbsp; &nbsp; &nbsp; (let ((string (buffer-substring-no-properties start end))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (modified (buffer-modified-p))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-buffer (current-buffer)) pos next)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (remove-text-properties start end &#39;(face nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (with-current-buffer<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (get-buffer-create<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(concat &quot; markdown-code-fontification:&quot; (symbol-name lang-mode)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Make sure that modification hooks are not inhibited in<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; the org-src-fontification buffer in case we&#39;re called<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; from `jit-lock-function&#39; (Bug#25132).<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((inhibit-modification-hooks nil))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (delete-region (point-min) (point-max))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (insert string &quot; &quot;)) ;; so there&#39;s a final property change<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unless (eq major-mode lang-mode) (funcall lang-mode))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-font-lock-ensure)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq pos (point-min))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (while (setq next (next-single-property-change pos &#39;face))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let ((val (get-text-property pos &#39;face)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (when val<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (put-text-property<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(+ start (1- pos)) (1- (+ start next)) &#39;face<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;val markdown-buffer)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (setq pos next)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (add-text-properties<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;start end<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;(font-lock-fontified t fontified t font-lock-multiline t))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (set-buffer-modified-p modified)))))</p>

<p>(require &#39;edit-indirect nil t)<br />
(defvar edit-indirect-guess-mode-function)<br />
(defvar edit-indirect-after-commit-functions)</p>

<p>(defun markdown--edit-indirect-after-commit-function (_beg end)<br />
&nbsp; &quot;Ensure trailing newlines at the END of code blocks.&quot;<br />
&nbsp; (goto-char end)<br />
&nbsp; (unless (eq (char-before) ?\n)<br />
&nbsp; &nbsp; (insert &quot;\n&quot;)))</p>

<p>(defun markdown-edit-code-block ()<br />
&nbsp; &quot;Edit Markdown code block in an indirect buffer.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (save-excursion<br />
&nbsp; &nbsp; (if (fboundp &#39;edit-indirect-region)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (let* ((bounds (markdown-get-enclosing-fenced-block-construct))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(begin (and bounds (goto-char (nth 0 bounds)) (point-at-bol 2)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(end (and bounds (goto-char (nth 1 bounds)) (point-at-bol 1))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if (and begin end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (let* ((lang (markdown-code-block-lang))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(mode (and lang (markdown-get-lang-mode lang)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(edit-indirect-guess-mode-function<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (lambda (_parent-buffer _beg _end)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (funcall mode))))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (edit-indirect-region begin end &#39;display-buffer))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (user-error &quot;Not inside a GFM or tilde fenced code block&quot;)))<br />
&nbsp; &nbsp; &nbsp; (when (y-or-n-p &quot;Package edit-indirect needed to edit code blocks. Install it now? &quot;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (progn (package-refresh-contents)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(package-install &#39;edit-indirect)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(markdown-edit-code-block))))))</p>

<p><br />
;;; ElDoc Support</p>

<p>(defun markdown-eldoc-function ()<br />
&nbsp; &quot;Return a helpful string when appropriate based on context.<br />
* Report URL when point is at a hidden URL.<br />
* Report language name when point is a code block with hidden markup.&quot;<br />
&nbsp; (cond<br />
&nbsp; &nbsp;;; Hidden URL or reference for inline link<br />
&nbsp; &nbsp;((and (or (thing-at-point-looking-at markdown-regex-link-inline)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(thing-at-point-looking-at markdown-regex-link-reference))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(or markdown-hide-urls markdown-hide-markup))<br />
&nbsp; &nbsp; (let* ((imagep (string-equal (match-string 1) &quot;!&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(edit-keys (markdown--substitute-command-keys<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(if imagep<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;\\[markdown-insert-image]&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;\\[markdown-insert-link]&quot;)))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(edit-str (propertize edit-keys &#39;face &#39;font-lock-constant-face))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(referencep (string-equal (match-string 5) &quot;[&quot;))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(object (if referencep &quot;reference&quot; &quot;URL&quot;)))<br />
&nbsp; &nbsp; &nbsp; (format &quot;Hidden %s (%s to edit): %s&quot; object edit-str<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (if referencep<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (concat<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(propertize &quot;[&quot; &#39;face &#39;markdown-markup-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(propertize (match-string-no-properties 6)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;face &#39;markdown-reference-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(propertize &quot;]&quot; &#39;face &#39;markdown-markup-face))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (propertize (match-string-no-properties 6)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;face &#39;markdown-url-face)))))<br />
&nbsp; &nbsp;;; Hidden language name for fenced code blocks<br />
&nbsp; &nbsp;((and (markdown-code-block-at-point-p)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(not (get-text-property (point) &#39;markdown-pre))<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;markdown-hide-markup)<br />
&nbsp; &nbsp; (let ((lang (save-excursion (markdown-code-block-lang))))<br />
&nbsp; &nbsp; &nbsp; (unless lang (setq lang &quot;[unspecified]&quot;))<br />
&nbsp; &nbsp; &nbsp; (format &quot;Hidden code block language: %s (%s to toggle markup)&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (propertize lang &#39;face &#39;markdown-language-keyword-face)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown--substitute-command-keys<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;\\[markdown-toggle-markup-hiding]&quot;))))))</p>

<p><br />
;;; Mode Definition &nbsp;==========================================================</p>

<p>(defun markdown-show-version ()<br />
&nbsp; &quot;Show the version number in the minibuffer.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (message &quot;markdown-mode, version %s&quot; markdown-mode-version))</p>

<p>(defun markdown-mode-info ()<br />
&nbsp; &quot;Open the `markdown-mode&#39; homepage.&quot;<br />
&nbsp; (interactive)<br />
&nbsp; (browse-url &quot;https://jblevins.org/projects/markdown-mode/&quot;))</p>

<p>;;;###autoload<br />
(define-derived-mode markdown-mode text-mode &quot;Markdown&quot;<br />
&nbsp; &quot;Major mode for editing Markdown files.&quot;<br />
&nbsp; ;; Natural Markdown tab width<br />
&nbsp; (setq tab-width 4)<br />
&nbsp; ;; Comments<br />
&nbsp; (setq-local comment-start &quot;&lt;!-- &quot;)<br />
&nbsp; (setq-local comment-end &quot; --&gt;&quot;)<br />
&nbsp; (setq-local comment-start-skip &quot;&lt;!--[ \t]*&quot;)<br />
&nbsp; (setq-local comment-column 0)<br />
&nbsp; (setq-local comment-auto-fill-only-comments nil)<br />
&nbsp; (setq-local comment-use-syntax t)<br />
&nbsp; ;; Syntax<br />
&nbsp; (add-hook &#39;syntax-propertize-extend-region-functions<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown-syntax-propertize-extend-region)<br />
&nbsp; (add-hook &#39;jit-lock-after-change-extend-region-functions<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown-font-lock-extend-region-function t t)<br />
&nbsp; (setq-local syntax-propertize-function #&#39;markdown-syntax-propertize)<br />
&nbsp; ;; Font lock.<br />
&nbsp; (setq-local markdown-mode-font-lock-keywords nil)<br />
&nbsp; (setq-local font-lock-defaults nil)<br />
&nbsp; (setq-local font-lock-multiline t)<br />
&nbsp; (setq-local font-lock-extra-managed-props<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (append font-lock-extra-managed-props<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#39;(composition display invisible)))<br />
&nbsp; (if markdown-hide-markup<br />
&nbsp; &nbsp; &nbsp; (add-to-invisibility-spec &#39;markdown-markup)<br />
&nbsp; &nbsp; (remove-from-invisibility-spec &#39;markdown-markup))<br />
&nbsp; ;; Reload extensions<br />
&nbsp; (markdown-reload-extensions)<br />
&nbsp; ;; Add a buffer-local hook to reload after file-local variables are read<br />
&nbsp; (add-hook &#39;hack-local-variables-hook #&#39;markdown-handle-local-variables nil t)<br />
&nbsp; ;; For imenu support<br />
&nbsp; (setq imenu-create-index-function<br />
&nbsp; &nbsp; &nbsp; &nbsp; (if markdown-nested-imenu-heading-index<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown-imenu-create-nested-index<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown-imenu-create-flat-index))<br />
&nbsp; ;; For menu support in XEmacs<br />
&nbsp; (easy-menu-add markdown-mode-menu markdown-mode-map)<br />
&nbsp; ;; Defun movement<br />
&nbsp; (setq-local beginning-of-defun-function #&#39;markdown-beginning-of-defun)<br />
&nbsp; (setq-local end-of-defun-function #&#39;markdown-end-of-defun)<br />
&nbsp; ;; Paragraph filling<br />
&nbsp; (setq-local fill-paragraph-function #&#39;markdown-fill-paragraph)<br />
&nbsp; (setq-local paragraph-start<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Should match start of lines that start or separate paragraphs<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (mapconcat #&#39;identity<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;(<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;\f&quot; ; starts with a literal line-feed<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;[ \t\f]*$&quot; ; space-only line<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;\\(?:[ \t]*&gt;\\)+[ \t\f]*$&quot;; empty line in blockquote<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;[ \t]*[*+-][ \t]+&quot; ; unordered list item<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;[ \t]*\\(?:[0-9]+\\|#\\)\\.[ \t]+&quot; ; ordered list item<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;[ \t]*\\[\\S-*\\]:[ \t]+&quot; ; link ref def<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;[ \t]*:[ \t]+&quot; ; definition<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;^|&quot; ; table or Pandoc line block<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;\\|&quot;))<br />
&nbsp; (setq-local paragraph-separate<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; Should match lines that separate paragraphs without being<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;; part of any paragraph:<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (mapconcat #&#39;identity<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&#39;(&quot;[ \t\f]*$&quot; ; space-only line<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;\\(?:[ \t]*&gt;\\)+[ \t\f]*$&quot;; empty line in blockquote<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; The following is not ideal, but the Fill customization<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; options really only handle paragraph-starting prefixes,<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;; not paragraph-ending suffixes:<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;.* &nbsp;$&quot; ; line ending in two spaces<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;^#+&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;[ \t]*\\[\\^\\S-*\\]:[ \t]*$&quot;) ; just the start of a footnote def<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;\\|&quot;))<br />
&nbsp; (setq-local adaptive-fill-first-line-regexp &quot;\\`[ \t]*[A-Z]?&gt;[ \t]*?\\&#39;&quot;)<br />
&nbsp; (setq-local adaptive-fill-regexp &quot;\\s-*&quot;)<br />
&nbsp; (setq-local adaptive-fill-function #&#39;markdown-adaptive-fill-function)<br />
&nbsp; (setq-local fill-forward-paragraph-function #&#39;markdown-fill-forward-paragraph)<br />
&nbsp; ;; Outline mode<br />
&nbsp; (setq-local outline-regexp markdown-regex-header)<br />
&nbsp; (setq-local outline-level #&#39;markdown-outline-level)<br />
&nbsp; ;; Cause use of ellipses for invisible text.<br />
&nbsp; (add-to-invisibility-spec &#39;(outline . t))<br />
&nbsp; ;; ElDoc support<br />
&nbsp; (if (eval-when-compile (fboundp &#39;add-function))<br />
&nbsp; &nbsp; &nbsp; (add-function :before-until (local &#39;eldoc-documentation-function)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown-eldoc-function)<br />
&nbsp; &nbsp; (setq-local eldoc-documentation-function #&#39;markdown-eldoc-function))<br />
&nbsp; ;; Inhibiting line-breaking:<br />
&nbsp; ;; Separating out each condition into a separate function so that users can<br />
&nbsp; ;; override if desired (with remove-hook)<br />
&nbsp; (add-hook &#39;fill-nobreak-predicate<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown-line-is-reference-definition-p nil t)<br />
&nbsp; (add-hook &#39;fill-nobreak-predicate<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown-pipe-at-bol-p nil t)</p>

<p>&nbsp; ;; Indentation<br />
&nbsp; (setq-local indent-line-function markdown-indent-function)</p>

<p>&nbsp; ;; Flyspell<br />
&nbsp; (setq-local flyspell-generic-check-word-predicate<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown-flyspell-check-word-p)</p>

<p>&nbsp; ;; Electric quoting<br />
&nbsp; (add-hook &#39;electric-quote-inhibit-functions<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown--inhibit-electric-quote nil :local)</p>

<p>&nbsp; ;; Backwards compatibility with markdown-css-path<br />
&nbsp; (when (boundp &#39;markdown-css-path)<br />
&nbsp; &nbsp; (warn &quot;markdown-css-path is deprecated, see markdown-css-paths.&quot;)<br />
&nbsp; &nbsp; (add-to-list &#39;markdown-css-paths markdown-css-path))</p>

<p>&nbsp; ;; Prepare hooks for XEmacs compatibility<br />
&nbsp; (when (featurep &#39;xemacs)<br />
&nbsp; &nbsp; (make-local-hook &#39;after-change-functions)<br />
&nbsp; &nbsp; (make-local-hook &#39;font-lock-extend-region-functions)<br />
&nbsp; &nbsp; (make-local-hook &#39;window-configuration-change-hook))</p>

<p>&nbsp; ;; Make checkboxes buttons<br />
&nbsp; (when markdown-make-gfm-checkboxes-buttons<br />
&nbsp; &nbsp; (markdown-make-gfm-checkboxes-buttons (point-min) (point-max))<br />
&nbsp; &nbsp; (add-hook &#39;after-change-functions #&#39;markdown-gfm-checkbox-after-change-function t t))</p>

<p>&nbsp; ;; edit-indirect<br />
&nbsp; (add-hook &#39;edit-indirect-after-commit-functions<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #&#39;markdown--edit-indirect-after-commit-function<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; nil &#39;local)</p>

<p>&nbsp; ;; add live preview export hook<br />
&nbsp; (add-hook &#39;after-save-hook #&#39;markdown-live-preview-if-markdown t t)<br />
&nbsp; (add-hook &#39;kill-buffer-hook #&#39;markdown-live-preview-remove-on-kill t t))</p>

<p>;;;###autoload<br />
(add-to-list &#39;auto-mode-alist &#39;(&quot;\\.markdown\\&#39;&quot; . markdown-mode) t)<br />
;;;###autoload<br />
(add-to-list &#39;auto-mode-alist &#39;(&quot;\\.md\\&#39;&quot; . markdown-mode) t)</p>

<p><br />
;;; GitHub Flavored Markdown Mode &nbsp;============================================</p>

<p>(defvar gfm-mode-hook nil<br />
&nbsp; &quot;Hook run when entering GFM mode.&quot;)</p>

<p>(defvar gfm-font-lock-keywords<br />
&nbsp; ;; Basic Markdown features (excluding possibly overridden ones)<br />
&nbsp; markdown-mode-font-lock-keywords-basic<br />
&nbsp; &quot;Default highlighting expressions for GitHub Flavored Markdown mode.&quot;)</p>

<p>;;;###autoload<br />
(define-derived-mode gfm-mode markdown-mode &quot;GFM&quot;<br />
&nbsp; &quot;Major mode for editing GitHub Flavored Markdown files.&quot;<br />
&nbsp; (setq markdown-link-space-sub-char &quot;-&quot;)<br />
&nbsp; (setq markdown-wiki-link-search-subdirectories t)<br />
&nbsp; (setq-local font-lock-defaults &#39;(gfm-font-lock-keywords))<br />
&nbsp; ;; do the initial link fontification<br />
&nbsp; (markdown-gfm-parse-buffer-for-languages))</p>

<p><br />
;;; Live Preview Mode &nbsp;============================================<br />
(define-minor-mode markdown-live-preview-mode<br />
&nbsp; &quot;Toggle native previewing on save for a specific markdown file.&quot;<br />
&nbsp; :lighter &quot; MD-Preview&quot;<br />
&nbsp; (if markdown-live-preview-mode<br />
&nbsp; &nbsp; &nbsp; (if (markdown-live-preview-get-filename)<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (markdown-display-buffer-other-window (markdown-live-preview-export))<br />
&nbsp; &nbsp; &nbsp; &nbsp; (markdown-live-preview-mode -1)<br />
&nbsp; &nbsp; &nbsp; &nbsp; (user-error &quot;Buffer %s does not visit a file&quot; (current-buffer)))<br />
&nbsp; &nbsp; (markdown-live-preview-remove)))</p>

<p><br />
(provide &#39;markdown-mode)</p>

<p>;; Local Variables:<br />
;; indent-tabs-mode: nil<br />
;; coding: utf-8<br />
;; End:<br />
;;; markdown-mode.el ends here</p>
