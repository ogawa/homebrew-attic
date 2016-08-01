require 'formula'

class Unzip < Formula
  homepage 'http://www.info-zip.org/pub/infozip/UnZip.html'
  url 'http://downloads.sourceforge.net/project/infozip/UnZip%206.x%20%28latest%29/UnZip%206.0/unzip60.tar.gz'
  version '6.0'
  sha256 "036d96991646d0449ed0aa952e4fbe21b476ce994abc276e49d30e686708bd37"

  def patches
    [
     "https://bugs.archlinux.org/task/15256?getfile=3685",
     DATA
    ]
  end

  def install
    system "make", "-f", "unix/Makefile", "generic"
    system "make", "-f", "unix/Makefile", "prefix=#{prefix}", "MANDIR=#{man}", "install"
  end

  test do
    system "#{bin}/unzip", "--help"
  end
end

__END__
diff --git a/unix/Makefile b/unix/Makefile
index ab32270..6611f1f 100644
--- a/unix/Makefile
+++ b/unix/Makefile
@@ -280,10 +280,10 @@ unzipsdocs:	unzips docs
 # make utilities if default:  change "unzip$E:" to "unzip$E:&"
 
 unzip$E:	$(OBJS) $(LIBBZ2)	# add `&' for parallel makes
-	$(LD) $(LF) -L$(IZ_BZIP2) $(LOBJS) $(L_BZ2) $(LF2)
+	$(LD) $(LF) -L$(IZ_BZIP2) $(LOBJS) $(L_BZ2) $(LF2) -liconv
 
 unzipsfx$E:	$(OBJX)			# add `&' for parallel makes
-	$(LD) $(SL) $(LOBJX) $(SL2)
+	$(LD) $(SL) $(LOBJX) $(SL2) -liconv
 
 funzip$E:	$(OBJF)			# add `&' for parallel makes
 	$(LD) $(FL) $(OBJF) $(FL2)
