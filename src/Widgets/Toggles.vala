/*-
 * Copyright (c) 2021 Tudor Plugaru (https://github.com/PlugaruT/wingpanel-monitor)
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
 *              Anderson Laverde <anderson.laverde@zohomail.com>
 */

namespace WingpanelMonitor {
    public class TogglesWidget : Gtk.Grid {
        private Granite.SwitchModelButton cpu_switch;
        private Granite.SwitchModelButton ram_switch;
        private Granite.SwitchModelButton network_switch;
        private Granite.SwitchModelButton workspace_switch;
        private Granite.SwitchModelButton weather_switch;
        private Granite.SwitchModelButton icon_only_switch;
        private Granite.SwitchModelButton indicator;
        private SpinRow weather_refresh_spin;
        public unowned Settings settings { get; set; }

        public TogglesWidget (Settings settings) {
            Object (settings: settings, hexpand: true);
        }

        construct {
            orientation = Gtk.Orientation.VERTICAL;
            indicator = new Granite.SwitchModelButton ("ON/OFF") {
                active = settings.get_boolean ("display-indicator")
            };
            cpu_switch = new Granite.SwitchModelButton ("CPU usage") {
                active = settings.get_boolean ("show-cpu")
            };
            icon_only_switch = new Granite.SwitchModelButton ("Show icon") {
                active = settings.get_boolean ("icon-only")
            };
            ram_switch = new Granite.SwitchModelButton ("RAM usage") {
                active = settings.get_boolean ("show-ram")
            };
            network_switch = new Granite.SwitchModelButton ("Network usage") {
                active = settings.get_boolean ("show-network")
            };
            workspace_switch = new Granite.SwitchModelButton ("Workspace number") {
                active = settings.get_boolean ("show-workspace")
            };
            weather_switch = new Granite.SwitchModelButton ("Weather for %s".printf (settings.get_string ("weather-location"))) {
                active = settings.get_boolean ("show-weather")
            };
            
            settings.bind ("display-indicator", indicator, "active", SettingsBindFlags.DEFAULT);
            settings.bind ("show-cpu", cpu_switch, "active", SettingsBindFlags.DEFAULT);
            settings.bind ("show-ram", ram_switch, "active", SettingsBindFlags.DEFAULT);
            settings.bind ("show-network", network_switch, "active", SettingsBindFlags.DEFAULT);
            settings.bind ("show-workspace", workspace_switch, "active", SettingsBindFlags.DEFAULT);
            settings.bind ("show-weather", weather_switch, "active", SettingsBindFlags.DEFAULT);
            settings.bind ("icon-only", icon_only_switch, "active", SettingsBindFlags.DEFAULT);


            weather_refresh_spin = new SpinRow ("Weather refresh rate (min)", 1, 60);
            weather_refresh_spin.set_spin_value (settings.get_int ("weather-refresh-rate"));
            weather_refresh_spin.changed.connect ( () => {
                settings.set_int ("weather-refresh-rate", weather_refresh_spin.get_spin_value ());
            });

            add (indicator);
            add (new Gtk.Separator (Gtk.Orientation.HORIZONTAL));
            add (icon_only_switch);
            add (cpu_switch);
            add (ram_switch);
            add (network_switch);
            add (workspace_switch);
            add (weather_switch);
            add (new Gtk.Separator (Gtk.Orientation.HORIZONTAL));
            add (weather_refresh_spin);
        }
    }
}
