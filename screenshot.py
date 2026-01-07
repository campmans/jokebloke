#!/usr/bin/env python3
"""
Simple screenshot tool for capturing JokeBloke interface
"""
import subprocess
import time

def capture_screenshot(url, output_file, width=1920, height=1080):
    """Capture a screenshot using Firefox (works better in containers)"""
    try:
        # Try with Firefox/Geckodriver if available
        from selenium import webdriver
        from selenium.webdriver.firefox.options import Options
        
        firefox_options = Options()
        firefox_options.add_argument('--headless')
        firefox_options.add_argument(f'--width={width}')
        firefox_options.add_argument(f'--height={height}')
        
        driver = webdriver.Firefox(options=firefox_options)
        driver.get(url)
        time.sleep(3)
        driver.save_screenshot(output_file)
        print(f'✓ Screenshot saved: {output_file}')
        driver.quit()
    except Exception as e:
        print(f'✗ Selenium error: {e}')
        print('\nTrying alternative method with curl and wkhtmltoimage...')
        try:
            result = subprocess.run([
                'wkhtmltoimage',
                '--width', str(width),
                '--height', str(height),
                url,
                output_file
            ], capture_output=True, text=True)
            if result.returncode == 0:
                print(f'✓ Screenshot saved: {output_file}')
            else:
                print(f'✗ wkhtmltoimage failed: {result.stderr}')
        except FileNotFoundError:
            print('✗ wkhtmltoimage not found')
            print('\nPlease use your browser to take a manual screenshot of http://localhost:8866')

if __name__ == '__main__':
    capture_screenshot('http://localhost:8866', 'jokebloke_screenshot.png', 1920, 1080)
