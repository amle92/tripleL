{\rtf1\ansi\deff0\adeflang1025
{\fonttbl{\f0\froman\fprq2\fcharset0 Times New Roman;}{\f1\froman\fprq2\fcharset2 Symbol;}{\f2\fswiss\fprq2\fcharset0 Arial;}{\f3\fnil\fprq2\fcharset0 Mangal;}{\f4\fnil\fprq0\fcharset128 Mangal;}{\f5\froman\fprq0\fcharset128 ;}{\f6\fnil\fprq2\fcharset0 Microsoft YaHei;}}
{\colortbl;\red0\green0\blue0;\red128\green128\blue128;}
{\stylesheet{\s0\snext0{\*\hyphen2\hyphlead2\hyphtrail2\hyphmax0}\nowidctlpar\cf0\kerning1\hich\af3\langfe2052\dbch\af5\afs24\lang1081\loch\f0\fs24\lang1033 Default;}
{\s15\sbasedon0\snext16{\*\hyphen2\hyphlead2\hyphtrail2\hyphmax0}\sb240\sa120\keepn\cf0\kerning1\hich\af3\langfe2052\dbch\af6\loch\f2\fs28\lang1033 Heading;}
{\s16\sbasedon0\snext16{\*\hyphen2\hyphlead2\hyphtrail2\hyphmax0}\sb0\sa120\cf0\kerning1\hich\af0\langfe2052\dbch\af0\loch\f0\fs24\lang1033 Text body;}
{\s17\sbasedon16\snext17{\*\hyphen2\hyphlead2\hyphtrail2\hyphmax0}\sb0\sa120\cf0\kerning1\hich\af4\langfe2052\dbch\af0\loch\f0\fs24\lang1033 List;}
{\s18\sbasedon0\snext18{\*\hyphen2\hyphlead2\hyphtrail2\hyphmax0}\sb120\sa120\cf0\i\kerning1\hich\af4\langfe2052\dbch\af0\ai\loch\f0\fs24\lang1033 Caption;}
{\s19\sbasedon0\snext19{\*\hyphen2\hyphlead2\hyphtrail2\hyphmax0}\cf0\kerning1\hich\af4\langfe2052\dbch\af0\loch\f0\fs24\lang1033 Index;}
}{\info{\creatim\yr0\mo0\dy0\hr0\min0}{\revtim\yr0\mo0\dy0\hr0\min0}{\printim\yr0\mo0\dy0\hr0\min0}{\comment OpenOffice.org}{\vern3410}}\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709\deftab709

{\*\pgdsctbl
{\pgdsc0\pgdscuse195\pgwsxn12240\pghsxn15840\marglsxn1134\margrsxn1134\margtsxn1134\margbsxn1134\pgdscnxt0 Default;}}
\formshade{\*\pgdscno0}\paperh15840\paperw12240\margl1134\margr1134\margt1134\margb1134\sectd\sbknone\sectunlocked1\pgndec\pgwsxn12240\pghsxn15840\marglsxn1134\margrsxn1134\margtsxn1134\margbsxn1134\ftnbj\ftnstart1\ftnrstcont\ftnnar\aenddoc\aftnrstcont\aftnstart1\aftnnrlc
\pgndec\pard\plain \s0{\*\hyphen2\hyphlead2\hyphtrail2\hyphmax0}\nowidctlpar\cf0\kerning1\hich\af3\langfe2052\dbch\af5\afs24\lang1081\loch\f0\fs24\lang1033{\rtlch \ltrch\loch
import java.awt.*;\line import javax.swing.*;\line import java.awt.event.*;\line \line public class MenuFrame\line \{\line \tab public static void main(String[]args)\line \tab \{\line \tab \tab final JFrame styleFrame = new JFrame();\line \tab \tab \line \tab \tab final JTextField tableText = new JTextField();\line \tab \tab tableText.setText("TableNameHere");}
\par \pard\plain \s0{\*\hyphen2\hyphlead2\hyphtrail2\hyphmax0}\nowidctlpar\cf0\kerning1\hich\af3\langfe2052\dbch\af5\afs24\lang1081\loch\f0\fs24\lang1033{\rtlch \ltrch\loch
\tab \tab final JTextField queryText = new JtextField();}
\par \pard\plain \s0{\*\hyphen2\hyphlead2\hyphtrail2\hyphmax0}\nowidctlpar\cf0\kerning1\hich\af3\langfe2052\dbch\af5\afs24\lang1081\loch\f0\fs24\lang1033{\rtlch \ltrch\loch
\tab \tab queryText.setText(\'93QueryNameHere\'94);}
\par \pard\plain \s0{\*\hyphen2\hyphlead2\hyphtrail2\hyphmax0}\nowidctlpar\cf0\kerning1\hich\af3\langfe2052\dbch\af5\afs24\lang1081\loch\f0\fs24\lang1033{\rtlch \ltrch\loch
\line \tab \tab final JButton insertButton = new JButton("Insert");\line \tab \tab final JButton selectButton = new JButton("Select");}
\par \pard\plain \s0{\*\hyphen2\hyphlead2\hyphtrail2\hyphmax0}\nowidctlpar\cf0\kerning1\hich\af3\langfe2052\dbch\af5\afs24\lang1081\loch\f0\fs24\lang1033{\rtlch \ltrch\loch
\tab \tab final JButton deleteButton = new JButton("Delete");\line \tab \tab \line \tab \tab final JPanel panel = new JPanel();\line \tab \tab panel.add(insertButton);\line \tab \tab panel.add(selectButton);\line \tab \tab panel.add(deleteButton);\line \tab \tab \line \tab \tab insertButton.addActionListener(new ActionListener()\line \tab \tab \{\line \tab \tab \tab @Override\line \tab \tab \tab public void actionPerformed(ActionEvent e)\line \tab \tab \tab \{\line \tab \tab \tab \tab \line \tab \tab \tab \}\line \tab \tab \});\line \tab \tab \line \tab \tab selectButton.addActionListener(new ActionListener()\line \tab \tab \{\line \line \tab \tab \tab @Override\line \tab \tab \tab public void actionPerformed(ActionEvent e)\line \tab \tab \tab \{\line \tab \tab \tab \tab \line \tab \tab \tab \}\line \tab \tab \tab \line \tab \tab \});\line \tab \tab \line \tab \tab deleteButton.addActionListener(new ActionListener()\line \tab \tab \{\line \tab \tab \tab @Override\line \tab \tab \tab public void actionPerformed(ActionEvent arg0)\line \tab \tab \tab \{\line \line \tab \tab \});\line \tab \tab \line \tab \tab myFrame.add(tableText, BorderLayout.NORTH);\line \tab \tab myFrame.add(queryText, BorderLayout.NORTH);}
\par \pard\plain \s0{\*\hyphen2\hyphlead2\hyphtrail2\hyphmax0}\nowidctlpar\cf0\kerning1\hich\af3\langfe2052\dbch\af5\afs24\lang1081\loch\f0\fs24\lang1033{\rtlch \ltrch\loch
\tab \tab myFrame.add(panel, BorderLayout.CENTER);\line \tab \tab \line \tab \tab myFrame.pack();\line \tab \tab myFrame.setLayout(new BorderLayout());\line \tab \tab myFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);\line \tab \tab myFrame.setVisible(true);\line \tab \tab \line \tab \tab \line \tab \}\line \tab \line \}\line }
\par }