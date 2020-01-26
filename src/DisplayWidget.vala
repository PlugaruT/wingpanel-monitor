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

        construct {
            settings = new GLib.Settings ("com.github.plugarut.wingpanel-monitor");

            var cpu_info = new IndicatorWidget ("utilities-system-monitor-symbolic");
            var ram_info = new IndicatorWidget ("utilities-system-monitor-symbolic");
            var upload_info = new IndicatorWidget ("go-up-symbolic");
            var download_info = new IndicatorWidget ("go-down-symbolic");

            settings.bind ("show-cpu", cpu_info, "display", SettingsBindFlags.GET);
            settings.bind ("show-ram", ram_info, "display", SettingsBindFlags.GET);
            settings.bind ("show-network", upload_info, "display", SettingsBindFlags.GET);
            settings.bind ("show-network", download_info, "display", SettingsBindFlags.GET);

            add (cpu_info);
            add (ram_info);
            add (upload_info);
            add (download_info);
        }
    }
}


