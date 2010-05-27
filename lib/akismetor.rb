# Included from http://github.com/levycarneiro/akismetor.git
#
# Copyright (c) 2008 Michael Hale
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


class Akismetor
  attr_accessor :attributes

  require 'net/http'

  # Does a key-check on Akismet so you know you can actually use a specific key.
  # Returns "valid" or "invalid" depending on response.
  def self.valid_key?(attributes)
    self.new(attributes).execute('verify-key')
  end

  # Does a comment-check on Akismet with the submitted hash.
  # Returns true or false depending on response.
  def self.spam?(attributes)
    self.new(attributes).execute('comment-check') != "false"
  end

  # Does a submit-spam on Akismet with the submitted hash.
  # Use this when Akismet incorrectly approves a spam comment.
  def self.submit_spam(attributes)
    self.new(attributes).execute('submit-spam')
  end

  # Does a submit-ham on Akismet with the submitted hash.
  # Use this for a false positive, when Akismet incorrectly rejects a normal comment.
  def self.submit_ham(attributes)
    self.new(attributes).execute('submit-ham')
  end

  def initialize(attributes)
    @attributes = attributes
  end

  def execute(command)
    host = "#{@attributes[:key]}." if attributes[:key] && command != 'verify-key'
    http = Net::HTTP.new("#{host}rest.akismet.com", 80)
    http.post("/1.1/#{command}", attributes_for_post, http_headers).body
  end

  private

  def http_headers
    {
      'User-Agent' => 'Akismetor Rails Plugin/1.1',
      'Content-Type' => 'application/x-www-form-urlencoded'
    }
  end

  def attributes_for_post
    result = attributes.map { |k, v| "#{k}=#{v}" }.join('&')
    URI.escape(result)
  end
end
