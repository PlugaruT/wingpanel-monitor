project('com.github.plugarut.wingpanel-monitor', 'vala', 'c')

gnome = import('gnome')
i18n = import('i18n')

add_project_arguments(['--vapidir', join_paths(meson.current_source_dir(), 'vapi')], language: 'vala')
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language:'c')

# common dirs
prefix = get_option('prefix')
datadir = join_paths(prefix, get_option('datadir'))
libdir = join_paths(prefix, get_option('libdir'))
icondir = join_paths(datadir, 'icons', 'hicolor')

# deps
wingpanel = dependency('wingpanel-2.0')

icons_gresource = gnome.compile_resources(
    'gresource_icons',
    'data/icons/icons.indicator.gresource.xml',
    source_dir: 'data/icons',
    c_name: 'as'
)

executable(
    meson.project_name(),
    'src/Application.vala',
    'src/MainWindow.vala',
    'src/Toggles.vala',
    dependencies: [
        dependency('gee-0.8'),
        dependency('glib-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
        dependency('libgtop-2.0'),
        wingpanel,
        meson.get_compiler('c').find_library('m', required : false),
        meson.get_compiler('vala').find_library('posix')
    ],
    vala_args: [
        '--vapidir=' + meson.source_root() + '/vapi/',
    ],
    install: true
)

shared_module(
    'wingpanel-monitor',
    'src/Indicator.vala',
    'src/DisplayWidget.vala',
    'src/PopoverWidget.vala',
    'src/IndicatorWidget.vala',
    'src/cpu.vala',
    'src/Memory.vala',
    'src/Network.vala',
    'src/Utils.vala',
    icons_gresource,
    dependencies: [
        dependency('gee-0.8'),
        dependency('glib-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
        dependency('libgtop-2.0'),
        wingpanel,
        meson.get_compiler('c').find_library('m', required : false)
    ],
    install: true,
    install_dir : wingpanel.get_pkgconfig_variable('indicatorsdir', define_variable: ['libdir', libdir]),
)

subdir('data')
meson.add_install_script('meson/post_install.py')
