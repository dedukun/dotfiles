// source:
// https://github.com/Intika-Linux-Apps/Gnome-Keyring-Tools/blob/master/gkey-check.c
// compile: cc gkey-check.c -o gkey-check -Wall -I/usr/include/gnome-keyring-1 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -lgnome-keyring -lglib-2.0
#include <gnome-keyring.h>
#include <stdio.h>

int main() {

  GnomeKeyringInfo *info;
  GnomeKeyringResult gkr;

  gkr = gnome_keyring_get_info_sync(NULL, &info);
  if (gkr != GNOME_KEYRING_RESULT_OK) {
    printf("error\n");
    return -1;
  }
  if (gnome_keyring_info_get_is_locked(info)) {
    printf("locked\n");
    return 0;
  } else {
    printf("unlocked\n");
    return -1;
  }
  gnome_keyring_info_free(info);
}
