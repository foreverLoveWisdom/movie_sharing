# frozen_string_literal: true

require 'rails_helper'

RSpec.describe YoutubeIdParser do
  describe '.parse' do
    context 'when parse successfully' do
      context 'with a valid YouTube URL' do
        let(:url) { 'https://www.youtube.com/watch?v=dQw4w9WgXcQ' }

        it 'returns the YouTube ID' do
          expect(described_class.parse(url)).to eq('dQw4w9WgXcQ')
        end
      end

      context 'with a shortened YouTube URL' do
        let(:url) { 'https://youtu.be/dQw4w9WgXcQ' }

        it 'returns the YouTube ID' do
          expect(described_class.parse(url)).to eq('dQw4w9WgXcQ')
        end
      end

      context 'with a YouTube URL with additional query parameters' do
        let(:url) { 'https://www.youtube.com/watch?v=dQw4w9WgXcQ&t=123' }

        it 'returns the YouTube ID' do
          expect(described_class.parse(url)).to eq('dQw4w9WgXcQ')
        end
      end

      context 'with a YouTube URL with whitespace before and after the URL' do
        let(:url) { ' https://www.youtube.com/watch?v=dQw4w9WgXcQ ' }

        it 'returns the YouTube ID' do
          expect(described_class.parse(url)).to eq('dQw4w9WgXcQ')
        end
      end

      context 'with a YouTube URL without the www. prefix' do
        let(:url) { 'https://youtube.com/watch?v=dQw4w9WgXcQ' }

        it 'returns the YouTube ID' do
          expect(described_class.parse(url)).to eq('dQw4w9WgXcQ')
        end
      end

      context 'with a mobile YouTube URL' do
        let(:url) { 'https://m.youtube.com/watch?v=dQw4w9WgXcQ' }

        it 'returns the YouTube ID' do
          expect(described_class.parse(url)).to eq('dQw4w9WgXcQ')
        end
      end

      context 'with a hyphenated YouTube video ID' do
        let(:url) { 'https://www.youtube.com/watch?v=dQw4w9WgX-c' }

        it 'returns the YouTube ID' do
          expect(described_class.parse(url)).to eq('dQw4w9WgX-c')
        end
      end
    end

    context 'when parse fails' do
      context 'with an invalid YouTube URL' do
        let(:url) { 'https://www.example.com' }

        it 'raises an InvalidUrlError' do
          expect { described_class.parse(url) }.to raise_error(YoutubeIdParser::InvalidUrlError, 'Invalid URL: https://www.example.com')
        end
      end

      context 'with a YouTube URL without an ID' do
        let(:url) { 'https://www.youtube.com/' }

        it 'raises an InvalidUrlError' do
          expect { described_class.parse(url) }.to raise_error(YoutubeIdParser::InvalidUrlError, 'Invalid URL: https://www.youtube.com/')
        end
      end

      context 'with an invalid YouTube ID' do
        let(:url) { 'https://www.youtube.com/watch?v=invalid' }

        it 'raises an InvalidUrlError' do
          expect { described_class.parse(url) }.to raise_error(YoutubeIdParser::InvalidUrlError, 'Invalid URL: https://www.youtube.com/watch?v=invalid')
        end
      end

      context 'with a YouTube URL with an uppercase video ID' do
        let(:url) { 'https://www.youtube.com/watch?v=DQW4W9WGXcq' }

        it 'returns the YouTube ID' do
          expect(described_class.parse(url)).to eq('DQW4W9WGXcq')
        end
      end

      context 'with a YouTube URL containing an invalid video ID in query params' do
        let(:url) { 'https://www.youtube.com/watch?v=invalid&foo=bar' }

        it 'raises an InvalidUrlError' do
          expect { described_class.parse(url) }.to raise_error(YoutubeIdParser::InvalidUrlError, 'Invalid URL: https://www.youtube.com/watch?v=invalid&foo=bar')
        end
      end
    end
  end
end
