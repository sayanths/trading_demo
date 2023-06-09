import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trading_app/core/color/color.dart';

gfontsubtitlefont(
    {double sz = 16,
    double ls = 0,
    FontWeight fw = FontWeight.normal,
    Color cl = Apc.black}) {
  return GoogleFonts.amaranth(
    fontSize: sz,
    letterSpacing: ls,
    fontWeight: fw,
    color: cl,
  );
}
