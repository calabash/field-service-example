# Xamarin & Calabash Example

This repository contains a simple example of using Calabash with a cross-platform Xamarin app: FieldService. This can provide a starting point for Xamarin users wishing to try out Calabash.

## Prerequisites

You must have Xamarin (for iOS and/or Android) and Xamarin Studio installed. In addition Calabash must be installed which includes the following

* Ruby 1.9.3 or 2.0 - We recommend using [rbenv](https://github.com/sstephenson/rbenv/#installation) and [ruby-build](https://github.com/sstephenson/ruby-build) to manage Ruby installations. Then you can just run: `rbenv install 1.9.3-p392` and `rbenv global 1.9.3-p392`

* bundler `gem install bundler` in the FieldService directory


If you're using rbenv make sure to run `rbenv rehash` after that to update your rbenv shims.

* Calabash and other dependencies `bundle install` (takes a while first time)

## Running the login feature on iPad

From within Xamarin studio: Build the iOS app for iPad simulator in debug mode.

This should create the app as: `FieldService.iOS/bin/iPhoneSimulator/Debug/FieldServiceiOS.app`.


Run the login spec for iOS:

    bundle exec cucumber -p ios features/login.feature
    Using the ios profile...
    Feature: Login

      Scenario: Login with valid user              # features/login.feature:3
      Waiting for App to be ready
        Given I am on the Login screen             # features/step_definitions/login_steps.rb:2
        When I login as "Nat"                      # features/step_definitions/login_steps.rb:7
        Then I should go to the Assignments screen # features/step_definitions/login_steps.rb:12

        Scenario: Login with invalid user        # features/login.feature:9
        Waiting for App to be ready
         Given I am on the Login screen         # features/step_definitions/login_steps.rb:2
         When I login as "Invalid"              # features/step_definitions/login_steps.rb:7
         Then I should not be logged in         # features/step_definitions/login_steps.rb:17
         Expected LoginScreen screen but was AssignmentsScreen (RuntimeError)
          ./features/support/entry_points.rb:22:in `assert_screen'
          ./features/step_definitions/login_steps.rb:18:in `/^I should not be logged in$/'
          features/login.feature:12:in `Then I should not be logged in'
         And I should see a login error message # features/step_definitions/login_steps.rb:21

    Failing Scenarios:
    cucumber -p ios features/login.feature:9 # Scenario: Login with invalid user

    2 scenarios (1 failed, 1 passed)
    7 steps (1 failed, 1 skipped, 5 passed)
    0m18.388s


## Running the login feature on Android tablet emulator

Ensure the following before starting.

* You should have the Android SDK installed and the environment variable ANDROID_HOME should be pointing to it.

* Android tablet emulator. From inside Xamarin Studio - select Tools > Open AVD Manager. Create a New emulator named "tablet" with Device: 7.0" WSVAG (Tablet) 1024x600 mdpi, API Level 17. (You may need to ensure you have Google APIs installed for all SDKs - From AVC, select Tools > Manage SDK and install Google APIs).

* Start the tablet emulator (and continue because that will take some time!)

* (Alternatively: plug-in an Android tablet via USB - this often faster than emulators)


### Resigning your app with the debug keystore
We've prebuilt the Android binary `.apk` file: `FieldService.Android.apk` but you'll need to resign it with your debug keystore `~/.android/debug.keystore`.

We've included a script `resign.sh` which can do this:

    krukow:~/github/field-service-example$ ./resign.sh FieldService.Android.apk
    /tmp/tmp_path_for_resigned.apk
    rm: /tmp/tmp_path_for_resigned.apk: No such file or directory
    deleting: META-INF/MANIFEST.MF
    deleting: META-INF/ANDROIDD.SF
    deleting: META-INF/ANDROIDD.RSA


### Run the test on Android tablet!

    krukow:~/github/field-service-example$ bundle exec calabash-android run FieldService.Android/FieldService.Android.apk -p android features/login.feature
    Using the android profile...
    Feature: Login

      Scenario: Login with valid user              # features/login.feature:3
    Starting: Intent { act=android.intent.action.MAIN cmp=FieldService.Android.test/sh.calaba.instrumentationbackend.WakeUp }
        Given I am on the Login screen             # features/step_definitions/login_steps.rb:2
        When I login as "Nat"                      # features/step_definitions/login_steps.rb:7
        Then I should go to the Assignments screen # features/step_definitions/login_steps.rb:12

      Scenario: Login with invalid user        # features/login.feature:9
        Given I am on the Login screen         # features/step_definitions/login_steps.rb:2
        When I login as "Invalid"              # features/step_definitions/login_steps.rb:7
        Then I should not be logged in         # features/step_definitions/login_steps.rb:17
          Expected LoginScreen screen but was AssignmentsScreen (RuntimeError)
          ./features/support/entry_points.rb:22:in `assert_screen'
          ./features/step_definitions/login_steps.rb:18:in `/^I should not be logged in$/'
          features/login.feature:12:in `Then I should not be logged in'
        And I should see a login error message # features/step_definitions/login_steps.rb:21

    Failing Scenarios:
    cucumber -p android features/login.feature:9 # Scenario: Login with invalid user

    2 scenarios (1 failed, 1 passed)
    7 steps (1 failed, 1 skipped, 5 passed)
    1m10.710s
