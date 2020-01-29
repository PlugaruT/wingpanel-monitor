/*-
 * Copyright (c) 2020 Tudor Plugaru (https://github.com/PlugaruT/wingpanel-monitor)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA.
 *
 * Authored by: Tudor Plugaru <plugaru.tudor@gmail.com>
 */


namespace WingpanelMonitor {
    public class DisplayWidget : Gtk.Grid {
        private GLib.Settings settings;
        private IndicatorWidget cpu_info;
        private IndicatorWidget ram_info;
        private IndicatorWidget upload_info;
        private IndicatorWidget download_info;

        construct {
            valign = Gtk.Align.CENTER;
            settings = new GLib.Settings ("com.github.plugarut.wingpanel-monitor");


            cpu_info = new IndicatorWidget ("utilities-system-monitor-symbolic", 4);
            ram_info = new IndicatorWidget ("utilities-system-monitor-symbolic", 4);
            upload_info = new IndicatorWidget ("go-up-symbolic", 8);
            download_info = new IndicatorWidget ("go-down-symbolic", 8);

            settings.bind ("show-cpu", cpu_info, "display", SettingsBindFlags.GET);
            settings.bind ("show-ram", ram_info, "display", SettingsBindFlags.GET);
            settings.bind ("show-network", upload_info, "display", SettingsBindFlags.GET);
            settings.bind ("show-network", download_info, "display", SettingsBindFlags.GET);

            add (cpu_info);
            add (ram_info);
            add (upload_info);
            add (download_info);
        }

        public void update_cpu (int val) {
            cpu_info.label_value = val.to_string () + "%";
        }

        public void update_memory (int val) {
            ram_info.label_value = val.to_string () + "%";
        }

        public void update_network (int upload, int download) {
            upload_info.label_value = WingpanelMonitor.Utils.format_net_speed (upload, true, false);
            download_info.label_value = WingpanelMonitor.Utils.format_net_speed (download, true, false);
        }
    }
}


