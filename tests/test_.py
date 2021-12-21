import unittest


class TestTrue(unittest.TestCase):
    def test_true(self):
        self.assertEqual(1, 1)


if __name__ == "__main__":
    unittest.main()
