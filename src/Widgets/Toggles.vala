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
    public class TogglesWidget : Gtk.Grid {
        private Wingpanel.Widgets.Switch cpu_switch;
        private Wingpanel.Widgets.Switch ram_switch;
        private Wingpanel.Widgets.Switch network_switch;
        private Wingpanel.Widgets.Switch workspace_switch;

        private Wingpanel.Widgets.Switch indicator;

        public unowned Settings settings { get; construct set; }

        public TogglesWidget (Settings settings) {
            Object (settings: settings, hexpand: true);
        }

        construct {
            orientation = Gtk.Orientation.VERTICAL;

            cpu_switch = new Wingpanel.Widgets.Switch ("CPU usage", settings.get_boolean ("show-cpu"));
            ram_switch = new Wingpanel.Widgets.Switch ("RAM usage", settings.get_boolean ("show-ram"));
            network_switch = new Wingpanel.Widgets.Switch ("Network usage", settings.get_boolean ("show-network"));
            workspace_switch = new Wingpanel.Widgets.Switch (
                "Workspace number", settings.get_boolean ("show-workspace")
                );

            indicator = new Wingpanel.Widgets.Switch ("ON/OFF", settings.get_boolean ("display-indicator"));

            settings.bind ("display-indicator", indicator.get_switch (), "active", SettingsBindFlags.DEFAULT);

            settings.bind ("show-cpu", cpu_switch.get_switch (), "active", SettingsBindFlags.DEFAULT);
            settings.bind ("show-ram", ram_switch.get_switch (), "active", SettingsBindFlags.DEFAULT);
            settings.bind ("show-network", network_switch.get_switch (), "active", SettingsBindFlags.DEFAULT);
            settings.bind ("show-workspace", workspace_switch.get_switch (), "active", SettingsBindFlags.DEFAULT);

            add (indicator);
            add (new Wingpanel.Widgets.Separator ());
            add (cpu_switch);
            add (ram_switch);
            add (network_switch);
            add (workspace_switch);
            add (new Wingpanel.Widgets.Separator ());
        }
    }
}
