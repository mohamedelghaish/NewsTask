# News App

## Overview

A simple iOS app demonstrating the use of MVVM architecture, URLSession networking, Core Data for local persistence, and Combine for reactive programming. The app fetches news articles from the News API, allows users to view article details, and save favorites locally. Built using UIKit and Nib files for the interface.

## Features

Home Screen: Lists articles fetched from the News API with a UISearchBar and UIDatePicker for filtering by search term and date.
Details Screen: Displays selected article details and provides an option to save the article as a favorite in Core Data.
Favorites Screen: Lists saved articles stored in Core Data for quick access.
Tech Stack

 Architecture: MVVM
Networking: URLSession
Reactive Programming: Combine
Persistence: Core Data
UI Framework: UIKit with Nib files
Version Control: Git & GitHub (Git Flow for branching)

## App Workflow

Data Fetching: The app fetches articles from the News API and displays them on the Home Screen.
Navigation to Details Screen: When a user taps an article card, they navigate to the Details Screen to view more information.
Saving to Core Data: On the Details Screen, a button allows the user to save the article as a favorite in Core Data.
Dismissal and Success Notification: Upon successful save, the Details Screen dismisses, returning to the Home Screen, where a success alert confirms the addition.
Viewing Favorites: The user can access saved articles in the Favorites Screen.
Getting Started

## Prerequisites
Xcode 14 or later
iOS 14.0 or later
A valid API key for the News API
