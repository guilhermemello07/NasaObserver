# NasaObserver

NasaObserver is a Native iOS application built with SwiftUI that fetches NASA’s Astronomy Picture of the Day (APOD) using the official API. The app displays images and videos (including interactive content via WebView), allows users to select dates via a calendar, mark APODs as favorites, and view details of each entry. It also includes features like image caching, haptic feedback using Core Haptics, and adaptive layouts for iPhone and iPad.

## Features

- **APOD Fetching:**  
  Retrieve the Astronomy Picture of the Day from NASA’s API for any date between June 16, 1995, and current calendar day.

- **Image & Video Support:**  
  Display both images and videos. When APOD returns interactive HTML pages or YouTube links for videos, they are rendered via WebView.

- **Favorites Management:**  
  Users can mark APODs as favorites. Favorited APODs are persisted locally, and the app will use cached information when the same date is revisited.

- **Calendar View:**  
  A graphical date picker allows users to select dates. The calendar is limited to dates starting from the first APOD (June 16, 1995).

- **Haptic Feedback:**  
  Custom haptic feedback is provided for actions such as liking, selecting dates, and deleting favorites using Core Haptics.

- **Adaptive Layout:**  
  The UI adapts to different device types (iPhone, iPad) and orientations.

- **Image Caching:**  
  Images are cached for faster loading and to serve as fallbacks when downloads fail.

## Requirements

- iOS 16.0 or later
- Xcode 14 or later
- Swift 5 and SwiftUI

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/guilhermemello07/NasaObserver.git

2.	Open the NasaObserver.xcodeproj file in Xcode.

3.	Build and run the project on your simulator or device.

## Usage

- **Main View:**  
  Browse the daily APOD. Use the calendar button in the toolbar to select a specific date. The app will fetch new data based on the selected date.

- **Media Handling:**  
  - Images are displayed via a caching mechanism that stores and reuses images for fast loading.  
  - Video and interactive content are loaded in a WebView to handle various edge cases.

- **Favorites:**  
  Mark APODs as favorites by tapping the like button or double-tapping images. Your favorites are saved locally and appear in a dedicated Favorites view. Tapping on a favorite navigates to a Details view.

- **Haptic Feedback:**  
  Custom haptic patterns provide tactile feedback when interacting with key actions such as liking, selecting a date, or deleting from favorites.

## Project Structure

- **MainView.swift:**  
  The primary view that displays the APOD for the selected date. It handles presenting the calendar sheet and shows media content (image or video) using dedicated subviews.

- **CalendarSheetView.swift:**  
  A graphical date picker that lets the user select a date (limited from June 16, 1995, to the current calendar day). The “Done” button overlays adaptively based on device orientation.

- **APOD.swift:**  
  The data model for APOD entries. It includes properties for image URLs, video URLs, thumbnail URLs (for video APODs), and favorite status. It also handles decoding from JSON.

- **APODService.swift:**  
  A service class responsible for fetching APOD data from NASA’s API. It builds the API URL (using the provided API key and formatted date) and decodes the JSON response into an APOD instance. It also checks for locally saved favorites before making a network call.

- **MainViewModel.swift:**  
  The view model that drives the MainView. It holds the currently displayed APOD, handles date changes, fetches data asynchronously, and synchronizes the favorite state by subscribing to changes in the FavoritesManager.

- **FavoritesManager.swift & FavoritesViewModel.swift:**  
  These classes manage the persistence of favorited APODs. FavoritesManager is a singleton that saves favorites to disk, while FavoritesViewModel subscribes to favorites changes for presentation in the Favorites view.

- **FavoritesView.swift & FavoritesCardView.swift:**  
  The Favorites view displays a list of favorited APODs. Each favorite is shown using FavoritesCardView, which displays a thumbnail image (or fallback) along with the title and a localized date (formatted using DateFormatterHelper).

- **ExpandedImageView.swift:**  
  A full-screen view that displays an APOD’s image. It uses CacheAsyncImage to load the image, and provides a dismiss button.

- **FallbackImageView.swift:**  
  A view that displays a fallback image when an image isn’t available. It observes a global cache (LastCachedImageManager) for the last cached image.

- **LikeablePictureView.swift:**  
  A view that displays an image APOD with like and long-press gestures. It uses CacheAsyncImage for caching, triggers haptic feedback on actions, and presents an ExpandedImageView when long-pressed.

- **VideoPlayerView.swift:**  
  A view that displays video or interactive content. (In the current configuration, it always uses a WebView to handle YouTube embeds, interactive pages, and other edge cases.)

- **HapticManager.swift:**  
  Provides custom haptic feedback using Core Haptics. It defines functions for like, select, and delete actions.

- **DateFormatterHelper.swift:**  
  A helper class to format dates between the API’s “yyyy-MM-dd” format and localized, user-friendly strings.

- **NObserverError.swift:**  
  A custom error enum for handling network and decoding errors.

- **Constants.swift:**  
  Defines various layout constants (e.g., image sizes, frame heights) used across the project.

- **Deviceidentifier.swift:**  
  Contains helper methods to detect the device type (iPad vs. iPhone) and adjust layouts accordingly.

## Credits
- [NASA Astronomy Picture of the Day API](https://api.nasa.gov/)
- Core Haptics, SwiftUI, and Combine for modern iOS development





